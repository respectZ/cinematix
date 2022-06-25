import 'dart:math' as math;
import 'dart:typed_data';
import 'package:cinematix/model/cinema.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';
import 'package:cinematix/model/location_provider.dart';
import 'package:cinematix/model/location_services.dart';
import 'package:cinematix/model/user_location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'maps_screen.dart';

Widget _widgetListCinema(
    {required List<SearchResult> listCinema, required Offset myOffset}) {
  Column column = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [],
  );
  for (var cinema in listCinema) {
    if (!(cinema.name!.contains("XXI") || cinema.name!.contains("CGV"))) {
      continue;
    }
    // calculate distance
    Offset cinemaOffset = Offset(
        cinema.geometry!.location!.lat!, cinema.geometry!.location!.lng!);
    double distance = _calculateDistance(myOffset, cinemaOffset);
    String distanceText = distance < 1
        ? "${(distance * 1000).toInt()} m"
        : "${distance.toStringAsFixed(2)} km";
    // widget
    Widget cinemaBox = InkWell(
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("cinema", cinema.reference!);
          await Cinema.newCinema(
              cinema_id: cinema.reference!,
              name: cinema.name!,
              lat: cinema.geometry!.location!.lat!,
              lng: cinema.geometry!.location!.lng!);
          Get.offAndToNamed("/main");
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cinema.name!),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cinema.vicinity!,
                  style: TextStyle(color: Colors.grey),
                ),
                Text(distanceText),
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ));
    column.children.add(cinemaBox);
  }
  return Container(margin: EdgeInsets.all(12.0), child: column);
}

Future<DetailsResult?> _getCinemaDetail({required String id}) async {
  var googlePlace = GooglePlace("AIzaSyAKYtm-TjPrPM3qYwhvGtV_RtEgO8vBCHA");
  DetailsResponse? result = await googlePlace.details
      .get(id, fields: "name,rating,formatted_phone_number");
  return result!.result;
}

double _calculateDistance(Offset offset1, Offset offset2) {
  double deg2rad(double deg) => deg * (math.pi / 180);
  int R = 6371;
  var dLat = deg2rad(offset1.dx - offset2.dx);
  var dLon = deg2rad(offset1.dy - offset2.dy);
  var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(deg2rad(offset1.dx)) *
          math.cos(deg2rad(offset2.dx)) *
          math.sin(dLon / 2) *
          math.sin(dLon / 2);
  var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  var d = R * c; // Distance in km
  return d;
}

class CinemaMaps extends StatefulWidget {
  const CinemaMaps({Key? key}) : super(key: key);

  @override
  _CinemaMapsState createState() => _CinemaMapsState();
}

class _CinemaMapsState extends State<CinemaMaps> {
  late LocationProvider locationProvider;
  late List<SearchResult> cinemas;
  @override
  void initState() {
    locationProvider = Get.arguments["locationProvider"];
    cinemas = Get.arguments["cinemas"];
    super.initState();
  }

  @override
  void dispose() {
    LocationServices().closeLocation();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "CINEMATIX",
          style: TextStyle(color: Color.fromARGB(255, 0, 166, 232)),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black45,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cinemas != null
              ? Container(
                  height: 200,
                  child: AnimatedBuilder(
                      animation: locationProvider,
                      builder: (context, child) {
                        if (locationProvider.status ==
                            LocationProviderStatus.Initial) {
                          return Text("not initialized");
                        } else if (locationProvider.status ==
                            LocationProviderStatus.Loading) {
                          return CircularProgressIndicator();
                        } else if (locationProvider.status ==
                            LocationProviderStatus.Success) {
                          return StreamProvider<UserLocation>(
                            initialData: locationProvider.userLocation,
                            create: (context) =>
                                LocationServices().locationStream,
                            child: MapsScreen(
                              listCinema: cinemas,
                            ),
                          );
                        } else if (locationProvider.status ==
                            LocationProviderStatus.Error) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text("Mohon nyalakan GPS anda."),
                                );
                              });
                          return Text("err");
                        } else {
                          return Text("err");
                        }
                      }),
                )
              : CircularProgressIndicator(),
          SingleChildScrollView(
            child: Expanded(
              child: _widgetListCinema(
                listCinema: cinemas,
                myOffset: Offset(locationProvider.userLocation.latitude,
                    locationProvider.userLocation.longitude),
              ),
            ),
          )
        ],
      ),
    );
  }
}
