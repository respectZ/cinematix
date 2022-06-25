import 'package:cinematix/model/fire_auth.dart';
import 'package:cinematix/model/ticket.dart';
import 'package:cinematix/widget/ticket_movie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTicketPage extends StatefulWidget {
  const MyTicketPage({Key? key}) : super(key: key);

  @override
  State<MyTicketPage> createState() => _MyTicketPageState();
}

class _MyTicketPageState extends State<MyTicketPage> {
  Future<List<Ticket>> tickets = FireAuth.getTickets();
  DateTime? _dateTime = DateTime.now();
  bool isFiltered = false;

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
            "Tiket Saya",
            style: TextStyle(color: Colors.blue),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // filter tanggal
              Row(
                children: [
                  SizedBox(
                    width: 12.0,
                  ),
                  Checkbox(
                      value: isFiltered,
                      onChanged: (bool? val) {
                        setState(() {
                          isFiltered = val ?? isFiltered;
                        });
                      }),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text("Filter tanggal"),
                  SizedBox(
                    width: 24.0,
                  ),
                  if (_dateTime != null)
                    InkWell(
                      onTap: () {
                        if (!isFiltered) {
                          showDatePicker(
                                  context: context,
                                  initialDate: _dateTime!,
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2099))
                              .then((value) => setState(() {
                                    _dateTime = value ?? _dateTime;
                                  }));
                        }
                      },
                      child: Container(
                          width: 128,
                          height: 32,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0))),
                          child: Center(
                            child: Text(
                              _dateTime.toString().split(" ")[0],
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    )
                  else
                    Text("no date"),
                ],
              ),
              // list movie
              Column(),
              FutureBuilder(
                future: tickets,
                builder: (BuildContext builder,
                    AsyncSnapshot<List<Ticket>> snapshot) {
                  if (snapshot.hasData) {
                    var _tickets = snapshot.data!;
                    return ListView.builder(
                        itemCount: _tickets.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 12.0),
                            decoration: BoxDecoration(
                              border: index != 0
                                  ? Border(
                                      top: BorderSide(
                                          width: 0.5, color: Colors.black),
                                    )
                                  : null,
                            ),
                            child: TicketMovieWidget(
                              ticket: _tickets[index],
                              dateTime: isFiltered ? _dateTime : null,
                            ),
                          );
                        });
                  } else {
                    return Center(child: Text("Anda belum memiliki tiket"));
                  }
                  return Center(child: Text("Anda belum memiliki tiket"));
                },
              ),
            ],
          ),
        ));
  }
}
