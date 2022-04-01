import 'dart:ffi';

class Voucher {
  final int __id;
  final int __movieId; 
  final Float __discountPercent;
  final int __discountFixed; 

  Voucher (
    {required int id,
    required int movieId,
    required Float discountPercent,
    required int discountFixed})
    : __id = id,
    __movieId = movieId,
    __discountPercent = discountPercent,
    __discountFixed = discountFixed;

  factory Voucher.fromJSON(Map<String, dynamic> json) => Voucher(
    id:  json['id'] as int,
    movieId: json['movie_id'] as int,
    discountPercent: json['discount_percent'] as Float,
    discountFixed: json['discount_fixed'] as int);

  int getId() => __id;
  int getMovieId() => __movieId;
  Float getDiscountPercent() => __discountPercent;
  int getDiscountFixed() => __discountFixed;
  
}