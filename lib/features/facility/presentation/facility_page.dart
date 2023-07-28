import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common_widgets/bax_indicator.dart';
import '../../authentication/application/auth_service.dart';
import '../../measurement_wifi/data/measurement_wifi_repository.dart';
import '../data/facility_repository.dart';

class FacilityPage extends ConsumerStatefulWidget {
  const FacilityPage({
    super.key,
    required this.docId,
  });

  static const route = 'facility';
  final String docId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FacilityPageState();
}

class _FacilityPageState extends ConsumerState<FacilityPage> {
  @override
  Widget build(BuildContext context) {
    final facility = ref.watch(facilityProvider(widget.docId));
    final textTheme = Theme.of(context).textTheme;
    final uid = ref.watch(uidProvider);

    final measurementWifiResults = ref.watch(measurementWifiResultsForFacility(widget.docId)).value ?? [];

    return Scaffold(
      appBar: AppBar(),
      body: facility == null
          ? const Center(
              child: BaxIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      facility.data().name,
                      style: const TextStyle(
                        height: 1.2,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      facility.data().address,
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    DownloadUploadIndTile(
                      downloadSpeed: facility.data().downloadSpeed,
                      uploadSpeed: facility.data().uploadSpeed,
                    ),
                    const SizedBox(height: 16),
                    PowerTile(
                      hasPowerSpotUserSelect: facility.data().hasPowerSpotUserSelect(uid ?? ''),
                      hasPowerSpot: facility.data().haaPowerSpot,
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
                    const Row(
                      children: [
                        Icon(
                          Icons.wifi_outlined,
                          // color: activeColor,
                        ),
                        Expanded(
                          child: Text(
                            '計測履歴',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              // color: activeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 200,
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
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () async {
                          final url = 'https://www.google.com/maps/search/?api=1&query=${facility.data().name}';
                          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                        },
                        child: const Text('マップアプリで表示'),
                      ),
                    ),
                    const SizedBox(height: 56),
                  ],
                ),
              ),
            ),
    );
  }
}

class PowerTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
            Expanded(
              child: Text(
                '電源',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: activeColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 120,
          child: Row(
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
        ),
      ],
    );
  }
}

class DownloadUploadIndTile extends StatelessWidget {
  const DownloadUploadIndTile({
    super.key,
    required this.downloadSpeed,
    required this.uploadSpeed,
  });

  final double downloadSpeed;
  final double uploadSpeed;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                          text: '$downloadSpeed',
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
                          text: '$uploadSpeed',
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        const TextSpan(text: 'Mpbs'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
