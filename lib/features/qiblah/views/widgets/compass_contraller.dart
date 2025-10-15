import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CompassContraller extends GetxController {
  bool _hasPermissions = false;
  bool get hasPermissions => _hasPermissions;

  Position? currentPosition;

  @override
  void onInit() {
    getPermission();
    super.onInit();
  }

  Future<void> getPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _hasPermissions = false;
      update();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _hasPermissions = false;
    } else {
      _hasPermissions = true;
      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print(
          '📍 Location: ${currentPosition!.latitude}, ${currentPosition!.longitude}');
    }

    update();
  }

  Future<void> requestPermission() async {
    await getPermission();
  }
}
