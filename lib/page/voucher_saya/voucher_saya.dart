import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';

class VoucherSaya extends StatelessWidget {
  const VoucherSaya({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        title: Text("Voucher Saya", style: TextStyle(color: Colors.grey),),
      ),

    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          child: Row(
            children: [
              Image(
                image: AssetImage('img/ria5.jpeg'),
                width: 100,
                height: 100,),

              SizedBox(
                width: 20,
              ),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("The Batman", style: TextStyle(
                        fontSize: 20
                      ),),
                      Text("10%", style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),)
                    ],
                  ),
                 
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Icon(Icons.star_border,),
                  //     Icon(Icons.star_border),
                  //     Icon(Icons.star_border,),
                  //     Icon(Icons.star_border,),
                  //     Icon(Icons.star_border),
                  //   ],
                  // ),

                  Text("Diskon 10% untuk pembelian tiket semua film",
                  style: TextStyle(
                    fontSize: 16
                  ),)
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
              Image(
                image: AssetImage('img/ria5.jpeg'),
                width: 100,
                height: 100,),

              SizedBox(
                width: 20,
              ),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("ALL MOVIES", style: TextStyle(
                        fontSize: 20
                      ),),
                      Text("5%", style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),)
                    ],
                  ),
                 
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Icon(Icons.star_border,),
                  //     Icon(Icons.star_border),
                  //     Icon(Icons.star_border,),
                  //     Icon(Icons.star_border,),
                  //     Icon(Icons.star_border),
                  //   ],
                  // ),

                  Text("Diskon 5% untuk pembelian tiket semua film",
                  style: TextStyle(
                    fontSize: 16
                  ),)
                ],
              )
            ],
          ),
        )
      ],
    ),  
    );
  }
}