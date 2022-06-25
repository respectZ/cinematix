import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../widget/cinematix_bar.dart';

import 'package:cinematix/model/fire_auth.dart';
import 'package:cinematix/model/user_cinematix.dart';
import 'package:shimmer/shimmer.dart';

bool _validateNomorHP(String nomor_hp) =>
    RegExp(r"[0-9]{10,14}$").hasMatch(nomor_hp);

class Profil extends StatefulWidget {
  Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  ImageProvider<Object>? filePhotoProfile;
  Future<UserCinematix?> userCinematix = FireAuth.getCurrentUser();
  final ImagePicker _picker = ImagePicker();
  bool isEditing = false;
  TextEditingController c_namaLengkap = TextEditingController();
  TextEditingController c_nomorHP = TextEditingController();
  int statusName = 0;

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                          // Avatar
                          FutureBuilder<UserCinematix?>(
                              future: userCinematix,
                              builder: (BuildContext context,
                                  AsyncSnapshot<UserCinematix?> snapshot) {
                                if (filePhotoProfile == null &&
                                    snapshot.hasData &&
                                    snapshot.data!.getPhoto() != null) {
                                  return CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 40.0,
                                    backgroundImage: NetworkImage(
                                        snapshot.data!.getPhoto()!),
                                  );
                                }
                                return CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 40.0,
                                  backgroundImage: filePhotoProfile,
                                  child: filePhotoProfile != null
                                      ? null
                                      : Icon(Icons.person_rounded),
                                );
                              }),
                          // CircleAvatar(
                          //   backgroundColor: Colors.grey,
                          //   radius: 40.0,
                          //   backgroundImage: filePhotoProfile,
                          //   child: filePhotoProfile != null
                          //       ? null
                          //       : Icon(Icons.person_rounded),
                          // ),
                          FutureBuilder<UserCinematix?>(
                              future: userCinematix,
                              builder: (BuildContext context,
                                  AsyncSnapshot<UserCinematix?> snapshot) {
                                return Positioned(
                                    bottom: -10.0,
                                    right: -2.0,
                                    child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: ((builder) => _bottomSheet(
                                                context: context,
                                                picker: _picker,
                                                callback: (XFile? xFile) async {
                                                  if (snapshot.hasData) {
                                                    snapshot.data!.uploadPhoto(
                                                        path: xFile!.path);
                                                  }
                                                  setState(() {
                                                    filePhotoProfile =
                                                        Image.file(File(
                                                                xFile!.path))
                                                            .image;
                                                  });
                                                })),
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
                                        )));
                              }),
                        ],
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      // Nama & no hp
                      Expanded(
                        child: FutureBuilder<UserCinematix?>(
                            future: userCinematix,
                            builder: (BuildContext context,
                                AsyncSnapshot<UserCinematix?> snapshot) {
                              if (snapshot.hasData) {
                                if (statusName == 0)
                                  c_namaLengkap.text = snapshot.data!.getName();
                                c_nomorHP.text = snapshot.data!.getPhone();

                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // isediting dll
                                          isEditing
                                              ? (SizedBox(
                                                  width: 120,
                                                  child: TextField(
                                                    controller: c_namaLengkap,
                                                    decoration: InputDecoration(
                                                      hintText: 'nama lengkap',
                                                      isDense: true,
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .blue)),
                                                    ),
                                                  ),
                                                ))
                                              : (Text(
                                                  c_namaLengkap.text,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                )),
                                          isEditing
                                              ? Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () async {
                                                          if (!_validateNomorHP(
                                                              c_nomorHP.text)) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        content:
                                                                            Text("Nomor HP tidak valid.")));
                                                            return;
                                                          }
                                                          if (c_namaLengkap
                                                              .text.isEmpty) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        content:
                                                                            Text("Nama lengkap tidak boleh kosong.")));
                                                            return;
                                                          }
                                                          await FireAuth.updateUser(
                                                              displayName:
                                                                  c_namaLengkap
                                                                      .text,
                                                              phoneCredential:
                                                                  c_nomorHP
                                                                      .text);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      "Data berhasil diperbarui.")));
                                                          setState(
                                                            () {
                                                              userCinematix =
                                                                  FireAuth
                                                                      .getCurrentUser();
                                                              isEditing = false;
                                                              statusName = 1;
                                                            },
                                                          );
                                                        },
                                                        icon: Icon(Icons.save)),
                                                    IconButton(
                                                        onPressed: () =>
                                                            setState(
                                                              () {
                                                                userCinematix =
                                                                    FireAuth
                                                                        .getCurrentUser();
                                                                isEditing =
                                                                    false;
                                                                statusName = 0;
                                                              },
                                                            ),
                                                        icon: Icon(Icons.close))
                                                  ],
                                                )
                                              : IconButton(
                                                  onPressed: () => setState(
                                                        () {
                                                          isEditing = true;
                                                        },
                                                      ),
                                                  icon: Icon(Icons.edit))
                                        ],
                                      ),
                                      isEditing
                                          ? SizedBox(
                                              width: 120,
                                              child: TextField(
                                                controller: c_nomorHP,
                                                decoration: InputDecoration(
                                                  hintText: 'nomor hp',
                                                  isDense: true,
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .blue)),
                                                ),
                                              ),
                                            )
                                          : Text(
                                              c_nomorHP.text,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            )
                                    ]);
                              } else {
                                return CircularProgressIndicator();
                              }
                            }),
                      ),
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
                        onPressed: () => Get.toNamed("profile/favorite"),
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
                          onPressed: () => Get.toNamed("profile/voucher"),
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
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Get.offAndToNamed("/login");
                        },
                        iconSize: 30,
                        icon: Icon(Icons.arrow_forward))

//                   Icon(Icons.arrow_forward, size: 30,)
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      // bottomNavigationBar: const CinematixBar(),
    );
  }
}

Widget _bottomSheet(
    {required BuildContext context,
    required ImagePicker picker,
    required Function(XFile?) callback}) {
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
              try {
                XFile? res = await picker.pickImage(source: ImageSource.camera);
                callback(res);
              } on PlatformException catch (err) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(err.message ?? "Terjadi error."),
                      );
                    });
              }
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
