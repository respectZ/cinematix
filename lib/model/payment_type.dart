import 'dart:convert';

import 'package:cinematix/model/service/cinematix_firestore.dart';
import 'package:flutter/material.dart';

class PaymentType {
  final String __id;
  final String __name;
  final ImageProvider<Object>? __icon;

  PaymentType(
      {required String id,
      required String name,
      required ImageProvider<Object>? icon})
      : __name = name,
        __id = id,
        __icon = icon;

  factory PaymentType.fromJSON(Map<String, dynamic> json) => PaymentType(
      name: json['name'] as String,
      id: json['id'] as String,
      icon: MemoryImage(base64Decode(json['icon'])));

  String getName() => __name;
  String getId() => __id;
  ImageProvider<Object>? getIcon() => __icon;

  static Future<List<PaymentType>> getPayments() async {
    var payments = (await CinematixFirestore.getAllFromCollection(
            collection_name: "payment_type"))
        .map((e) => PaymentType.fromJSON(e))
        .toList();
    return payments;
  }
}
