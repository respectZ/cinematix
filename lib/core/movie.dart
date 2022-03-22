class Movie {
  final String __title;
  final String __image;
  final String __pv;
  final String __description;
  final double __rating;

  Movie(
      {required String title,
      required String image,
      String? pv,
      String? description,
      double? rating})
      : __title = title,
        __image = image,
        __pv = pv!,
        __description = description!,
        __rating = rating!;

  factory Movie.fromJSON(Map<String, dynamic> json) => Movie(
      title: json['title'] as String,
      image: json['title'] as String,
      pv: json['pv'] as String,
      description: json['description'] as String,
      rating: json['rating'] as double);

  String getTitle() => __title;
  String getImage() => __image;
  String getPV() => __pv;
  String getDescription() => __description;
  double getRating() => __rating;
}
