import 'package:cinematix/model/fire_auth.dart';
import 'package:cinematix/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FavoriteFilm extends StatefulWidget {
  String movie_id;

  FavoriteFilm({Key? key, required this.movie_id}) : super(key: key);

  @override
  State<FavoriteFilm> createState() => _FavoriteFilmState();
}

class _FavoriteFilmState extends State<FavoriteFilm> {
  late Future<Movie> movie;
  late Future<bool> hasReview;

  @override
  void initState() {
    movie = Movie.fromID(movie_id: widget.movie_id);
    hasReview = FireAuth.hasReview(movie_id: widget.movie_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movie,
      builder: (context, AsyncSnapshot<Movie?> snapshot) {
        if (snapshot.hasData) {
          Movie _movie = snapshot.data!;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                height: 150,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(_movie.getImage()),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Text(_movie.getTitle()),
                  Row(
                    children: [
                      Text("AVG Rating: "),
                      _movie.getTotalRating() != null
                          ? RatingBarIndicator(
                              rating: _movie.getTotalRating() ?? 0,
                              itemSize: 20.0,
                              itemBuilder: ((context, index) => Icon(
                                    Icons.star,
                                    color: Colors.blue,
                                  )),
                            )
                          : Text("Tidak tersedia"),
                    ],
                  ),
                  FutureBuilder(
                      future: hasReview,
                      builder: (context, AsyncSnapshot<bool> snapshotR) {
                        if (snapshotR.hasData) {
                          return Text(snapshotR.data!
                              ? "Kamu sudah memberikan review"
                              : "Kamu belum memberikan review");
                        }
                        return Text("loading");
                      }),
                ],
              )
            ],
          );
        } else {
          return Text("");
        }
      },
    );
    // return Container(
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       FutureBuilder(
    //         future: movie,
    //         builder: (context, AsyncSnapshot<Movie?> snapshot) {
    //           if (snapshot.hasData) {
    //             return Container(
    //               margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
    //               height: 150,
    //               width: 100,
    //               decoration: BoxDecoration(
    //                 image: DecorationImage(
    //                   fit: BoxFit.cover,
    //                   image: NetworkImage(snapshot.data!.getImage()),
    //                 ),
    //                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
    //               ),
    //             );
    //           } else {
    //             return Text("");
    //           }
    //         },
    //       ),
    //       Text("hi"),
    //     ],
    //   ),
    // );
    // Container(
    //               height: 200,
    //               width: screenWidth,
    //               decoration: BoxDecoration(
    //                 color: Colors.grey,
    //                 image: DecorationImage(
    //                   colorFilter: ColorFilter.mode(
    //                       Color.fromARGB(255, 255, 255, 255), BlendMode.darken),
    //                   fit: BoxFit.fitHeight,
    //                   image: NetworkImage(
    //                       "https://cdn.myanimelist.net/s/common/uploaded_files/1635784561-2e7ef92151ba666376667b57500afbf9.jpeg"),
    //                 ),
    //                 borderRadius: BorderRadius.only(
    //                   bottomLeft: Radius.circular(10.0),
    //                   bottomRight: Radius.circular(10.0),
    //                 ),
    //               ),
    //             ),
  }
}
