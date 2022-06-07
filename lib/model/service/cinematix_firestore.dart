import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CinematixFirestore {
  static Future<List<Map<String, dynamic>>> findByReference(
      {required String collection_name,
      required String reference_name,
      required String reference_value}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(collection_name)
        .where(reference_name,
            isEqualTo: FirebaseFirestore.instance
                .doc("${reference_name}/${reference_value}"))
        .get();
    final data = querySnapshot.docs.map((e) {
      Map<String, dynamic> data = e.data() as Map<String, dynamic>;
      return {"id": e.id, ...data};
    }).toList();
    return data;
  }

  static Future<List<Map<String, dynamic>>> getAllFromCollection(
      {required String collection_name}) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collection_name).get();
    final data = querySnapshot.docs.map((e) {
      Map<String, dynamic> data = e.data() as Map<String, dynamic>;
      return {"id": e.id, ...data};
    }).toList();
    return data;
  }
}
