// ignore_for_file: dead_code

import 'dart:html';

import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Profil', 
        style: TextStyle(color: Colors.blue),),
      ),
    
    body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 20.0,
                child: Image.asset('ria'),
              ),

              SizedBox(width: 30,),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Ria Fitriyah'),
                  Text('0938276325'),
                ],
              )
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Favorit Saya'),
              Text('Voucher Saya'),
              Text('Logout')
            ],
          )
        ],
      )),
    );
  }
  
}