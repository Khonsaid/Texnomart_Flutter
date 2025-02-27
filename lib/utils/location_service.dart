import 'package:geolocator/geolocator.dart';
import 'package:texnomart/utils/app_lat_long.dart';

import 'app_location.dart';

final defLocation = Tashkent();

class LocationService implements AppLocation {
  @override
  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
        .then((value) => value == LocationPermission.always || value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  @override
  Future<AppLatLang> getCurrLocation() {
    return Geolocator.getCurrentPosition()
        .then((onValue) => AppLatLang(lat: onValue.latitude, long: onValue.longitude))
        .catchError((_) => defLocation);
  }

  @override
  Future<bool> requestPermission() {
    return Geolocator.requestPermission()
        .then((onValue) => onValue == LocationPermission.always || override == LocationPermission.whileInUse);
  }
}
