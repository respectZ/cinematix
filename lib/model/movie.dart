import 'package:cinematix/model/service/cinematix_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String __id;
  final String __title;
  final String __director;
  final String __image;
  final String __pv;
  final String __description;
  final String __rating;
  final int __happiness;
  final int __length;
  Object? __schedule;
  DateTime? __start_airing;
  DateTime? __end_airing;

  Movie(
      {required String id,
      required String title,
      required String director,
      required String image,
      String? pv,
      String? description,
      String? rating,
      int? happiness,
      int? length,
      Timestamp? start_airing,
      Timestamp? end_airing,
      List<dynamic>? schedule})
      : __id = id,
        __title = title,
        __director = director,
        __image = image,
        __pv = pv!,
        __description = description!,
        __rating = rating!,
        __happiness = happiness!,
        __length = length!,
        __schedule = schedule,
        __start_airing = start_airing != null
            ? DateTime.fromMillisecondsSinceEpoch(start_airing.seconds * 1000)
            : null,
        __end_airing = end_airing != null
            ? DateTime.fromMillisecondsSinceEpoch(end_airing.seconds * 1000)
            : null;
  factory Movie.fromJSON(Map<String, dynamic> json) => Movie(
      id: json["id"] as String,
      title: json["title"] as String,
      schedule: json["schedule"] as List<dynamic>?,
      director: json["director"] as String,
      image: json['image'] as String,
      pv: json['pv'] as String,
      description: json['description'] as String,
      rating: json['rating'] as String,
      happiness: json['happiness'] as int,
      length: json['length'] as int,
      start_airing: json['start_airing'] as Timestamp?,
      end_airing: json['end_airing'] as Timestamp?);

  static Future<Movie> fromID({required String movie_id}) async {
    var snapshot = (await FirebaseFirestore.instance
        .collection("movie")
        .doc(movie_id)
        .get());
    var data = snapshot.data()!;
    data["id"] = snapshot.id;
    return Movie.fromJSON(data);
  }

  Object? getSchedule() => __schedule;
  bool isAiring() =>
      DateTime.now().isAfter(__start_airing!) &&
      DateTime.now().isBefore(__end_airing!);
  String getDurationString() => __length ~/ 60 > 0
      ? "${__length ~/ 60} jam ${__length % 60} menit"
      : "${__length} menit";
  String getID() => __id;
  String getTitle() => __title;
  String getDirector() => __director;
  String getImage() => __image;
  String getPV() => __pv;
  String getDescription() => __description;
  String getRating() => __rating;
  int getHappiness() => __happiness;
  int getlength() => __length;
  DateTime? getStartAiring() => __start_airing;
  DateTime? getEndAiring() => __end_airing;

  static Future<List<Movie>> getMovies({String? cinema_id}) async {
    if (cinema_id == null) {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("movie").get();
      final _movies = querySnapshot.docs.map((e) => e.data()).toList();

      List<Movie> movies = _movies
          .map((e) => Movie.fromJSON(e as Map<String, dynamic>))
          .toList();
      return movies;
    } else {
      List<Movie> movies = [];

      // get all from cinema_movie where cinema = cinema
      var _movies = await CinematixFirestore.findByReference(
          collection_name: "cinema_movie",
          reference_name: "cinema",
          reference_value: cinema_id);
      // get cinema_chair
      var cinema_chairs = await CinematixFirestore.findByReference(
          collection_name: "cinema_chair",
          reference_name: "cinema",
          reference_value: cinema_id);
      for (var movie in _movies) {
        // movieData = isi dari movie[jujustu_kaisen_0]
        var movieData =
            (await (movie["movie"] as DocumentReference).get()).data();
        Movie mv = Movie.fromJSON({
          "id": movie["id"],
          "start_airing": movie["start_airing"],
          "end_airing": movie["end_airing"],
          ...(movieData as Map<String, dynamic>)
        });
        movies.add(mv);
      }
      /*
      get cinema_chair where cinema_room equal
      get ticket where schedule = schedule, cinema_chair =cinema_chair
      */
      /*
            problem: how the structure ?
            schedule: {
              audi #1: {
                "airing": airing,
                "tickets": []
              }
            }
            */
      print(movies.toString());
      return movies;
    }
  }

  static Future<void> getMovieSchedule(
      {required String movieID, required String cinemaID}) async {
    var cinema_rooms = await CinematixFirestore.findByReference(
        collection_name: "cinema_room",
        reference_name: "cinema",
        reference_value: cinemaID);
    var cc = [];
    for (var cinema_room in cinema_rooms) {
      var chairs = await CinematixFirestore.findByReference(
          collection_name: "cinema_chair",
          reference_name: "cinema_room",
          reference_value: cinema_room["id"]);
      cc.add(chairs);
    }
  }
}
