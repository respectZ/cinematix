class CinemaRoom {
  final int __id;
  final int __cinemaId; 
  final String __name;
 
  CinemaRoom (
    {required int id,
    required int cinemaId,
    String? name})
    :__id = id,
    __cinemaId = cinemaId,
    __name = name!;

  factory CinemaRoom.fromJSON(Map<String, dynamic> json) => CinemaRoom(
    id: json['id'] as int,
    cinemaId: json['cinema_id'] as int,
    name: json['name'] as String);

  int getId() => __id;
  int getCinemaId() => __cinemaId;
  String getName() => __name;
  
}