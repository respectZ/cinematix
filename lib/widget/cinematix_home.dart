import 'package:cinematix/model/cinema.dart';
import 'package:cinematix/model/location_provider.dart';
import 'package:cinematix/model/user_location.dart';
import 'package:cinematix/page/movie/movie_detail.dart';
import 'package:cinematix/page/profil/profil.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'cinematix_bar.dart';
import 'package:cinematix/model/fire_auth.dart';
import 'package:cinematix/model/user_cinematix.dart';
import 'package:cinematix/model/movie.dart';

import 'package:get/get.dart';

Widget movieToWidget(
    {required Movie? movie, required String cinemaID, bool? isUpcoming}) {
  return InkWell(
    onTap: () async {
      Get.toNamed("/movie_detail", arguments: {
        "movie": movie,
        "cinemaID": cinemaID,
        "schedules": await movie!.getSchedule(cinema_id: cinemaID),
        "isUpcoming": isUpcoming ?? false,
      });
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(movie!.getImage()),
        ),
      ),
    ),
  );
}

Future<List<SearchResult>?> _searchPlaces(
    {required UserLocation userLocation}) async {
  int radius = 3000;
  var googlePlace = GooglePlace("AIzaSyAKYtm-TjPrPM3qYwhvGtV_RtEgO8vBCHA");
  var result = await googlePlace.search.getNearBySearch(
      Location(lat: userLocation.latitude, lng: userLocation.longitude), radius,
      type: "movie_theater", keyword: "bioskop");
  var cinemas = result!.results;
  return cinemas;
}

class CinematixHome extends StatefulWidget {
  CinematixHome(
      {Key? key,
      required this.onGoing,
      required this.upComing,
      required this.cinemaID})
      : super(key: key);
  final List<Movie?> onGoing;
  final List<Movie?> upComing;
  final String cinemaID;

  @override
  _CinematixHomeState createState() => _CinematixHomeState();
}

class _CinematixHomeState extends State<CinematixHome>
    with TickerProviderStateMixin {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w500);
  // ignore: unused_field
  late LocationProvider locationProvider;
  late final List<List<Movie?>> _filmList = [widget.onGoing, widget.upComing];
  late TabController _tabController;

  Future<UserCinematix?> userCinematix = FireAuth.getCurrentUser();

  int _tabIndex = 0;

  void _tabSection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_tabSection);
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    // setting
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.width;
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
          FutureBuilder<UserCinematix?>(
              future: userCinematix,
              builder: (BuildContext context,
                  AsyncSnapshot<UserCinematix?> snapshot) {
                if (snapshot.hasData) {
                  return TextButton(
                      onPressed: () {},
                      child: Text(
                        (snapshot.data)?.getName() ?? "Error",
                        style: TextStyle(color: Colors.black87),
                      ));
                } else if (snapshot.hasError) {
                  return Text("Error");
                }
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  enabled: true,
                  child: Container(
                    width: 90,
                    height: 20,
                    color: Colors.grey,
                  ),
                );
              }),
          IconButton(
            onPressed: () {
              Get.toNamed("/profile")?.then((value) {
                setState(() {
                  userCinematix = FireAuth.getCurrentUser();
                });
              });
            },
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
                        })?.then((value) {});
                      },
                      child: Row(children: [
                        Icon(Icons.location_on),
                        FutureBuilder(
                          future:
                              Cinema.getCinemaName(cinema_id: widget.cinemaID),
                          builder: (BuildContext context,
                              AsyncSnapshot<String?> snapshot) {
                            if (snapshot.data != null) {
                              return Text(snapshot.data ?? "Error");
                            } else {
                              return Text("Error");
                            }
                          },
                        ),
                      ]),
                    ),
                    TabBar(
                        controller: _tabController,
                        labelColor: Colors.blue,
                        tabs: [Tab(text: "ONGOING"), Tab(text: "UPCOMING")])
                  ])),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: Container(
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
                      itemCount: _filmList[_tabIndex].length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          alignment: Alignment.center,
                          child: movieToWidget(
                              movie: _filmList[_tabIndex][index],
                              cinemaID: widget.cinemaID,
                              isUpcoming: _tabIndex == 1),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(15)),
                        );
                      }),
                ),
              )
            ],
          )),
      bottomNavigationBar: const CinematixBar(),
    );
  }
}
