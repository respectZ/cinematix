import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';
import 'package:cinematix/model/location_provider.dart';
import 'package:cinematix/model/location_services.dart';
import 'package:cinematix/model/user_location.dart';

const double cameraZoom = 15;
const double cameraTilt = 50;
const double cameraBearing = 30;

Set<Marker> _getMarker({required List<SearchResult> listCinema}) {
  Set<Marker> markers = {};
  List<double> hue = [
    BitmapDescriptor.hueBlue,
    BitmapDescriptor.hueGreen,
    BitmapDescriptor.hueOrange,
    BitmapDescriptor.hueRed,
    BitmapDescriptor.hueViolet,
    BitmapDescriptor.hueYellow
  ];
  if (listCinema.isNotEmpty) {
    int pos = 0;
    for (var cinema in listCinema) {
      if (!(cinema.name!.contains("XXI") || cinema.name!.contains("CGV"))) {
        continue;
      }
      markers.add(
        Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(hue[pos]),
            markerId: MarkerId(cinema.placeId!),
            position: LatLng(cinema.geometry!.location!.lat!,
                cinema.geometry!.location!.lng!),
            infoWindow: InfoWindow(title: cinema.name!)),
      );
      pos++;
    }
  }
  return markers;
}

class MapsScreen extends StatefulWidget {
  List<SearchResult> listCinema;

  MapsScreen({Key? key, required this.listCinema});
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late Position position;
  late GoogleMapController mapControler;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  bool isMarkerInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    LocationServices().closeLocation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(builder: (context, LocationProvider provider, _) {
      if (provider.status == LocationProviderStatus.Loading ||
          provider.status == LocationProviderStatus.Initial) {
        return Center(child: CircularProgressIndicator());
      } else if (provider.status == LocationProviderStatus.Success) {
        var locationProvider = Provider.of<UserLocation>(context);
        if (!isMarkerInitialized) {
          // setState(() {
          // isMarkerInitialized = true;
          //   List<double> hue = [
          //     BitmapDescriptor.hueBlue,
          //     BitmapDescriptor.hueGreen,
          //     BitmapDescriptor.hueOrange,
          //     BitmapDescriptor.hueRed,
          //     BitmapDescriptor.hueViolet,
          //     BitmapDescriptor.hueYellow
          //   ];
          //   if (widget.listCinema.isNotEmpty) {
          //     int pos = 0;
          // for (var cinema in widget.listCinema) {
          //   if (!(cinema.name!.contains("XXI") ||
          //       cinema.name!.contains("CGV"))) {
          //     continue;
          //   }

          //   Offset myLocation = Offset(
          //       locationProvider.latitude, locationProvider.longitude);
          //   Offset cinemaOffset = Offset(cinema.geometry!.location!.lat!,
          //       cinema.geometry!.location!.lng!);

          //   markers.add(
          //     Marker(
          //         icon: BitmapDescriptor.defaultMarkerWithHue(hue[pos]),
          //         markerId: MarkerId(cinema.placeId!),
          //         position: LatLng(cinema.geometry!.location!.lat!,
          //             cinema.geometry!.location!.lng!),
          //         infoWindow: InfoWindow(title: cinema.name!)),
          //   );
          // }
          //   }
          // });
        }
        // if (!isMarkerInitialized) {
        //   _searchPlaces(userLocation: locationProvider).then((cinemas) {
        //     setState(() {
        //       List<double> hue = [
        //         BitmapDescriptor.hueBlue,
        //         BitmapDescriptor.hueGreen,
        //         BitmapDescriptor.hueOrange,
        //         BitmapDescriptor.hueRed,
        //         BitmapDescriptor.hueViolet,
        //         BitmapDescriptor.hueYellow
        //       ];
        //       if (cinemas!.isNotEmpty) {
        //         int pos = 0;
        //         for (var cinema in cinemas) {
        //           if (!(cinema.name!.contains("XXI") ||
        //               cinema.name!.contains("CGV"))) {
        //             continue;
        //           }
        //           Offset myLocation = Offset(
        //               locationProvider.latitude, locationProvider.longitude);
        //           Offset cinemaOffset = Offset(cinema.geometry!.location!.lat!,
        //               cinema.geometry!.location!.lng!);
        //           print(_calculateDistance(myLocation, cinemaOffset));
        //           markers.add(
        //             Marker(
        //                 icon: BitmapDescriptor.defaultMarkerWithHue(hue[pos]),
        //                 markerId: MarkerId(cinema.placeId!),
        //                 position: LatLng(cinema.geometry!.location!.lat!,
        //                     cinema.geometry!.location!.lng!),
        //                 infoWindow: InfoWindow(title: cinema.name!)),
        //           );
        //           _controller.future.then((controller) async {
        //             await Future.delayed(Duration(milliseconds: 100));
        //             controller.showMarkerInfoWindow(MarkerId(cinema.placeId!));
        //           });
        //           pos += 1;
        //         }
        //       }
        //       isMarkerInitialized = true;
        //     });
        //   });
        // }
        CameraPosition initialCameraPosition = CameraPosition(
            zoom: cameraZoom,
            target:
                LatLng(locationProvider.latitude, locationProvider.longitude));

        return Stack(children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            myLocationEnabled: true,
            mapToolbarEnabled: false,
            mapType: MapType.terrain,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _getMarker(listCinema: widget.listCinema),
          ),
        ]);
      } else {
        return Center(child: Text("We can't reach your location"));
      }
    }));
  }
}
