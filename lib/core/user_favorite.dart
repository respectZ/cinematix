class UserFavorite {
  final String __userEmail;
  final int __movieId; 
 
  UserFavorite (
    {String? userEmail,
    int? movieId})
    :__userEmail = userEmail!,
    __movieId = movieId!;

  factory UserFavorite.fromJSON(Map<String, dynamic> json) => UserFavorite(
    userEmail: json['user_email'] as String,
    movieId: json['movie_id'] as int);

  String getUserEmail() => __userEmail;
  int getMovieId() => __movieId;
  
}