import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LiveOrderTrackingMap extends StatefulWidget {
  final bool isInternational;
  final String transportMode;

  const LiveOrderTrackingMap({
    Key? key,
    required this.isInternational,
    this.transportMode = "land",
  }) : super(key: key);

  @override
  _LiveOrderTrackingMapState createState() => _LiveOrderTrackingMapState();
}

class _LiveOrderTrackingMapState extends State<LiveOrderTrackingMap> {
  late List<LatLng> deliveryPath;
  late LatLng currentLocation;
  int currentPathIndex = 1;
  final Location location = Location();
  final MapController mapController = MapController();
  double currentZoom = 13.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeRoute();
    _setupLocation();
    currentZoom = widget.isInternational ? 3.5 : 13.0;
  }

  Future<void> _setupLocation() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) return;
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) return;
      }

      _listenToLocationChanges();
    } catch (e) {
      debugPrint('Error setting up location: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _initializeRoute() {
    deliveryPath =
        widget.isInternational ? _getInternationalRoute() : _getLocalRoute();
    currentLocation = deliveryPath[currentPathIndex];
  }

  List<LatLng> _getInternationalRoute() {
    switch (widget.transportMode) {
      case 'air':
        return [
          const LatLng(39.9042, 116.4074), // Beijing
          const LatLng(9.145, 40.4897), // Ethiopia
          const LatLng(-6.7924, 39.2083), // DSM
        ];
      case 'sea':
        return [
          const LatLng(39.9042, 116.4074), // Beijing
          const LatLng(22.3193, 91.8320), // Chittagong Port
          const LatLng(-6.7924, 39.2083), // DSM
        ];
      default:
        return [
          const LatLng(-6.7924, 39.2083), // DSM Start
          const LatLng(-6.8200, 39.2400), // DSM End
        ];
    }
  }

  List<LatLng> _getLocalRoute() {
    return [
      const LatLng(-6.7924, 39.2083), // DSM Start
      const LatLng(-6.7960, 39.2150), // Via points
      const LatLng(-6.8000, 39.2200),
      const LatLng(-6.8050, 39.2250),
      const LatLng(-6.8100, 39.2300),
      const LatLng(-6.8200, 39.2400), // Destination
    ];
  }

  void _centerMapOnRoute() {
    if (deliveryPath.isEmpty) return;

    double minLat = deliveryPath.map((p) => p.latitude).reduce(math.min);
    double maxLat = deliveryPath.map((p) => p.latitude).reduce(math.max);
    double minLng = deliveryPath.map((p) => p.longitude).reduce(math.min);
    double maxLng = deliveryPath.map((p) => p.longitude).reduce(math.max);

    LatLng center = LatLng(
      (minLat + maxLat) / 2,
      (minLng + maxLng) / 2,
    );

    mapController.move(center, currentZoom);
  }

  void _listenToLocationChanges() {
    location.onLocationChanged.listen((LocationData locationData) {
      if (locationData.latitude == null || locationData.longitude == null)
        return;

      setState(() {
        currentLocation = LatLng(
          locationData.latitude!,
          locationData.longitude!,
        );
        mapController.move(currentLocation, currentZoom);
      });
    });
  }

  Widget _buildTransportIcon() {
    final IconData iconData;
    final Color iconColor;
    final double iconSize;

    switch (widget.transportMode) {
      case 'air':
        iconData = Icons.flight;
        iconColor = Colors.blue;
        iconSize = 28;
        break;
      case 'sea':
        iconData = Icons.directions_boat;
        iconColor = Colors.blue;
        iconSize = 28;
        break;
      default:
        iconData = Icons.motorcycle;
        iconColor = Colors.orange;
        iconSize = 24;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Icon(iconData, color: iconColor, size: iconSize),
      ),
    );
  }

  List<Marker> _buildMarkers() {
    return [
      Marker(
        point: deliveryPath.first,
        width: 40,
        height: 40,
        child: const Icon(
          Icons.location_on,
          color: Colors.green,
          size: 40,
        ),
      ),
      Marker(
        point: currentLocation,
        width: 48,
        height: 48,
        child: _buildTransportIcon(),
      ),
      Marker(
        point: deliveryPath.last,
        width: 40,
        height: 40,
        child: const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 40,
        ),
      ),
    ];
  }

  Widget _buildInfoCard(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 16,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.orange.withOpacity(0.1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Estimated Arrival: 2 hours',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Current Location: ${_getCurrentLocationName()}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getCurrentLocationName() {
    if (widget.isInternational) {
      switch (currentPathIndex) {
        case 0:
          return 'Beijing, China';
        case 1:
          return widget.transportMode == 'air'
              ? 'Ethiopia'
              : 'Chittagong Port, Bangladesh';
        case 2:
          return 'Dar es Salaam, Tanzania';
        default:
          return 'En Route';
      }
    }
    return 'Dar es Salaam, Tanzania';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Live Order Tracking",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    minZoom: 2,
                    maxZoom: 18,
                    onMapReady: () {
                      _centerMapOnRoute();
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: deliveryPath.sublist(0, currentPathIndex + 1),
                          strokeWidth: 6.0, // Increased thickness
                          color: Colors.blue.withOpacity(
                              0.9), // Higher opacity for covered route
                        ),
                        Polyline(
                          points: deliveryPath.sublist(currentPathIndex),
                          strokeWidth: 6.0, // Increased thickness
                          color: Colors.blue.withOpacity(
                              0.5), // Lower opacity for uncovered route
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: _buildMarkers(),
                    ),
                  ],
                ),
                _buildInfoCard(context),
              ],
            ),
       floatingActionButton: FloatingActionButton(
        onPressed: _centerMapOnRoute,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.center_focus_strong, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
