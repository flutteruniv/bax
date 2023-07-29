import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common_widgets/bax_indicator.dart';
import '../../../configs/localizations.dart';
import '../../authentication/application/auth_service.dart';
import '../../measurement_wifi/data/measurement_wifi_repository.dart';
import '../../payment/presentation/block_feature_widget.dart';
import '../../payment/repository/payment_repository.dart';
import '../data/facility_repository.dart';

class FacilityDetailsWidget extends ConsumerStatefulWidget {
  const FacilityDetailsWidget({
    super.key,
    required this.docId,
    required this.controller,
  });

  final String docId;
  final ScrollController controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FacilityPageState();
}

class _FacilityPageState extends ConsumerState<FacilityDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    final isPro = ref.watch(isProProvider);
    final facility = ref.watch(facilityProvider(widget.docId));
    final textTheme = Theme.of(context).textTheme;
    final uid = ref.watch(uidProvider);
    final measurementWifiResults = ref.watch(measurementWifiResultsForFacility(widget.docId)).value ?? [];
    final l = ref.watch(localizationsProvider);

    if (facility == null) {
      return const Center(
        child: BaxIndicator(),
      );
    }

    return SingleChildScrollView(
      controller: widget.controller,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Container(
                height: 4,
                width: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[300],
                ),
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                facility.data().name,
                maxLines: 1,
                style: const TextStyle(
                  height: 1.2,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              facility.data().address,
              maxLines: 1,
              style: textTheme.bodySmall,
            ),
            const SizedBox(
              height: 16,
            ),
            DownloadUploadIndTile(
              downloadSpeed: facility.data().downloadSpeed,
              uploadSpeed: facility.data().uploadSpeed,
            ),
            const SizedBox(height: 16),
            PowerTile(
              hasPowerSpotUserSelect: facility.data().hasPowerSpotUserSelect(uid ?? ''),
              hasPowerSpot: isPro ? facility.data().haaPowerSpot : null,
              onTapPower: () {
                if (uid == null) {
                  return;
                }
                if (facility.data().hasPowerSource.contains(uid)) {
                  facility.reference.set(
                    facility.data().copyWith(
                      hasPowerSource: {
                        for (final e in facility.data().hasPowerSource)
                          if (e != uid) e
                      },
                    ),
                  );
                } else {
                  facility.reference.set(
                    facility.data().copyWith(
                      hasPowerSource: {
                        ...facility.data().hasPowerSource,
                        uid,
                      },
                    ),
                  );
                }
              },
              onTapNoPower: () {
                if (uid == null) {
                  return;
                }
                if (facility.data().noPowerSource.contains(uid)) {
                  facility.reference.set(
                    facility.data().copyWith(
                      noPowerSource: {
                        for (final e in facility.data().noPowerSource)
                          if (e != uid) e
                      },
                    ),
                  );
                } else {
                  facility.reference.set(
                    facility.data().copyWith(
                      noPowerSource: {
                        ...facility.data().noPowerSource,
                        uid,
                      },
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Icon(
                  Icons.wifi_outlined,
                  // color: activeColor,
                ),
                Expanded(
                  child: Text(
                    l.measurementHistory,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      // color: activeColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Stack(
              children: [
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: measurementWifiResults.length,
                    itemBuilder: (context, index) {
                      final wifiMeasurementResult = measurementWifiResults[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('yyyy/MM/dd HH:mm').format(wifiMeasurementResult.terminalTime.dateTime!),
                              style: textTheme.bodySmall,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                ' ${wifiMeasurementResult.ssid} : ↓${wifiMeasurementResult.downloadSpeedMbps}Mbps ↑${wifiMeasurementResult.uploadSpeedMbps}Mbps',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                BlockFeatureWidget(
                  width: double.infinity,
                  height: 160,
                  text: l.viewMeasurementHistory,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  final url = 'https://www.google.com/maps/search/?api=1&query=${facility.data().name}';
                  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                },
                child: Text(l.showInMapApp),
              ),
            ),
            const SizedBox(height: 56),
          ],
        ),
      ),
    );
  }
}

class PowerTile extends ConsumerWidget {
  const PowerTile({
    super.key,
    required this.hasPowerSpotUserSelect,
    required this.hasPowerSpot,
    required this.onTapNoPower,
    required this.onTapPower,
  });

  final bool? hasPowerSpot;
  final bool? hasPowerSpotUserSelect;
  final void Function() onTapPower;
  final void Function() onTapNoPower;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPro = ref.watch(isProProvider);
    final l = ref.watch(localizationsProvider);
    final activeColor = Colors.yellow[800];
    final nonActiveColor = Colors.grey[300];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.electrical_services_outlined,
              color: activeColor,
            ),
            Text(
              l.powerSource,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: activeColor,
              ),
            ),
            const SizedBox(width: 8),
            if (!isPro)
              Expanded(
                child: Text(
                  l.viewableWithProPlan,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 120,
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onTapPower,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: (hasPowerSpotUserSelect != true)
                              ? null
                              : (hasPowerSpot == true)
                                  ? activeColor
                                  : nonActiveColor,
                          border: Border.all(
                            width: 4,
                            color: hasPowerSpot == true ? activeColor! : nonActiveColor!,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.power_outlined,
                                color: hasPowerSpotUserSelect == true
                                    ? Colors.white
                                    : hasPowerSpot == true
                                        ? activeColor!
                                        : nonActiveColor!,
                                size: 80,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: InkWell(
                      onTap: onTapNoPower,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: (hasPowerSpotUserSelect != false)
                              ? null
                              : (hasPowerSpot == false)
                                  ? activeColor
                                  : nonActiveColor,
                          border: Border.all(
                            width: 4,
                            color: hasPowerSpot == false ? activeColor! : nonActiveColor!,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.power_off_outlined,
                              color: hasPowerSpotUserSelect == false
                                  ? Colors.white
                                  : hasPowerSpot == false
                                      ? activeColor!
                                      : nonActiveColor!,
                              size: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DownloadUploadIndTile extends ConsumerWidget {
  const DownloadUploadIndTile({
    super.key,
    required this.downloadSpeed,
    required this.uploadSpeed,
  });

  final double downloadSpeed;
  final double uploadSpeed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(localizationsProvider);
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: DefaultTextStyle(
                style: TextStyle(color: Colors.blue[900]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.download_outlined,
                          color: Colors.blue[900],
                        ),
                        const Expanded(
                          child: Text(
                            'ダウンロード',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: downloadSpeed != 0.0 ? '$downloadSpeed' : '??.?',
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                            const TextSpan(
                              text: 'Mbps',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: DefaultTextStyle(
                style: TextStyle(color: Colors.red[900]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.upload_outlined,
                          color: Colors.red[900],
                        ),
                        const Expanded(
                          child: Text(
                            'アップロード',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: uploadSpeed != 0.0 ? '$uploadSpeed' : '??.?',
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                            const TextSpan(text: 'Mbps'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        BlockFeatureWidget(
          width: double.infinity,
          height: 80,
          text: l.viewWifiSpeed,
        ),
      ],
    );
  }
}
