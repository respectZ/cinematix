class Review {
  final int __movieId;
  final String __userEmail;
  final double __starRating;
  final String __comment;

  Review(
      {required int movieId,
      required String userEmail,
      required double starRating,
      String? comment})
      : __movieId = movieId,
        __userEmail = userEmail,
        __starRating = starRating,
        __comment = comment!;

  factory Review.fromJSON(Map<String, dynamic> json) => Review(
      movieId: json['movie_id'] as int,
      userEmail: json['user_email'] as String,
      starRating: json['star_rating'] as double,
      comment: json['comment'] as String);

  int getMovieId() => __movieId;
  String getUserEmail() => __userEmail;
  double getStarRating() => __starRating;
  String getComment() => __comment;
}
