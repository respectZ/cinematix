import 'package:cinematix/model/location_provider.dart';
import 'package:cinematix/model/user_location.dart';
import 'package:cinematix/page/movie/movie_detail.dart';
import 'package:cinematix/page/profil/profil.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';
import 'cinematix_bar.dart';

import 'package:get/get.dart';

Future<List<SearchResult>?> _searchPlaces(
    {required UserLocation userLocation}) async {
  var googlePlace = GooglePlace("AIzaSyAKYtm-TjPrPM3qYwhvGtV_RtEgO8vBCHA");
  var result = await googlePlace.search.getNearBySearch(
      Location(lat: userLocation.latitude, lng: userLocation.longitude), 1500,
      type: "movie_theater", keyword: "bioskop");
  var cinemas = result!.results;
  return cinemas;
}

class CinematixHome extends StatefulWidget {
  CinematixHome({Key? key, required this.filmList}) : super(key: key);
  final List<Widget> filmList;

  @override
  _CinematixHomeState createState() => _CinematixHomeState();
}

class _CinematixHomeState extends State<CinematixHome> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w500);
  // ignore: unused_field
  late final List<Widget> _filmList = widget.filmList;
  late LocationProvider locationProvider;

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "CINEMATIX",
          style: TextStyle(color: Color.fromARGB(255, 0, 166, 232)),
        ),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                "Artline660",
                style: TextStyle(color: Colors.black87),
              )),
          IconButton(
            onPressed: () => Get.toNamed("/profile"),
            icon: const Icon(
              Icons.person_outline,
              color: Colors.black87,
            ),
            iconSize: 20,
          )
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 10.0, bottom: 15.0),
          child: Column(
            children: [
              Container(
                  width: 300,
                  height: 75,
                  alignment: Alignment.topLeft,
                  child: Column(children: [
                    InkWell(
                      onTap: () async {
                        await locationProvider.getLocation();
                        var cinemas = await _searchPlaces(
                            userLocation: locationProvider.userLocation);
                        Get.toNamed("/cinemas", arguments: {
                          "locationProvider": locationProvider,
                          "cinemas": cinemas!
                        });
                      },
                      child: Row(children: const [
                        Icon(Icons.location_on),
                        Text("CGV ROXY SQUARE JEMBER"),
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("On Going"),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(145, 30), elevation: 0),
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: Text("Up Coming"),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(145, 30),
                                onPrimary: Colors.grey[400],
                                primary: Colors.transparent,
                                elevation: 0))
                      ],
                    )
                  ])),
              Container(
                width: 300,
                height: 500,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 15,
                          offset: Offset(5, 10),
                          spreadRadius: -10)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3.75 / 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 20),
                    itemCount: _filmList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                          onTap: () => Get.toNamed("/movie_detail"),
                          child: Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            alignment: Alignment.center,
                            child: _filmList[index],
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(15)),
                          ));
                    }),
              )
            ],
          )),
      bottomNavigationBar: const CinematixBar(),
    );
  }
}
