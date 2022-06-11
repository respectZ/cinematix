import 'package:cinematix/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../widget/cinematix_home.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  Future<List<Movie>> movies =
      Movie.getMovies(cinema_id: "ChIJJ3jvqetXeC4R7W8Ltg_dgdA");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Movie?>>(
          future: movies,
          builder:
              (BuildContext context, AsyncSnapshot<List<Movie?>> snapshot) {
            if (!snapshot.hasError) {
              if (snapshot.hasData) {
                List<Movie?> movies = snapshot.data!;
                List<Movie?> movies_ongoing =
                    movies.where((element) => element!.isAiring()).toList();
                List<Movie?> movies_upcoming =
                    movies.where((element) => !element!.isAiring()).toList();
                return CinematixHome(
                    onGoing: movies_ongoing,
                    upComing: movies_upcoming,
                    cinemaID: "ChIJJ3jvqetXeC4R7W8Ltg_dgdA");
              } else {
                return Container();
              }
            } else {
              return Text("Error");
            }
          }),
    );
  }
}
