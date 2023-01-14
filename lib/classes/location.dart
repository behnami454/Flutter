import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../api/weather_api.dart';
import '../model/weather_model.dart';

class Location extends StatefulWidget {
  static var latitude;
  static var longitude;
  StreamSubscription<Position>? positionStream;
  WeatherModel? weather;
  var isLoaded = false;

  Location({Key? key, this.weather, this.positionStream}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Position? currentPosition;

  void listenToLocationChanges() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    widget.positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position? position) {
        setState(() {
          currentPosition = position;
          Location.longitude = currentPosition?.longitude;
          Location.latitude = currentPosition?.latitude;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission != LocationPermission.denied) {
      final Position position = await Geolocator.getCurrentPosition();
      widget.weather = await WeatherApi.getWeather(position);
    }
    if (widget.weather != null) {
      setState(() {
        widget.isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
