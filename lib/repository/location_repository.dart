import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../data/models/models.dart';

class LocationRepository {
  late bool _locationServiceStatus;
  late LocationPermission _permission;

  Future<LocationModel> getUserLocation() async {
    final location = LocationModel();
    try {
      _locationServiceStatus = await Geolocator.isLocationServiceEnabled();

      if (!_locationServiceStatus) {
        location.errorMessage = 'Location service are disabled';
        return location;
      }

      _permission = await Geolocator.checkPermission();

      if (_permission == LocationPermission.denied) {
        _permission = await Geolocator.requestPermission();
        if (_permission != LocationPermission.whileInUse ||
            _permission != LocationPermission.always) {
          location.errorMessage = 'Location permission are denied!';
          return location;
        }
      }
      if (_permission == LocationPermission.deniedForever) {
        location.errorMessage = 'Location permission are denied forever!';
        return location;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      location.errorMessage = null;
      location.lat = position.latitude;
      location.lon = position.longitude;
      location.city = placemark.first.locality;
      location.country = placemark.first.country;

      debugPrint(location.toJson().toString());

      return location;
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }
}
