import 'package:cinematix/model/schedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<Widget> _generate(List<Schedule> jadwal) {
  // group by audi
  Map<String, List<Schedule>> groupedByRoom = {};
  for (var j in jadwal) {
    if (groupedByRoom[j.cinema_room_name] == null) {
      groupedByRoom[j.cinema_room_name!] = [];
    }
    groupedByRoom[j.cinema_room_name]!.add(j);
  }
  return groupedByRoom.entries.map((e) {
    return Card(
      child: ListTile(
        title: Text(e.value[0].cinema_room_name!),
        subtitle: Wrap(
          children: List<Widget>.generate(e.value.length, (index) {
            return Card(
              child: InkWell(
                onTap: () {
                  Get.toNamed("/movie_ticket",
                      arguments: {"schedule": e.value[index].id});
                },
                splashColor: Colors.blue.withAlpha(30),
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(e.value[index].getTime()),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }).toList();
}

class JadwalBoxNew extends StatefulWidget {
  final List<Schedule> jadwal;
  JadwalBoxNew({Key? key, required this.jadwal}) : super(key: key);

  @override
  State<JadwalBoxNew> createState() => _JadwalBoxNewState();
}

class _JadwalBoxNewState extends State<JadwalBoxNew> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _generate(widget.jadwal),
    );
  }
}
