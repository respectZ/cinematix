import 'dart:ffi';

import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  var text;

  Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading : Icon(Icons.arrow_back),
        iconTheme: IconThemeData(
          color: Colors.blue,),
        backgroundColor: Colors.white,
        title: Text('Profil', 
        style: TextStyle(color: Colors.blue),),
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
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 40.0,
                child: Image.asset('ria'),
              ),

              SizedBox(width: 40,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ria Fitriyah',
                  style: TextStyle(fontSize: 16,),),
                  Text('0938276325',
                  style: TextStyle(fontSize: 16),),
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
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 5,),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Favorit Saya', style: TextStyle(fontSize: 20,)),

                  // SizedBox(width: 80,),

                  Icon(Icons.arrow_forward, size: 30,)
                ],
              ),
            ),
            Container(
              //  color: Colors.blue,
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 5,),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8,),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Voucher Saya', style: TextStyle(fontSize: 20,)),

                  // SizedBox(width: 80,),

                  Icon(Icons.arrow_forward,size: 30,)
                ],
              )
            ),
            Container(
              // color: Colors.blue,
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 5,),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8,),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Logout', style: TextStyle(fontSize: 20,)),

                  // SizedBox(width: 80,),

                  Icon(Icons.arrow_forward, size: 30,)
                ],
              ),),
            
        ],
      )
      bottomNavigationBar: const CinematixBar(),
    ]));
  }
  
}
