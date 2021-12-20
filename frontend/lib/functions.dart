import 'package:geolocator/geolocator.dart';

// TEXTFIELD VALIDATION
String? validatorCallback(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

// coverage:ignore-start
// GEOLOCATOR
Future<Position> getPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return Future.error('Location services are disabled.');

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  final loc = await Geolocator.getLastKnownPosition();

  if (loc == null) {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
  } else {
    return loc;
  }
}

// coverage:ignore-end
