import 'dart:collection';
import 'dart:ui';

// map_screen.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helper/dio_repository.dart';
import '../../models/showrooms_unites_model.dart';

class BranchesController extends GetxController {
  // Constants for zoom limits
  static const double MIN_ZOOM = 8.0;
  static const double MAX_ZOOM = 18.0;
  static const double DEFAULT_ZOOM = 14.0;

  // Observable variables
  final RxBool isLoading = true.obs;
  final RxBool showDialog = false.obs;
  final RxInt selectedBranchIndex = 0.obs;
  final RxInt selectedCityIndex = 0.obs;
  final RxDouble selectedLat = 0.0.obs;
  final RxDouble selectedLong = 0.0.obs;

  // Make map controller properties reactive
  final RxDouble currentZoom = DEFAULT_ZOOM.obs;
  final Rx<LatLng> currentCenter = const LatLng(Angle.degree(35.6892), Angle.degree(51.3890)).obs;

  // Map controller and markers
  late MapController mapController;
  final RxList<LatLng> markers = <LatLng>[].obs;

  // Data
  final RxMap<String, String> cities = <String, String>{}.obs;
  final RxMap<String, List<Units>?> branches = <String, List<Units>?>{}.obs;
  final RxList<Units> branchesInDialog = <Units>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeMap();
    loadBranches();
  }

  void _initializeMap() {
    mapController = MapController(
      location: currentCenter.value,
      zoom: currentZoom.value,
    );
    markers.add(currentCenter.value);
  }

  Future<void> loadBranches() async {
    try {
      isLoading.value = true;
      await _fetchCities();
      await _fetchBranchesForAllCities();
      _initializeDefaultSelection();
      showDialog.value = true;
    } catch (e) {
      Get.snackbar('خطا', 'خطا در بارگذاری اطلاعات شعب');
      print('Error loading branches: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchCities() async {
    final response = await DioClient.instance.getShowroomCities();
    if (response?.message == 'OK') {
      final tempMap = <String, String>{};

      // First, find Tehran and add it first
      final tehran = response?.geoNames?.firstWhere(
            (e) => e.description == 'تهران',
        orElse: () => response!.geoNames!.first,
      );

      if (tehran != null) {
        tempMap[tehran.id ?? ''] = tehran.description ?? '';
      }

      // Add the rest, skipping Tehran if already added
      response?.geoNames?.forEach((element) {
        if (element.description != 'تهران') {
          tempMap[element.id ?? ''] = element.description ?? '';
        }
      });

      // Clear the old cities map and insert in order
      cities
        ..clear()
        ..addAll(LinkedHashMap.from(tempMap));
    }
  }

  Future<void> _fetchBranchesForAllCities() async {
    for (String cityId in cities.keys) {
      final response = await DioClient.instance.getShowRoomUnites(cityId);
      if (response?.message == 'OK') {
        branches[cities[cityId] ?? ''] = response?.units;
      }
    }
  }

  void _initializeDefaultSelection() {
    if (cities.isNotEmpty) {
      selectCity(0);
    }
  }

  void selectCity(int index) {
    selectedCityIndex.value = index;
    selectedBranchIndex.value = 0;

    final cityName = cities.values.elementAt(index);
    final cityBranches = branches[cityName];

    if (cityBranches != null && cityBranches.isNotEmpty) {
      branchesInDialog.assignAll(cityBranches);
      _updateMapLocation(0);
    }
  }

  void selectBranch(int index) {
    selectedBranchIndex.value = index;
    _updateMapLocation(index);
  }

  void _updateMapLocation(int branchIndex) {
    if (branchesInDialog.isNotEmpty && branchIndex < branchesInDialog.length) {
      final branch = branchesInDialog[branchIndex];
      selectedLat.value = double.tryParse(branch.lat ?? '0') ?? 0;
      selectedLong.value = double.tryParse(branch.lon ?? '0') ?? 0;

      final newLocation = LatLng(
        Angle.degree(selectedLat.value),
        Angle.degree(selectedLong.value),
      );

      // Update reactive variables
      currentCenter.value = newLocation;
      currentZoom.value = DEFAULT_ZOOM;

      // Update map controller
      mapController.center = newLocation;
      mapController.zoom = DEFAULT_ZOOM;

      // Update markers
      markers.clear();
      markers.add(newLocation);
    }
  }

  // Zoom controls
  void zoomIn() {
    final newZoom = (currentZoom.value + 0.5).clamp(MIN_ZOOM, MAX_ZOOM);
    if (newZoom != currentZoom.value) {
      currentZoom.value = newZoom;
      mapController.zoom = newZoom;
      print('Zoom in: ${currentZoom.value}');
    }
  }

  void zoomOut() {
    final newZoom = (currentZoom.value - 0.5).clamp(MIN_ZOOM, MAX_ZOOM);
    if (newZoom != currentZoom.value) {
      currentZoom.value = newZoom;
      mapController.zoom = newZoom;
      print('Zoom out: ${currentZoom.value}');
    }
  }

  // Handle gesture-based scaling
  void handleScaleUpdate(double scaleDiff, Offset focalPoint, MapTransformer transformer) {
    if (scaleDiff.abs() < 0.01) return; // Ignore very small changes

    double zoomDelta = 0;
    if (scaleDiff > 0.1) {
      zoomDelta = 0.05;
    } else if (scaleDiff < -0.1) {
      zoomDelta = -0.05;
    }

    if (zoomDelta != 0) {
      final newZoom = (currentZoom.value + zoomDelta).clamp(MIN_ZOOM, MAX_ZOOM);

      if (newZoom != currentZoom.value) {
        currentZoom.value = newZoom;
        mapController.zoom = newZoom;
        // Use transformer for smooth zoom at focal point
        transformer.setZoomInPlace(newZoom, focalPoint);
      }
    }
  }

  // Handle mouse wheel scroll
  void handleScrollEvent(double delta, Offset localPosition, MapTransformer transformer) {
    final zoomDelta = -delta / 1000.0; // Adjust sensitivity
    final newZoom = (currentZoom.value + zoomDelta).clamp(MIN_ZOOM, MAX_ZOOM);

    if (newZoom != currentZoom.value) {
      currentZoom.value = newZoom;
      mapController.zoom = newZoom;
      transformer.setZoomInPlace(newZoom, localPosition);
    }
  }

  // Navigation
  Future<void> launchNavigation() async {
    final googleUrl = 'https://www.google.com/maps/search/?api=1&query=${selectedLat.value},${selectedLong.value}';

    try {
      final uri = Uri.parse(googleUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $googleUrl';
      }
    } catch (e) {
      Get.snackbar('خطا', 'امکان باز کردن نقشه وجود ندارد');
      print('Error launching navigation: $e');
    }
  }

  // Getters
  Units? get selectedBranch {
    if (branchesInDialog.isEmpty || selectedBranchIndex.value >= branchesInDialog.length) {
      return null;
    }
    return branchesInDialog[selectedBranchIndex.value];
  }

  bool get canZoomIn => currentZoom.value < MAX_ZOOM;
  bool get canZoomOut => currentZoom.value > MIN_ZOOM;

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }
}