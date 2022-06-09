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
  List<dynamic>? __schedule;
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

  List<dynamic>? getSchedule() => __schedule;
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

      // get cinema room where cinema = cinema_id
      var b = await CinematixFirestore.findByReference(
          collection_name: "cinema_room",
          reference_name: "cinema",
          reference_value: cinema_id);

      List<Map<String, dynamic>> cinema_rooms =
          await CinematixFirestore.findByReference(
              collection_name: "cinema_room",
              reference_name: "cinema",
              reference_value: cinema_id);
      for (Map<String, dynamic> cinema_room in cinema_rooms) {
        // get cinema_chair where cinema_room = cinema_room_id
        var c = await CinematixFirestore.findByReference(
            collection_name: "cinema_chair",
            reference_name: "cinema_room",
            reference_value: cinema_room["id"]);

        // print(c.toString());
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
            /*
                get schedule, where cinema_movie ==
                then get cinema_room
                then get ticket
                */
            // schedule airing
            var schedules = await CinematixFirestore.findByReference(
                collection_name: "schedule",
                reference_name: "cinema_movie",
                reference_value: cinema_room_movie["id"]);
            // get cinema room where cinema = cinema_id
            // var b = await CinematixFirestore.findByReference(
            //     collection_name: "cinema_room",
            //     reference_name: "cinema",
            //     reference_value: cinema_id);
            // get cinema_chair where cinema_room = cinema_room_id
            // var c = await CinematixFirestore.findByReference(
            //     collection_name: "cinema_chair",
            //     reference_name: "cinema_room",
            //     reference_value: cinema_room["id"]);
            // get ticket where cinema_chair = cinema_chair_id
            // print(a.toString());
            // print(cinema_room_movie["id"]);
            // print(a.toString());
            // print(b.toString());
            // need to get ticket equal schedule & cinema_chair nooooooo
            List<dynamic> tickets = [];
            for (var schedule in schedules) {
              for (var chair in c) {
                var resTickets = await FirebaseFirestore.instance
                    .collection('ticket')
                    .where('cinema_chair',
                        isEqualTo: FirebaseFirestore.instance
                            .doc("cinema_chair/${chair['id']}"))
                    .where('schedule',
                        isEqualTo: FirebaseFirestore.instance
                            .doc("schedule/${schedule['id']}"))
                    .get();
                tickets.add(resTickets.docs.map((e) => e.data()) as Object);
              }
            }
            // var d = await CinematixFirestore.findByReference(collection_name: "ticket", reference_name: "cinema_chair", reference_value: );
            // var d = await CinematixFirestore.findByReference(
            //     collection_name: "ticket",
            //     reference_name: "cinema_chair",
            //     reference_value: cinema_room_movie["id"]);
            List<dynamic> schedule = schedules.map((e) {
              return {
                "airing": (e as Map<String, dynamic>)["airing"],
                "room": b,
                "ticket": tickets,
              };
            }).toList();
            // print(schedule.toString());
            Movie movie = Movie.fromJSON({
              "id": _temp.id,
              "start_airing": cinema_room_movie["start_airing"],
              "end_airing": cinema_room_movie["end_airing"],
              "schedule": schedule,
              ..._temp.data() as Map<String, dynamic>
            });
            // need get schedule
            /*
            also need to get user_ticket, check is sold or not
            "schedule": [
              {
                "airing": datetime,
                "room": audi,
                "ticket": [
                  {
                    "kursi": cinema_chair_id,
                    "harga": "450000"
                  }
                ]
              }
            ]

            "schedule": [
              {
                "airing": datetime,
                "room": [],
                "ticket": [
                  {
                    "kursi": cinema_chair_id,
                    "harga": 450000
                  }
                ]
              }
            ]

            trus foreach room = audi, get it, display if its not in schedule 
            or
            foreach room = audi, get kursi -> display
            */
            movies.add(movie);
          }
        }
      }
      print(movies.toString());
      return movies;
    }
  }
}
