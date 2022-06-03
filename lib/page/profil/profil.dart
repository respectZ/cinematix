import 'dart:ffi';
import 'dart:io';
//import 'dart:js';

import 'package:cinematix/page/voucher_saya/voucher_saya.dart';
import 'package:cinematix/page/favorit_saya/favorit_saya.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../widget/cinematix_bar.dart';

class Profil extends StatefulWidget {
  Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  XFile? photoProfile;

  final ImagePicker _picker = ImagePicker();

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black45,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Profil',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 30,
              left: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 40.0,
                          backgroundImage: photoProfile != null
                              ? Image.file(File(photoProfile!.path)).image
                              : null,
                          // child: Image.asset('ria'),
                          child: photoProfile != null
                              ? null
                              : Icon(Icons.person_rounded),
                        ),
                        Positioned(
                            bottom: -10.0,
                            right: -2.0,
                            child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => _bottomSheet(
                                        picker: _picker,
                                        callback: (XFile? xFile) =>
                                            setState(() {
                                              photoProfile =
                                                  xFile ?? photoProfile;
                                            }))),
                                  );
                                },
                                child: Container(
                                  height: 50.0,
                                  width: 25.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue,
                                    size: 17.0,
                                  ),
                                )))
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ria Fitriyah',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '0938276325',
                            style: TextStyle(fontSize: 16),
                          ),
                        ])
                  ],
                ),
              ],
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: Colors.blue,
              padding: EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 5,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Favorit Saya',
                      style: TextStyle(
                        fontSize: 20,
                      )),

                  // SizedBox(width: 80,),

                  IconButton(
                      onPressed: () => Get.to("profil/favorit_saya"),
                      iconSize: 30,
                      icon: Icon(Icons.arrow_forward))

//                   Icon(Icons.arrow_forward, size: 30,)
                ],
              ),
            ),
            Container(
                //  color: Colors.blue,
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                  left: 5,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Voucher Saya',
                        style: TextStyle(
                          fontSize: 20,
                        )),

                    // SizedBox(width: 80,),
                    IconButton(
                        onPressed: () => Get.toNamed("profil/voucher_saya"),
                        iconSize: 30,
                        icon: Icon(Icons.arrow_forward))

//                   Icon(Icons.arrow_forward,size: 30,)
                  ],
                )),
            Container(
              // color: Colors.blue,
              padding: EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 5,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Logout',
                      style: TextStyle(
                        fontSize: 20,
                      )),

                  // SizedBox(width: 80,),
                  IconButton(
                      onPressed: () {},
                      iconSize: 30,
                      icon: Icon(Icons.arrow_forward))

//                   Icon(Icons.arrow_forward, size: 30,)
                ],
              ),
            ),
          ],
        )
      ]),
      bottomNavigationBar: const CinematixBar(),
    );
  }
}

Widget _bottomSheet(
    {required ImagePicker picker, required Function(XFile?) callback}) {
  return Container(
    height: 100.0,
    width: 200.0,
    margin: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    child: Column(
      children: <Widget>[
        Text(
          "Choose profile photo",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.camera),
            onPressed: () async {
              Get.back();
              XFile? res = await picker.pickImage(source: ImageSource.camera);
              callback(res);
            },
            label: Text("Camera"),
          ),
          TextButton.icon(
            icon: Icon(Icons.image),
            onPressed: () async {
              Get.back();
              XFile? res = await picker.pickImage(source: ImageSource.gallery);
              callback(res);
            },
            label: Text("Gallery"),
          ),
        ])
      ],
    ),
  );
}
