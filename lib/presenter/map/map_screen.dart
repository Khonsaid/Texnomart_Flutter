import 'dart:async';

import 'package:flutter/material.dart' as flutter;
import 'package:flutter/material.dart';
import 'package:texnomart/utils/app_lat_long.dart';
import 'package:texnomart/utils/colors.dart';
import 'package:texnomart/utils/location_service.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart';
import 'package:yandex_maps_mapkit_lite/mapkit_factory.dart';
import 'package:yandex_maps_mapkit_lite/src/bindings/image/image_provider.dart' as image_provider;
import 'package:yandex_maps_mapkit_lite/src/mapkit/animation.dart' as mapkit_animation;
import 'package:yandex_maps_mapkit_lite/src/mapkit/map/icon_style.dart' as mapkit_map_icon_style;
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';

import '../../data/scource/remote/response/detail/available_stores/available_stores.dart';

class MapScreen extends StatefulWidget {
  final AddressData? location;

  const MapScreen({super.key, required this.location});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapWindow? _mapWindow;

  @override
  void initState() {
    _initPermission();
    mapkit.onStart();

    super.initState();
  }

  @override
  void dispose() {
    mapkit.onStop();
    super.dispose();
  }

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrLocation();
  }

  Future<void> _fetchCurrLocation() async {
    AppLatLang location;
    const defLocation = Tashkent();
    try {
      location = await LocationService().getCurrLocation();
    } catch (_) {
      location = defLocation;
    }
    // _moveToCurrLocation(location.lat, location.long);
  }

  late MapObjectTapListener listener;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            "Do'kon manzili",
            textAlign: TextAlign.start,
            style: flutter.TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          titleSpacing: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.keyboard_arrow_left, size: 24)),
        ),
        body: YandexMap(onMapCreated: (mapWindow) async {
          _mapWindow = mapWindow;

          _addPlaceMarks(widget?.location);

          _mapWindow?.map.moveWithAnimation(
            CameraPosition(
                Point(
                    latitude: double.parse(widget.location?.lat ?? '0'),
                    longitude: double.parse(widget.location?.long ?? '0')),
                zoom: 13,
                azimuth: 0.0,
                tilt: 0.0),
            mapkit_animation.Animation(AnimationType.Linear, duration: 1.0),
            cameraCallback: MapCameraCallback(
              onMoveFinished: (isFinished) {
                if (isFinished) {
                  _showLocationDetails(context, widget?.location);
                }
              },
            ),
          );
        }));
  }

  void _addPlaceMarks(AddressData? location) async {
    final placeMark = _mapWindow?.map.mapObjects.addPlacemark();
    final latitude = double.parse(location?.lat ?? '0');
    final longitude = double.parse(location?.long ?? '0');

    if (placeMark != null) {
      placeMark.geometry = Point(
        latitude: latitude,
        longitude: longitude,
      );

      placeMark.setIconWithStyle(
        image_provider.ImageProvider.fromImageProvider(const AssetImage("assets/images/ic_location.png")),
        mapkit_map_icon_style.IconStyle(scale: 2),
      );
      listener = PlacemarkTapListener(this, location);
      placeMark.addTapListener(listener);
    }
  }

  void _showLocationDetails(BuildContext context, AddressData? location) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location?.name ?? "Do'kon",
                style: flutter.TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 8),
              Text(location?.address ?? ""),
              SizedBox(height: 16),
              if (location?.phone != null && location!.phone!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Telefon raqami:",
                      style: flutter.TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(location.phone.toString()),
                    SizedBox(height: 12),
                  ],
                ),
              if (location?.workTime != null && location!.workTime!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ish vaqti:",
                      style: flutter.TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(location.workTime.toString()),
                    SizedBox(height: 16),
                  ],
                ),
              // ElevatedButton(
              //   onPressed: () {
              //     // Yo'nalish olish funksiyasi
              //     Navigator.pop(context);
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: AppColors.primaryColor,
              //     minimumSize: Size(double.infinity, 48),
              //   ),
              //   child: Text("Yo'nalish olish"),
              // ),
            ],
          ),
        );
      },
    );
  }
}

final class PlacemarkTapListener implements MapObjectTapListener {
  final AddressData? location;
  final _MapScreenState parent;

  PlacemarkTapListener(this.parent, this.location);

  @override
  bool onMapObjectTap(MapObject mapObject, Point point) {
    print("TTT onMapObjectTap");
    parent._mapWindow?.map.moveWithAnimation(
      CameraPosition(point, zoom: 13, azimuth: 0.0, tilt: 0.0),
      mapkit_animation.Animation(AnimationType.Linear, duration: 1.0),
      cameraCallback: MapCameraCallback(
        onMoveFinished: (isFinished) {
          if (isFinished) {
            parent._showLocationDetails(parent.context, location);
          }
        },
      ),
    );
    return true; // ✅ Listener `true` qaytarishi kerak
  }
}
