import 'package:cinematix/widget/jadwal_card.dart';

import '../../widget/reviewbox.dart';

import 'dart:developer';

import '../../core/movie.dart';

import 'package:flutter/material.dart';

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
  bool isFavorite = true;
  late TabController _tabMainController;
  late TabController _tabJadwalController;
  int _tabMainIndex = 0;
  int _tabJadwalIndex = 0;

  List<Tab> JadwalList = [];

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
                    Text("Second Sword Art Online: Progressive movie."),
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
                Row(
                  children: [
                    Icon(
                      Icons.create_rounded,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Tulis Review")
                  ],
                ),
                Divider(
                  thickness: 2.0,
                ),
                SizedBox(
                  height: 10,
                ),
                ReviewBox(
                  time: DateTime.now(),
                  comment: "Hebat",
                  star: 4.5,
                ),
                SizedBox(
                  height: 10,
                ),
                ReviewBox(
                  photoProfile: NetworkImage(
                      "https://yt3.ggpht.com/-IdVo-vK7pr0VRjJDdza1-t1Edjce1Rd1R1hon_3SRIzuQ-XVBTWOJj-UfwYPp8y40KM197_y4o=s900-c-k-c0x00ffffff-no-rj"),
                  name: "Zeta",
                  time: DateTime.now(),
                  comment: "Tidak Hebats",
                  star: 1,
                ),
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
              tabs: JadwalList,
            ),
          ),
          _tabJadwalContent()[_tabJadwalIndex],
        ],
      ),
    ];
  }

  List<Widget> _tabJadwalContent() {
    return List<Widget>.generate(
        _tabJadwalController.length,
        (_) => Column(
              children: List<Widget>.generate(
                  4,
                  (index) => JadwalBox(
                        NamaRuangan: "Audi ${index + 1}",
                        ListWaktu: List<DateTime>.generate(
                            5, (index2) => DateTime.now()),
                        callback: () => {log("${index}")},
                      )),
            ));
  }

  @override
  void initState() {
    super.initState();
    _tabMainController = TabController(length: 3, vsync: this);
    _tabMainController.addListener(_tabSection);

    JadwalList = new List<Tab>.generate(
        7, (index) => Tab(text: "${index + 10} Maret\nSelasa"));

    _tabJadwalController =
        TabController(length: JadwalList.length, vsync: this);
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
          "CINEMATIX",
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
                  height: screenHeight / 1.8,
                ),
                // Banner
                Container(
                  height: 200,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Color.fromARGB(255, 255, 255, 255),
                            BlendMode.darken),
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://cdn.myanimelist.net/s/common/uploaded_files/1635784561-2e7ef92151ba666376667b57500afbf9.jpeg")),
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
                                image: NetworkImage(
                                    "https://cdn.myanimelist.net/images/anime/1346/121728.jpg"),
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
                                  "Sword Art Online: Progressive Movie - Kuraki Yuuyami no Scherzo",
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
                                    child: Text("Unknown"),
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
                                    child: Text("None"),
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
                                    child: Text("Unknown"),
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
                          Text("10/03/2022 - 23/03/2022"),
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
                          "Sedang Tayang",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0.0, 4.0, 12.0, 0.0),
                      child: IconButton(
                        iconSize: 48.0,
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: Colors.blue,
                        ),
                        onPressed: (() {
                          // isFavorite = !isFavorite;
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                          final _snackBar = SnackBar(
                            content: Text(isFavorite
                                ? "Telah ditambahkan ke favorit"
                                : "Telah dihapus dari favorit"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                        }),
                      ),
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
