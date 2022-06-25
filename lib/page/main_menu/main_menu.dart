import 'package:cinematix/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../widget/cinematix_home.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final prefs = SharedPreferences.getInstance();
  late Future<List<Movie>> movies;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: prefs,
      builder: (BuildContext context, AsyncSnapshot<SharedPreferences> _prefs) {
        if (_prefs.hasData) {
          String cinema_id =
              _prefs.data!.getString("cinema") ?? "ChIJJ3jvqetXeC4R7W8Ltg_dgdA";
          if (_prefs.data!.getString("cinema") == null) {
            _prefs.data!.setString("cinema", "ChIJJ3jvqetXeC4R7W8Ltg_dgdA");
          }
          movies = Movie.getMovies(cinema_id: cinema_id);
          return FutureBuilder<List<Movie?>>(
              future: movies,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Movie?>> snapshot) {
                if (!snapshot.hasError) {
                  if (snapshot.hasData) {
                    List<Movie?> movies = snapshot.data!;
                    List<Movie?> movies_ongoing =
                        movies.where((element) => element!.isAiring()).toList();
                    List<Movie?> movies_upcoming = movies
                        .where((element) => !element!.isAiring())
                        .toList();
                    return CinematixHome(
                        onGoing: movies_ongoing,
                        upComing: movies_upcoming,
                        cinemaID: cinema_id);
                  } else {
                    return Container();
                  }
                } else {
                  return Text("Error");
                }
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
