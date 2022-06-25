import 'package:cinematix/model/review.dart';
import 'package:cinematix/model/schedule.dart';
import 'package:cinematix/model/service/cinematix_firestore.dart';
import 'package:cinematix/model/user_cinematix.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final String __genre;
  Object? __schedule;
  DateTime? __start_airing;
  DateTime? __end_airing;
  double? __totalRating;

  Movie(
      {required String id,
      required String title,
      required String director,
      required String image,
      required String genre,
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
        __genre = genre,
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
      genre: json['genre'] as String,
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
    Movie movie = Movie.fromJSON(data);

    // get total rating
    var reviews = await CinematixFirestore.findByReference(
        collection_name: "review",
        reference_name: "movie",
        reference_value: movie_id);
    var total = 0.0;
    for (var review in reviews) {
      total += review["star_rating"] as double;
    }
    movie.__totalRating = total / reviews.length;
    movie.__totalRating =
        movie.__totalRating!.isNaN ? null : movie.__totalRating!;
    return movie;
  }

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
  String getGenre() => __genre;
  String getPV() => __pv;
  String getDescription() => __description;
  String getRating() => __rating;
  int getHappiness() => __happiness;
  int getlength() => __length;
  DateTime? getStartAiring() => __start_airing;
  DateTime? getEndAiring() => __end_airing;
  double? getTotalRating() => __totalRating;
  Future<double> getTotalReview() async {
    var reviews = await CinematixFirestore.findByReference(
        collection_name: "review",
        reference_name: "movie",
        reference_value: getID());
    var total = 0.0;
    for (var review in reviews) {
      total += review["star_rating"] as double;
    }
    return total / reviews.length;
  }

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
        var movieData = (await (movie["movie"] as DocumentReference).get())
            .data() as Map<String, dynamic>;
        var movieID = (await (movie["movie"] as DocumentReference).get()).id;
        Movie mv = Movie.fromJSON({
          "id": movieID,
          "start_airing": movie["start_airing"],
          "end_airing": movie["end_airing"],
          ...(movieData)
        });

        // get total rating
        var reviews = await CinematixFirestore.findByReference(
            collection_name: "review",
            reference_name: "movie",
            reference_value: movieID);
        var total = 0.0;
        for (var review in reviews) {
          total += review["star_rating"] as double;
        }
        mv.__totalRating = total / reviews.length;
        mv.__totalRating = mv.__totalRating!.isNaN ? null : mv.__totalRating!;
        movies.add(mv);
      }
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

  Future<void> addReview(
      UserCinematix user, double star_rating, String comment) async {
    var username = user.getUsername();
    var mv = getID();
    await FirebaseFirestore.instance.collection("review").add({
      "movie": FirebaseFirestore.instance.doc("movie/$mv"),
      "star_rating": star_rating,
      "comment": comment,
      "user": FirebaseFirestore.instance.doc("user/$username")
    });
  }

  Future<List<Review>> getReview() async {
    var review = (await CinematixFirestore.findByReference(
        collection_name: "review",
        reference_name: "movie",
        reference_value: getID()));
    List<Review> reviews = [];
    for (var r in review) {
      var user = await ((r["user"] as DocumentReference).get());
      Map<String, dynamic> u = user.data() as Map<String, dynamic>;
      r["user"] = user.id;
      r["name"] = u["nama"];
      r["photoURL"] = u["photoURL"];
      reviews.add(Review.fromJSON(r));
    }
    return reviews;
  }

  Future<List<Schedule>> getSchedule({required String cinema_id}) async {
    // get from cinema_movie, trus find yg match cinema & movie
    var cinema_movie = await CinematixFirestore.findByReference(
        collection_name: "cinema_movie",
        reference_name: "cinema",
        reference_value: cinema_id);
    String cinema_movieEqID = "";
    for (var cm in cinema_movie) {
      var temp_movie = await (cm["movie"] as DocumentReference).get();
      if (temp_movie.id == getID()) {
        cinema_movieEqID = cm["id"];
        break;
      }
    }
    var schedules = await CinematixFirestore.findByReference(
        collection_name: "schedule",
        reference_name: "cinema_movie",
        reference_value: cinema_movieEqID);
    var result = schedules.map((e) => Schedule.fromJSON(e)).toList();
    for (var i = 0; i < result.length; i++) {
      var cinema_r = (await result[i].getRoom()).data() as Map<String, dynamic>;
      result[i].cinema_room_name = cinema_r["name"];
    }
    return result;
  }
}
