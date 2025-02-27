import 'app_lat_long.dart';

abstract class AppLocation{
  Future<AppLatLang> getCurrLocation();

  Future<bool> requestPermission();
  Future<bool> checkPermission();
}