class CinemaLayout {
  final int __cinemaRoomId;
  final int __cinemaChairId; 
 
  CinemaLayout (
    {int? cinemaRoomId,
    int? cinemaChairId})
    :__cinemaRoomId = cinemaRoomId!,
    __cinemaChairId = cinemaChairId!;

  factory CinemaLayout.fromJSON(Map<String, dynamic> json) => CinemaLayout(
    cinemaRoomId: json['cinema_room_id'] as int,
    cinemaChairId: json['cinema_chair_id'] as int);

  int getCinemaRoomId() => __cinemaRoomId;
  int getCinemaChairId() => __cinemaChairId;
  
}