import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../data/hive/hive_db.dart';
import '../data/hive/hive_models/hive_location_model.dart';
import '../data/models/models.dart';

class LocationRepository {
  late bool _locationServiceStatus;
  late LocationPermission _permission;

  Future<LocationModel> getUserLocation() async {
    final location = LocationModel();

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      final box = await HiveDB.openBox<HiveLocationModel>('locationBox');
      if (box.isNotEmpty) {
        final hiveLocation = box.values.first;
        location.city = hiveLocation.city;
        location.country = hiveLocation.country;
        location.lat = hiveLocation.lat;
        location.lon = hiveLocation.lon;
        location.state = hiveLocation.state;
      } else {
        location.errorMessage = 'Device not connected!';
      }
      await box.close();
      return location;
    } else {
      try {
        _locationServiceStatus = await Geolocator.isLocationServiceEnabled();
        if (!_locationServiceStatus) {
          location.errorMessage = 'Location services are disabled';
          return location;
        }

        _permission = await Geolocator.checkPermission();
        if (_permission == LocationPermission.denied) {
          _permission = await Geolocator.requestPermission();
          if (_permission != LocationPermission.whileInUse &&
              _permission != LocationPermission.always) {
            location.errorMessage = 'Location permission denied';
            return location;
          }
        }
        if (_permission == LocationPermission.deniedForever) {
          location.errorMessage = 'Location permission denied forever';
          return location;
        }

        debugPrint('Permission Granted');

        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placemark = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        location.errorMessage = null;
        location.lat = position.latitude;
        location.lon = position.longitude;
        location.city = placemark.first.locality;
        location.country = placemark.first.country;

        // save location info to hive database
        final box = await HiveDB.openBox<HiveLocationModel>('locationBox');
        await box.clear();
        await box.add(HiveLocationModel(
            lat: location.lat,
            lon: location.lon,
            city: location.city,
            country: location.country,
            state: location.state));
        await box.close();

        debugPrint(location.toJson().toString());

        return location;
      } catch (e) {
        debugPrint('Error: $e');
        throw Exception(e);
      }
    }
  }
}
