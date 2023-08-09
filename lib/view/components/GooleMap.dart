import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  Location location = new Location();
  BitmapDescriptor? icon;
  LocationData? _locationData;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  @override
  void initState() {
    super.initState();
    getPermission();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), "assets/icons/pin.png")
        .then((value) {
      setState(() {
        icon = value;
      });
    });
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("MarkerId"),
          position: LatLng(_locationData!.latitude!, _locationData!.longitude!),
          icon: icon!,
          infoWindow:
              InfoWindow(title: "This is Title", snippet: "This is a snippet")),
    ].toSet();
  }

  Future<void> getPermission() async {
    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      final locationData = await location.getLocation();
      setState(() {
        _locationData = locationData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        leading: Icon(Icons.menu),
        //centerTitle: true,
        title: Row(
          children: [
            Image.network(
              'https://www.searchenginejournal.com/wp-content/uploads/2022/06/image-search-1600-x-840-px-62c6dc4ff1eee-sej.png',
              height: 30,
            ),
            SizedBox(width: 10),
            Text(
              "Welcome to Course",
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
        actions: [
          Icon(Icons.notifications),
          SizedBox(width: 20),
          Icon(Icons.shopping_cart),
          SizedBox(width: 20),
        ],
      ),
     
      body: Container(
        height: 200,
        decoration: BoxDecoration(color: Colors.red),
        child: _locationData == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _locationData!.latitude!,
                      _locationData!.longitude!,
                    ),
                    zoom: 14),
                myLocationEnabled: true,
                markers: myMarker(),
              ),
      ),
    );
  }
}
