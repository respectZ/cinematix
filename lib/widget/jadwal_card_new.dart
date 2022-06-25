import 'package:cinematix/model/cinema_chair.dart';
import 'package:cinematix/model/cinema_room.dart';
import 'package:cinematix/model/schedule.dart';
import 'package:cinematix/model/service/cinematix_firestore.dart';
import 'package:cinematix/model/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                onTap: () async {
                  var c_room_s = await (e.value[index].cinema_room.get());
                  var r = c_room_s.data() as Map<String, dynamic>;
                  r["id"] = c_room_s.id;
                  // find all cinema chair
                  var cc = await CinematixFirestore.findByReference(
                      collection_name: "cinema_chair",
                      reference_name: "cinema_room",
                      reference_value: c_room_s.id);
                  // need to get all chair, equality = cinema_room, cinema_movie, schedule
                  // or get all ticket where cinema_moviie, schedule, cinema_chair
                  var ticketSnapshot = await FirebaseFirestore.instance
                      .collection("ticket")
                      .where("cinema_movie",
                          isEqualTo: e.value[index].cinema_movie)
                      .where("schedule",
                          isEqualTo: FirebaseFirestore.instance
                              .doc("schedule/" + e.value[index].id))
                      .get();
                  final tickets_wo_room = ticketSnapshot.docs.map((e) {
                    Map<String, dynamic> data =
                        e.data() as Map<String, dynamic>;
                    return {"id": e.id, ...data};
                  }).toList();

                  // get chairs from wo_room where cinema_room equals
                  List<CinemaChair> finalChair = [];
                  List<Ticket> tickets = [];
                  for (var item in tickets_wo_room) {
                    // get tickets from user_ticket, where ticket equals. if has it -> continue
                    var user_tickets = await FirebaseFirestore.instance
                        .collection("user_ticket")
                        .where("tickets",
                            arrayContains: FirebaseFirestore.instance
                                .doc("ticket/" + item["id"]))
                        .get();
                    //kalo udah ada == continue
                    if (user_tickets.size > 0) {
                      continue;
                    }

                    // get chair, find that cinema room equals
                    var _chair =
                        await (item["cinema_chair"] as DocumentReference).get();
                    var _chairData = _chair.data() as Map<String, dynamic>;
                    _chairData["id"] = _chair.id;
                    if (_chairData["cinema_room"] as DocumentReference ==
                        e.value[index].cinema_room) {
                      finalChair.add(CinemaChair.fromJSON(_chairData));
                      tickets.add(Ticket.fromJSON(item));
                    }
                  }

                  // temporary
                  var res = cc.map((e) => CinemaChair.fromJSON(e)).toList();
                  // print(res.toString());

                  Get.toNamed("/movie_ticket", arguments: {
                    "schedule": e.value[index],
                    "cinema_chair": finalChair,
                    "ticket": tickets,
                  });
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
