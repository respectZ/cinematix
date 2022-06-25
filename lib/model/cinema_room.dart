import 'package:cinematix/model/cinema_chair.dart';
import 'package:cinematix/model/service/cinematix_firestore.dart';

class CinemaRoom {
  final String id;
  final String name;
  List<CinemaChair>? chairs;
  CinemaRoom({required this.id, required this.name});
  factory CinemaRoom.fromJSON(Map<String, dynamic> json) =>
      CinemaRoom(id: json["id"] as String, name: json["name"] as String);

  Future<void> intializeChairs() async {
    var _chairs = await CinematixFirestore.findByReference(
        collection_name: "cinema_chair",
        reference_name: "cinema_room",
        reference_value: id);
    chairs = _chairs.map((e) => CinemaChair.fromJSON(e)).toList();
  }
}
