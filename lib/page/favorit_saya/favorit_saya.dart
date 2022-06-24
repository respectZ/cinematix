import 'dart:ffi';
import 'dart:ui';

import 'package:cinematix/widget/favorite_film.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/cinematix_bar.dart';

class FavoritSaya extends StatefulWidget {
  const FavoritSaya({Key? key}) : super(key: key);

  @override
  State<FavoritSaya> createState() => _FavoritSayaState();
}

class _FavoritSayaState extends State<FavoritSaya> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black45,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        title: Text(
          "Favorit Saya",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: Column(
          children: [FavoriteFilm(movie_id: "jujutsu_kaisen_0")],
        ),
      ),
      // body: FutureBuilder<>
      // body: StreamBuilder<QuerySnapshot<Object?>>(
      //     stream: controller.streamData(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.active) {
      //         var ListAllDocs = snapshot.data!.docs;
      //         return ListView.builder(
      //           itemBuilder: (context, index) => ListTile(
      //               title: Text(
      //                 '${(ListAllDocs[index].data() as Map<String, dynamic>)['movie']}',
      //                 style: TextStyle(fontSize: 20),
      //               ),
      //               subtitle: Text(
      //                 '${(ListAllDocs[index].data() as Map<String, dynamic>)['status']}',
      //                 style: TextStyle(fontSize: 10),
      //               )),
      //         );
      //       }
      //       ;
      //     })
      /*Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: EdgeInsets.all(10),
            elevation: 10,
            child: Row(
              children: [
                // Image(
                //   image: AssetImage('img/ria6.jpeg'),
                //   width: 100,
                //   height: 100,
                // ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "The Batman",
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.star_border,
                          color: Colors.blue,
                        ),
                        Icon(Icons.star_border, color: Colors.blue),
                        Icon(Icons.star_border, color: Colors.blue),
                        Icon(Icons.star_border, color: Colors.blue),
                        Icon(Icons.star_border),
                      ],
                    ),
                    Text(
                      "Kamu sudah memberikan review",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                )
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(10),
            elevation: 10,
            child: Row(
              children: [
                // Image(
                //   image: AssetImage('img/ria5.jpeg'),
                //   width: 100,
                //   height: 100,
                // ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "The Batman",
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.star_border,
                        ),
                        Icon(Icons.star_border),
                        Icon(
                          Icons.star_border,
                        ),
                        Icon(
                          Icons.star_border,
                        ),
                        Icon(Icons.star_border),
                      ],
                    ),
                    Text(
                      "Kamu belum memberikan review",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),*/
      // ,
      bottomNavigationBar: const CinematixBar(),
    );
  }
}
