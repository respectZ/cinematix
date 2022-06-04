import 'package:flutter/material.dart';

class CinematixContainer extends StatefulWidget {
  List<Widget> formChild = [];
  List<Widget> bottomChild = [];
  MainAxisAlignment? alignment;

  CinematixContainer(
      {Key? key,
      required this.formChild,
      required this.bottomChild,
      this.alignment})
      : super(key: key);

  @override
  _CinematixContainerState createState() => _CinematixContainerState();
}

class _CinematixContainerState extends State<CinematixContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Center(
            child: Column(
                verticalDirection: VerticalDirection.up,
                children: widget.bottomChild),
          ),
        ),
        Container(
          color: Colors.blue,
          height: MediaQuery.of(context).size.height / 2,
        ),
        Center(
            child: Container(
          width: 300,
          height: 390,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
          child: Column(
            mainAxisAlignment: widget.alignment ?? MainAxisAlignment.start,
            children: widget.formChild,
          ),
        ))
      ],
    );
  }
}
