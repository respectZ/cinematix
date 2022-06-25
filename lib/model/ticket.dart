// class Ticket {
//   final int __id;
//   final int __cinemaChairId;
//   final int __price;

//   Ticket (
//     {required int id,
//     required int cinemaChairId,
//     required int price})
//     :__id = id,
//     __cinemaChairId = cinemaChairId,
//     __price = price;

//   factory Ticket.fromJSON(Map<String, dynamic> json) => Ticket(
//     id: json['id'] as int,
//     cinemaChairId: json['cinema_chair_id'] as int,
//     price: json['price'] as int);

//   int getId() => __id;
//   int getCinemaChairId() => __cinemaChairId;
//   int getPrice() => __price;

// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  final String id;
  final DocumentReference cinema_chair;
  final DocumentReference cinema_movie;
  final int price;
  final DocumentReference schedule;

  Ticket(
      {required this.id,
      required this.cinema_chair,
      required this.cinema_movie,
      required this.price,
      required this.schedule});

  factory Ticket.fromJSON(Map<String, dynamic> json) => Ticket(
      id: json["id"],
      cinema_chair: json["cinema_chair"] as DocumentReference,
      cinema_movie: json["cinema_movie"] as DocumentReference,
      price: json["price"] as int,
      schedule: json["schedule"] as DocumentReference);
}
