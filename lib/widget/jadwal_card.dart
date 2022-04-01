import 'dart:ffi';

import 'package:flutter/material.dart';

class JadwalBox extends StatefulWidget {
  final String NamaRuangan;
  final List<DateTime> ListWaktu;
  VoidCallback? callback;
  JadwalBox(
      {Key? key,
      required this.NamaRuangan,
      required this.ListWaktu,
      this.callback})
      : super(key: key);

  @override
  State<JadwalBox> createState() => _JadwalBoxState();
}

class _JadwalBoxState extends State<JadwalBox> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.NamaRuangan),
        subtitle: Wrap(
          children: List<Widget>.generate(
              widget.ListWaktu.length,
              (index) => Card(
                    child: InkWell(
                        onTap: widget.callback,
                        splashColor: Colors.blue.withAlpha(30),
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                              "${widget.ListWaktu[index].hour < 10 ? widget.ListWaktu[index].hour.toString().padLeft(2, '0') : widget.ListWaktu[index].hour}:${widget.ListWaktu[index].minute < 10 ? widget.ListWaktu[index].minute.toString().padLeft(2, '0') : widget.ListWaktu[index].minute}"),
                        )),
                  )),
        ),
      ),
    );
  }
}
