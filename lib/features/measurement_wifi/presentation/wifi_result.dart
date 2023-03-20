import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../authentication/application/auth_service.dart';
import '../../bax/presentation/bax_reward_dialog.dart';
import '../../map/domain/nearby_search_results/nearby_search_result.dart';
import '../application/measurement_wifi_service.dart';
import '../data/measurement_wifi_repository.dart';
import '../domain/fast_net_result.dart';

class WiFiResultDialog extends ConsumerStatefulWidget {
  const WiFiResultDialog({
    super.key,
    required this.ssid,
    required this.fastNetResult,
    required this.nearbySearchResult,
  });

  final String ssid;
  final FastNetResult fastNetResult;
  final NearbySearchResult nearbySearchResult;

  @override
  ConsumerState<WiFiResultDialog> createState() => _WiFiResultDialogState();
}

class _WiFiResultDialogState extends ConsumerState<WiFiResultDialog> {
  final globalKey = GlobalKey<State<StatefulWidget>>();
  bool canPostResult = false;
  Uint8List? googleMapImage;
  GoogleMapController? googleMapController;

  Future<void> confirmRightToPost() async {
    canPostResult = await ref.read(measurementWifiRepositoryProvider).hasTodayData(
          placeId: widget.nearbySearchResult.placeId,
          today: DateTime.now().toUtc(),
          uid: ref.read(uidProvider).valueOrNull ?? '',
        );
    setState(() {});
  }

  Future<XFile?> widgetToImage() async {
    googleMapImage = await googleMapController?.takeSnapshot(); // its our screenshot
    if (googleMapImage == null) {
      return null;
    }
    setState(() {});
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );
    final boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) {
      return null;
    }
    final image = await boundary.toImage(pixelRatio: 2);
    final bytes = await image.toByteData(format: ImageByteFormat.png);
    return XFile.fromData(
      bytes!.buffer.asUint8List(),
      name: 'wifi-result-image.png',
      mimeType: 'image/png',
    );
  }

  Future<void> share() async {
    final xFile = await widgetToImage();
    if (xFile == null) {
      return;
    }
    await Share.shareXFiles([xFile]);
  }

  @override
  void initState() {
    super.initState();
    confirmRightToPost();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RepaintBoundary(
            key: globalKey,
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: size.width * 0.8,
              height: size.height * 0.6,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      width: size.width * 0.8,
                      height: size.height * 0.6,
                      child: GoogleMap(
                        mapToolbarEnabled: false,
                        rotateGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        myLocationButtonEnabled: false,
                        compassEnabled: false,
                        onMapCreated: (controller) async {
                          googleMapController = controller;
                        },
                        markers: {
                          Marker(
                            markerId: const MarkerId('id'),
                            position: LatLng(
                              widget.nearbySearchResult.geometry.location.latitude,
                              widget.nearbySearchResult.geometry.location.longitude,
                            ),
                          ),
                        },
                        initialCameraPosition: CameraPosition(
                          zoom: 16,
                          target: LatLng(
                            widget.nearbySearchResult.geometry.location.latitude + 0.002,
                            widget.nearbySearchResult.geometry.location.longitude,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 背景の地図部分
                  if (googleMapImage != null) Image.memory(googleMapImage!),

                  // 吹き出し
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 128),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/balloon.png',
                            color: Colors.white.withOpacity(0.9),
                            colorBlendMode: BlendMode.modulate,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                  ),
                                  child: Text(
                                    widget.nearbySearchResult.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.fastNetResult.downloadSpeedMbps.toStringAsFixed(1),
                                      style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Text(
                                      'Mbps',
                                      style: TextStyle(fontSize: 16, height: 3),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(widget.fastNetResult.rank, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 2),
                                      child: Image.asset(
                                        'assets/images/star.png',
                                        width: 32,
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                SizedBox(height: 16),
              ],
            ),
          ),
          if (canPostResult)
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 240,
                    height: 40,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        final bax = await ref.read(measurementWifiServiceProvider).postMeasurementResult(
                              widget.ssid,
                              widget.fastNetResult,
                              widget.nearbySearchResult,
                            );
                        if (!mounted) {
                          return;
                        }

                        Navigator.of(context).pop();

                        if (bax == null) {
                          return;
                        }
                        await showDialog<void>(
                          context: context,
                          builder: (context) {
                            return BaxRewordDialog(bax: bax);
                          },
                        );
                      },
                      label: const Text('この結果を投稿する'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 240,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: Navigator.of(context).pop,
                      child: const Text('またあとで'),
                    ),
                  ),
                  const SizedBox(height: 80),
                  SizedBox(
                    width: 240,
                    height: 40,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.share),
                      onPressed: share,
                      label: const Text('結果を共有'),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
