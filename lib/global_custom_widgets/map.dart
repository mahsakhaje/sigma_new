import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:sigma/helper/colors.dart';
import 'dart:math';

import '../pages/branches/branches_controller.dart';

class MapScreen extends GetView<BranchesController> {
  final BranchesController controller = Get.put(BranchesController());
  double _scaleStart = 1.0;


  void _onScaleStart(ScaleStartDetails details) {
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details, MapTransformer transformer) {
    if (details.scale != _scaleStart) {
      final scaleDiff = details.scale - _scaleStart;
      _scaleStart = details.scale;
      controller.handleScaleUpdate(scaleDiff, details.localFocalPoint, transformer);
    }
  }

  Widget _buildMarkerWidget(Offset pos, Color color) {
    return Positioned(
      left: pos.dx - 25,
      top: pos.dy - 50,
      child: GestureDetector(
        onTap: () {
          // Handle marker tap if needed
        },
        child: Icon(
          Icons.location_on,
          color: color,
          size: 50,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        controller.mapController.center = controller.currentCenter.value;
        controller.mapController.zoom = controller.currentZoom.value;

        return MapLayout(
          controller: controller.mapController, // Use the same instance
          builder: (context, transformer) {
            final markerPositions = controller.markers
                .map((marker) => transformer.toOffset(marker))
                .toList();

            final markerWidgets = markerPositions
                .map((pos) => _buildMarkerWidget(pos, Colors.red))
                .toList();

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: _onScaleStart,
              onScaleUpdate: (details) => _onScaleUpdate(details, transformer),
              child: Stack(
                children: [
                  // Map tiles layer
                  Listener(
                    behavior: HitTestBehavior.opaque,
                    onPointerSignal: (event) {
                      if (event is PointerScrollEvent) {
                        controller.handleScrollEvent(
                          event.scrollDelta.dy,
                          event.localPosition,
                          transformer,
                        );
                      }
                    },
                    child: TileLayer(
                      builder: (context, x, y, z) {
                        final tilesInZoom = pow(2.0, z).floor();

                        // Handle negative coordinates
                        while (x < 0) {
                          x += tilesInZoom;
                        }
                        while (y < 0) {
                          y += tilesInZoom;
                        }

                        x %= tilesInZoom;
                        y %= tilesInZoom;

                        return Image.network(
                          mapbox(z, x, y),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.error),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // Zoom controls
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildZoomButton(
                          icon: Icons.add,
                          onPressed: controller.zoomIn,
                        ),
                        const SizedBox(height: 8),
                        _buildZoomButton(
                          icon: Icons.remove,
                          onPressed: controller.zoomOut,
                        ),
                      ],
                    ),
                  ),
                  ...markerWidgets,
                ],
              ),
            );
          },
        );
      }),
    );
  }
  }

  Widget _buildZoomButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 4,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.blue,
          ),
        ),
      ),
    );
  }


String mapbox(int z, int x, int y) {
  //Mapbox Streets
  final url = 'https://pm2.parsimap.com/comapi.svc/tile/parsimap/$x/$y/$z/a8e721a4-abbb-4849-8ec2-3262826a6e6e';
  return url;
}

String token = 'https://pm2.parsimap.com/comapi.svc/tile/parsimap/{x}/{y}/{z}/a8e721a4-abbb-4849-8ec2-3262826a6e6e';