class Movie {
  final String __title;
  final String __image;
  final String __pv;
  final String __description;
  final String __rating;
  final int __happiness;
  final int __lenght;
  final Date __start_airing;
  final Date __end_airing;

  Movie(
      {required String title,
      required String image,
      String? pv,
      String? description,
      String? rating, 
      int? happiness,
      int? lenght,
      Date? start_airing,
      Date? end_airing})
      : __title = title,
        __image = image,
        __pv = pv!,
        __description = description!,
        __rating = rating!,
        __happiness = happiness!,
        __lenght = lenght!,
        __start_airing = start_airing!,
        __end_airing = end_airing!;

  factory Movie.fromJSON(Map<String, dynamic> json) => Movie(
      title: json['title'] as String,
      image: json['title'] as String,
      pv: json['pv'] as String,
      description: json['description'] as String,
      rating: json['rating'] as String,
      happiness: json['happiness'] as int,
      lenght: json['length'] as int
      start_airing: json['start_airing'] as Date,
      end_airing: json['end_airing'] as Date);

  String getTitle() => __title;
  String getImage() => __image;
  String getPV() => __pv;
  String getDescription() => __description;
  String getRating() => __rating;
  int getHappiness() => __happiness;
  int getLenght() => __lenght;
  Date getStart_airing() => __start_airing;
  Date getEnd_airing() => __end_airing;
}
