import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/point.dart';
import 'package:geolocator/geolocator.dart';

class PointDetailScreen extends StatefulWidget {
  final Point point;

  const PointDetailScreen({super.key, required this.point});

  @override
  PointDetailScreenState createState() => PointDetailScreenState();
}

class PointDetailScreenState extends State<PointDetailScreen> {
  LatLng? currentPosition;
  String? locationError;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          locationError = 'Location services are disabled.';
        });
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            locationError = 'Location permissions are denied';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          locationError = 'Location permissions are permanently denied';
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      setState(() {
        locationError = 'Failed to get current location: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.point.name)),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: FlutterMap(
              options: MapOptions(
                initialCenter:
                    LatLng(widget.point.latitude, widget.point.longitude),
                initialZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point:
                          LatLng(widget.point.latitude, widget.point.longitude),
                      child: const Icon(Icons.location_pin, color: Colors.red),
                    ),
                    if (currentPosition != null)
                      Marker(
                        point: currentPosition!,
                        child: const Icon(Icons.person_pin_circle,
                            color: Colors.blue),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: locationError != null
                  ? Text(
                      locationError!,
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    )
                  : Text(
                      'Details for ${widget.point.name}',
                      style: const TextStyle(fontSize: 18),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
