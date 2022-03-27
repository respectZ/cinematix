import '../../widget/cinematix_bar.dart';

import '../../core/movie.dart';

import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  List<Movie> MovieList = [];

  MovieDetailPage({Key? key}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  TextStyle TitleStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
          onPressed: () {},
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
                            height: 180,
                            width: 111,
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
                                width: 250,
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
                                  Text("Durasi"),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  SizedBox(
                                    width: 170,
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
                                  Text("Rating"),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  SizedBox(
                                    width: 170,
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
                                  Text("Sutradara"),
                                  SizedBox(
                                    width: 29,
                                  ),
                                  SizedBox(
                                    width: 170,
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
                                  Text("Genre"),
                                  SizedBox(
                                    width: 53,
                                  ),
                                  SizedBox(
                                    width: 170,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.date_range_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text("10/03/2022 - 23/03/2022"),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.favorite)),
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
                      "Currently Airing",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            // Sinopsis
            Container(
              margin: EdgeInsets.fromLTRB(12.0, 12.0, 0.0, 0.0),
              width: screenWidth - 24,
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
            // Review
            SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    );
  }
}
