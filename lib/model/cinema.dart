import 'package:cinematix/model/service/cinematix_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cinema {
  final int __id;
  final String __name;
  final String __latitude;
  final String __magnitude;

  Cinema(
      {required int id,
      required String name,
      String? latitute,
      String? magnitude})
      : __name = name,
        __id = id,
        __latitude = latitute!,
        __magnitude = magnitude!;

  factory Cinema.fromJSON(Map<String, dynamic> json) => Cinema(
      name: json['name'] as String,
      id: json['id'] as int,
      latitute: json['latitude'] as String,
      magnitude: json['magnitude'] as String);

  String getName() => __name;
  int getId() => __id;
  String getLatitude() => __latitude;
  String getMagnitude() => __magnitude;

  static Future<String> getCinemaName({required String cinema_id}) async {
    var res = await FirebaseFirestore.instance
        .collection("cinema")
        .doc(cinema_id)
        .get();
    return res.data()!["name"];
  }

  static Future<void> newCinema(
      {required String cinema_id,
      required String name,
      required double lat,
      required double lng}) async {
    await FirebaseFirestore.instance
        .collection("cinema")
        .doc(cinema_id)
        .set({"lang": lng, "lat": lat, "name": name});
  }
}
