import 'dart:ffi';

import 'package:cinematix/model/fire_auth.dart';
import 'package:cinematix/model/review.dart';
import 'package:cinematix/model/user_cinematix.dart';
import 'package:cinematix/page/movie/movie_ticket.dart';
import 'package:cinematix/widget/jadwal_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../widget/reviewbox.dart';

import 'dart:developer';

import '../../model/movie.dart';

import 'package:flutter/material.dart';

String _formatAiring({required DateTime start, required DateTime end}) =>
    "${start.day}/${start.month}/${start.year} - ${end.day}/${end.month}/${end.year}";

class MovieDetailPage extends StatefulWidget {
  List<Movie> MovieList = [];

  MovieDetailPage({Key? key}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with TickerProviderStateMixin {
  TextStyle TitleStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
  // some variables ?
  late Future<bool> isFavorite;
  late TabController _tabMainController;
  late TabController _tabJadwalController;
  int _tabMainIndex = 0;
  int _tabJadwalIndex = 0;

  List<Tab> JadwalList = [];
  List<String> months =
      "Januari Februari Maret April Mei Juni Juli Agustus September Oktober November Desember"
          .split(" ");
  List<String> days = "Senin Selasa Rabu Kamis Jumat Sabtu Minggu".split(" ");
  late Future<List<Review?>> list_review;
  Future<UserCinematix?> userCinematix = FireAuth.getCurrentUser();

  double _ratingBarMode = 1;
  TextEditingController reviewController = TextEditingController();

  late List<Widget> _listofreviewwidget;
  late Movie movie;

  // Function util
  void _tabSection() {
    if (_tabMainController.indexIsChanging) {
      setState(() {
        _tabMainIndex = _tabMainController.index;
      });
    }
    if (_tabJadwalController.indexIsChanging) {
      setState(() {
        _tabJadwalIndex = _tabJadwalController.index;
      });
    }
  }

  // Function widget
  List<Widget> _tabMainContent() {
    return <Widget>[
      Column(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(12.0, 12.0, 0.0, 0.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sinopsis",
                      style: TitleStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(movie.getSchedule().toString()),
                    // Text(movie.getDescription().toString()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(children: [
                  Icon(
                    Icons.star,
                    color: Colors.blue,
                  ),
                  Text(
                    "Rating: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  RatingBar.builder(
                      initialRating: 4.5,
                      itemSize: 20,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemBuilder: (context, _) =>
                          Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {
                        _ratingBarMode = rating;
                        print(_ratingBarMode);
                      }),
                ]),
                Row(
                  children: [
                    Icon(
                      Icons.create_rounded,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        autocorrect: false,
                        enableSuggestions: false,
                        controller: reviewController,
                        decoration: InputDecoration(hintText: 'Tulis Review'),
                      ),
                    ),
                    FutureBuilder(
                        future: userCinematix,
                        builder: (BuildContext context,
                            AsyncSnapshot<UserCinematix?> snapshot) {
                          return IconButton(
                              onPressed: () async {
                                if (reviewController.text.isNotEmpty) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      });

                                  try {
                                    FireAuth.addReview(
                                        movie_id: movie.getID(),
                                        user_email: snapshot.data!.getEmail(),
                                        star_rating: _ratingBarMode,
                                        comment: reviewController.text);
                                    reviewController.clear();
                                    Get.offAndToNamed("/movie/movie_detail");
                                    setState(() {});
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.blue,
                              ));
                        })
                  ],
                ),
                Divider(
                  thickness: 2.0,
                ),
                FutureBuilder(
                    future: list_review,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Review?>> snapshot) {
                      if (!snapshot.hasError) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          List<Widget> list_rev = [];
                          List<Review?> list_review = snapshot.data!;
                          list_rev = list_review
                              .map((e) => ReviewBox(
                                  time: DateTime.now(),
                                  comment: e!.getComment(),
                                  star: e.getStarRating(),
                                  name: e.getUserEmail()))
                              .toList();
                          print(list_review[0]!.getStarRating());
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: list_review.length,
                              itemBuilder: (context, index) {
                                return list_rev[index];
                              });
                        } else
                          return Text("Belum Ada Review");
                      } else
                        return Text("Error");
                    })
              ],
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
            child: TabBar(
                controller: _tabJadwalController,
                isScrollable: true,
                labelColor: Colors.blue,
                tabs: [
                  Tab(
                    text: "11 Juni\nSabtu",
                  )
                ]),
          ),
          _tabJadwalContent()[_tabJadwalIndex],
        ],
      ),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Container(
      //       margin: EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
      //       child: TabBar(
      //         controller: _tabJadwalController,
      //         isScrollable: true,
      //         labelColor: Colors.blue,
      //         tabs: movie
      //             .getSchedule()!
      //             .map((e) => Tab(
      //                   text:
      //                       "${(e["airing"] as Timestamp).toDate().day} ${months[(e["airing"] as Timestamp).toDate().month - 1]}\n${days[(e["airing"] as Timestamp).toDate().weekday - 1]}",
      //                 ))
      //             .toList(),
      //       ),
      //     ),
      //     _tabJadwalContent()[_tabJadwalIndex],
      //   ],
      // ),
    ];
  }

  List<Widget> _tabJadwalContent() {
    return List<Widget>.generate(
        _tabJadwalController.length,
        (_) => Column(
              children: List<Widget>.generate(
                1,
                (index) => JadwalBox(
                  NamaRuangan: "Audi ${index + 1}",
                  ListWaktu:
                      List<DateTime>.generate(1, (index2) => DateTime.now()),
                  callback: () => Get.toNamed("/movie_ticket"),
                ),
              ),
            ));
  }

  @override
  void initState() {
    super.initState();

    movie = Get.arguments["movie"] as Movie;
    list_review = FireAuth.getReview(movie_id: movie.getID());
    isFavorite = FireAuth.isUserFavorite(movie_id: movie.getID());

    _tabMainController = TabController(length: 3, vsync: this);
    _tabMainController.addListener(_tabSection);

    // need fetch from schedule
    JadwalList = List<Tab>.generate(
        7, (index) => Tab(text: "${index + 10} Maret\nSelasa"));

    // _tabJadwalController =
    //     TabController(length: movie.getSchedule()!.length, vsync: this);
    _tabJadwalController = TabController(length: 1, vsync: this);
    _tabJadwalController.addListener(_tabSection);
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Configuration
    final thumbnailWidth = screenHeight * 0.1586; // was 180
    final thumbnailHeight = screenHeight * 0.26; // was 111
    final titleWidth = screenWidth - thumbnailWidth - 24 - 10; // was 250
    final infoWidth = screenWidth - titleWidth + 32; // was 70

    // log("Width " + screenWidth.toString());
    // log("Height " + screenHeight.toString());
    // log(infoWidth.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Detail Film",
          style: TextStyle(color: Color.fromARGB(255, 0, 166, 232)),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black45,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Banner, Thumbnail, and Information
            Stack(
              children: [
                Container(
                  color: Colors.white,
                  width: screenWidth,
                  height: 500,
                ),
                // Banner
                Container(
                  height: 200,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 255, 255, 255), BlendMode.darken),
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(
                          "https://cdn.myanimelist.net/s/common/uploaded_files/1635784561-2e7ef92151ba666376667b57500afbf9.jpeg"),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                ),
                // Thumbnail and information
                Positioned(
                  top: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Thumbnail
                          Container(
                            margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                            height: thumbnailHeight,
                            width: thumbnailWidth,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(movie.getImage()),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                          // Info
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: titleWidth,
                                child: Text(
                                  movie.getTitle(),
                                  style: TitleStyle,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Durasi",
                                    style: TitleStyle,
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  SizedBox(
                                    width: infoWidth,
                                    child: Text(
                                      movie.getDurationString(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rating",
                                    style: TitleStyle,
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  SizedBox(
                                    width: infoWidth,
                                    child: Text(movie.getRating()),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sutradara",
                                    style: TitleStyle,
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  SizedBox(
                                    width: infoWidth,
                                    child: Text(movie.getDirector()),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Genre",
                                    style: TitleStyle,
                                  ),
                                  SizedBox(
                                    width: 53,
                                  ),
                                  SizedBox(
                                    width: infoWidth,
                                    child: Text(
                                        "Action, Adventure, Fantasy, Romance"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            // Date
            Container(
              margin: EdgeInsets.fromLTRB(12.0, 12.0, 0.0, 0.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.date_range_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            _formatAiring(
                                start: movie.getStartAiring()!,
                                end: movie.getEndAiring()!),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.blue,
                        ),
                        child: Text(
                          movie.isAiring() ? "Sedang Tayang" : "Upcoming",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0.0, 4.0, 12.0, 0.0),
                      child: FutureBuilder(
                        future: isFavorite,
                        builder: (BuildContext context,
                            AsyncSnapshot<bool?> snapshot) {
                          if (snapshot.hasData) {
                            return IconButton(
                                onPressed: () async {
                                  String msg = "";
                                  if (snapshot.data!) {
                                    msg = "Film telah dihapus dari favorit";
                                  } else {
                                    msg = "Film telah ditambahkan ke favorit";
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(msg)));
                                  setState(() {
                                    isFavorite = FireAuth.toggleUserFavorite(
                                        movie_id: movie.getID());
                                  });
                                },
                                icon: Icon(
                                  snapshot.data!
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  color: Colors.blue,
                                ));
                          }
                          return IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite_rounded,
                                color: Colors.blue,
                              ));
                        },
                      ),
                      // child: IconButton(
                      //   iconSize: 48.0,
                      //   padding: EdgeInsets.zero,
                      //   icon: Icon(
                      //     isFavorite
                      //         ? Icons.favorite_rounded
                      //         : Icons.favorite_border_rounded,
                      //     color: Colors.blue,
                      //   ),
                      //   onPressed: (() async {
                      //     // isFavorite = !isFavorite;
                      //     FireAuth.AddUserFavorite(movie_id: movie.getID());
                      //     setState(() {
                      //       isFavorite = !isFavorite;
                      //     });
                      //     final _snackBar = SnackBar(
                      //       content: Text(isFavorite
                      //           ? "Telah ditambahkan ke favorit"
                      //           : "Telah dihapus dari favorit"),
                      //     );
                      //     ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      //   }),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
            //Tab Bar
            TabBar(
              controller: _tabMainController,
              labelColor: Colors.blue,
              tabs: [
                Tab(
                  text: "Info",
                ),
                Tab(
                  text: "Review",
                ),
                Tab(
                  text: "Beli Tiket",
                ),
              ],
            ),
            // Content TabBar
            Container(
              child: _tabMainContent()[_tabMainIndex],
            )
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //     height: 45,
      //     child: ElevatedButton(onPressed: (() {}), child: Text("Beli Tiket"))),
    );
  }
}
