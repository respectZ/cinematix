import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Review {
  final DocumentReference __movie;
  final String __user;
  final double __starRating;
  final String __comment;
  String? __name;
  ImageProvider<Object>? __photo;
  String? __photoURL;

  Review(
      {required DocumentReference movie,
      required String user,
      required double starRating,
      String? comment,
      String? name,
      String? photoURL})
      : __movie = movie,
        __user = user,
        __starRating = starRating,
        __comment = comment!,
        __name = name,
        __photoURL = photoURL;

  factory Review.fromJSON(Map<String, dynamic> json) => Review(
      movie: json['movie'] as DocumentReference,
      user: json['user'] as String,
      starRating: json['star_rating'] as double,
      comment: json['comment'] as String,
      name: json['name'],
      photoURL: json['photoURL'] as String?);

  DocumentReference getMovie() => __movie;
  String getUser() => __user;
  double getStarRating() => __starRating;
  String getComment() => __comment;
  String? getName() => __name;
  ImageProvider<Object>? getPhoto() =>
      __photoURL != null ? NetworkImage(__photoURL!) : null;
}
