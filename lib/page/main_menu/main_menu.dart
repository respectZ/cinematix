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
                var now = DateTime.now();
                List<Widget> widgets_ongoing = [];
                List<Widget> widgets_upcoming = [];
                List<Movie?> movies = snapshot.data!;
                List<Movie?> movies_ongoing = movies.where((element) {
                  if (element!.getStartAiring() != null) {
                    if (now.isAfter(element.getStartAiring()!) &&
                        now.isBefore(element.getEndAiring()!)) {
                      return true;
                    }
                  }
                  return false;
                }).toList();
                List<Movie?> movies_upcoming = movies.where((element) {
                  return element!.getStartAiring() == null ||
                      now.isBefore(element.getStartAiring()!);
                }).toList();
                widgets_ongoing = movies_ongoing
                    .map((e) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(e!.getImage())))))
                    .toList();
                widgets_upcoming = movies_upcoming
                    .map((e) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(e!.getImage())))))
                    .toList();
                return CinematixHome(
                    onGoing: movies_ongoing, upComing: movies_upcoming);
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
