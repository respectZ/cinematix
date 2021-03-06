import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:developer';

class ReviewBox extends StatefulWidget {
  ImageProvider<Object>? photoProfile;
  String? name;
  String comment;
  double star;
  DateTime time;

  ReviewBox(
      {Key? key,
      this.photoProfile,
      this.name,
      required this.time,
      required this.comment,
      required this.star})
      : super(key: key);

  @override
  State<ReviewBox> createState() => _ReviewState();
}

class _ReviewState extends State<ReviewBox> {
  ImageProvider<Object> _photoProfile = NetworkImage(
      "https://pbs.twimg.com/profile_images/1509870240506986498/DaM-Seeh_200x200.jpg");
  String _name = "Anonymous";

  @override
  void initState() {
    super.initState();
    _photoProfile = widget.photoProfile ?? _photoProfile;
    _name = widget.name ?? _name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: _photoProfile,
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_name),
                Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.blue,
                  ),
                  child: Text(
                    "${widget.time.day.toString()}/${widget.time.month.toString()}/${widget.time.year.toString()}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        RatingBarIndicator(
          rating: widget.star,
          itemSize: 20.0,
          itemBuilder: ((context, index) => Icon(
                Icons.star,
                color: Colors.blue,
              )),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(widget.comment)
      ],
    );
  }
}
