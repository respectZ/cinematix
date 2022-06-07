import 'package:cinematix/model/service/cinematix_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String __id;
  final String __title;
  final String __image;
  final String __pv;
  final String __description;
  final String __rating;
  final int __happiness;
  final int __length;
  DateTime? __start_airing;
  DateTime? __end_airing;

  Movie(
      {required String id,
      required String title,
      required String image,
      String? pv,
      String? description,
      String? rating,
      int? happiness,
      int? length,
      Timestamp? start_airing,
      Timestamp? end_airing})
      : __id = id,
        __title = title,
        __image = image,
        __pv = pv!,
        __description = description!,
        __rating = rating!,
        __happiness = happiness!,
        __length = length!,
        __start_airing = start_airing != null
            ? DateTime.fromMillisecondsSinceEpoch(start_airing.seconds * 1000)
            : null,
        __end_airing = end_airing != null
            ? DateTime.fromMillisecondsSinceEpoch(end_airing.seconds * 1000)
            : null;

  factory Movie.fromJSON(Map<String, dynamic> json) => Movie(
      id: json["id"] as String,
      title: json["title"] as String,
      image: json['image'] as String,
      pv: json['pv'] as String,
      description: json['description'] as String,
      rating: json['rating'] as String,
      happiness: json['happiness'] as int,
      length: json['length'] as int,
      start_airing: json['start_airing'] as Timestamp?,
      end_airing: json['end_airing'] as Timestamp?);

  String getID() => __id;
  String getTitle() => __title;
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

      List<Map<String, dynamic>> cinema_rooms =
          await CinematixFirestore.findByReference(
              collection_name: "cinema_room",
              reference_name: "cinema",
              reference_value: cinema_id);
      for (Map<String, dynamic> cinema_room in cinema_rooms) {
        List<Map<String, dynamic>> cinema_room_movies =
            await CinematixFirestore.findByReference(
                collection_name: "cinema_movie",
                reference_name: "cinema_room",
                reference_value: cinema_room["id"]);
        if (cinema_room_movies.isNotEmpty) {
          // movie still instance of cinema_movie, need to convert instance of movie
          for (Map<String, dynamic> cinema_room_movie in cinema_room_movies) {
            var _temp =
                await (cinema_room_movie["movie"] as DocumentReference).get();
            Movie movie = Movie.fromJSON({
              "id": _temp.id,
              "start_airing": cinema_room_movie["start_airing"],
              "end_airing": cinema_room_movie["end_airing"],
              ..._temp.data() as Map<String, dynamic>
            });
            movies.add(movie);
          }
          // movies.addAll(cinema_room_movie["movie"]);
        }
      }
      // return movies.map((e) => Movie.fromJSON(e)).toList();
      return movies;
    }
  }
}
