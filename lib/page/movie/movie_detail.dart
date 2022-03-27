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
  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          // Banner
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
          ),
          // Thumbnail
          Positioned(
            top: 120,
            left: 10,
            child: Container(
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
