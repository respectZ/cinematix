import 'package:cinematix/model/movie.dart';
import 'package:cinematix/model/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

bool isSameDay(DateTime dateTime1, DateTime dateTime2) {
  return dateTime1.year == dateTime2.year &&
      dateTime1.month == dateTime2.month &&
      dateTime1.day == dateTime2.day;
}

class TicketMovieWidget extends StatefulWidget {
  Ticket ticket;
  DateTime? dateTime;

  TicketMovieWidget({Key? key, required this.ticket, this.dateTime})
      : super(key: key);

  @override
  State<TicketMovieWidget> createState() => _TicketMovieWidgetState();
}

class _TicketMovieWidgetState extends State<TicketMovieWidget> {
  late Future<DocumentSnapshot<Object?>> cinema_movie;
  late Future<DocumentSnapshot<Object?>> schedule;
  late Future<DocumentSnapshot<Object?>> cinema_chair;

  @override
  void initState() {
    // get cinema_movie
    cinema_movie = widget.ticket.cinema_movie.get();
    schedule = widget.ticket.schedule.get();
    cinema_chair = widget.ticket.cinema_chair.get();
    // get id

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: schedule,
        builder:
            (context, AsyncSnapshot<DocumentSnapshot<Object?>> snapshotRoot1) {
          if (snapshotRoot1.hasData) {
            var _temp = snapshotRoot1.data!.data()! as Map<String, dynamic>;
            DateTime _dateRoot = (_temp["airing"] as Timestamp).toDate();
            if (widget.dateTime == null ||
                isSameDay(widget.dateTime!, _dateRoot)) {
              return FutureBuilder(
                future: cinema_movie,
                builder: (context,
                    AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!.data() as Map<String, dynamic>;
                    //get movie
                    Future<Movie> _movie = Movie.fromID(
                        movie_id: (data["movie"] as DocumentReference).id);
                    //get cinema
                    Future<DocumentSnapshot<Object?>> cinema =
                        (data["cinema"] as DocumentReference).get();

                    return FutureBuilder(
                        future: _movie,
                        builder: (context, AsyncSnapshot<Movie> snapshot2) {
                          if (snapshot2.hasData) {
                            // movie
                            Movie __movie = snapshot2.data!;
                            // movie cover
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // cover
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                                  height: 150,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(__movie.getImage()),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                ),
                                // details etc
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // datetime
                                    FutureBuilder(
                                      future: schedule,
                                      builder: (context,
                                          AsyncSnapshot<
                                                  DocumentSnapshot<Object?>>
                                              snapshotSchedule) {
                                        if (snapshotSchedule.hasData) {
                                          var _temp = snapshotSchedule.data!
                                              .data()! as Map<String, dynamic>;
                                          DateTime _date =
                                              (_temp["airing"] as Timestamp)
                                                  .toDate();
                                          return Row(
                                            children: [
                                              // date
                                              Container(
                                                width: 128,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                6.0))),
                                                child: Center(
                                                  child: Text(
                                                    _date
                                                        .toString()
                                                        .split(" ")[0],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              // time
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Text(_date.hour
                                                      .toString()
                                                      .padLeft(2, '0') +
                                                  ":" +
                                                  _date.minute
                                                      .toString()
                                                      .padLeft(2, '0')),
                                            ],
                                          );
                                        } else {
                                          return Text("loading");
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    // nama cinema
                                    FutureBuilder(
                                      future: cinema,
                                      builder: (context,
                                          AsyncSnapshot<
                                                  DocumentSnapshot<Object?>>
                                              snapshotCinema) {
                                        if (snapshotCinema.hasData) {
                                          var _temp = snapshotCinema.data!
                                              .data()! as Map<String, dynamic>;
                                          return Text(_temp["name"]);
                                        } else {
                                          return Text("loading");
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    // nama ruangan
                                    FutureBuilder(
                                      future: cinema_chair,
                                      builder: (context,
                                          AsyncSnapshot<
                                                  DocumentSnapshot<Object?>>
                                              snapshotCinema) {
                                        if (snapshotCinema.hasData) {
                                          var _temp = snapshotCinema.data!
                                              .data()! as Map<String, dynamic>;
                                          Future<DocumentSnapshot<Object?>>
                                              cinema_room =
                                              (_temp["cinema_room"]
                                                      as DocumentReference)
                                                  .get();
                                          return FutureBuilder(
                                            future: cinema_room,
                                            builder: (context,
                                                AsyncSnapshot<
                                                        DocumentSnapshot<
                                                            Object?>>
                                                    snapshotCinemaRoom) {
                                              if (snapshotCinemaRoom.hasData) {
                                                var __temp = snapshotCinemaRoom
                                                        .data!
                                                        .data()!
                                                    as Map<String, dynamic>;
                                                return Text(__temp["name"]);
                                              } else {
                                                return Text("loading");
                                              }
                                            },
                                          );
                                        } else {
                                          return Text("loading");
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    // nama kursi
                                    FutureBuilder(
                                      future: cinema_chair,
                                      builder: (context,
                                          AsyncSnapshot<
                                                  DocumentSnapshot<Object?>>
                                              snapshotCinema) {
                                        if (snapshotCinema.hasData) {
                                          var _temp = snapshotCinema.data!
                                              .data()! as Map<String, dynamic>;
                                          return Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[400],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              6.0))),
                                              child: Center(
                                                  child: Text(_temp["code"])));
                                        } else {
                                          return Text("loading");
                                        }
                                      },
                                    )
                                  ],
                                )
                              ],
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            }
            return Container();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
