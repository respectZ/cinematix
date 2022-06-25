import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String id;
  final Timestamp airing;
  final DocumentReference cinema_movie;
  final DocumentReference cinema_room;
  String? cinema_room_name;

  Schedule(
      {required this.id,
      required this.airing,
      required this.cinema_movie,
      required this.cinema_room});
  factory Schedule.fromJSON(Map<String, dynamic> json) => Schedule(
      id: json["id"] as String,
      airing: json["airing"] as Timestamp,
      cinema_movie: json["cinema_movie"] as DocumentReference,
      cinema_room: json["cinema_room"] as DocumentReference);

  String getDate() {
    List<String> months =
        "Januari Februari Maret April Mei Juni Juli Agustus September Oktober November Desember"
            .split(" ");
    List<String> hari = "Senin Selasa Rabu Kamis Jumat Sabtu Minggu".split(" ");
    DateTime date = airing.toDate();
    return "${date.day} ${months[date.month - 1]}\n${hari[date.weekday - 1]}";
  }

  String getTime() {
    DateTime date = airing.toDate();
    return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  String getDateGroup() {
    DateTime date = airing.toDate();
    return "${date.day}${date.month}";
  }

  Timestamp getAiring() => airing;

  Future<DocumentSnapshot<Object?>> getRoom() async {
    return cinema_room.get();
  }
}
