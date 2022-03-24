class Ticket {
  final int __id;
  final int __cinemaChairId; 
  final int __price;
 
  Ticket (
    {required int id,
    required int cinemaChairId,
    required int price})
    :__id = id,
    __cinemaChairId = cinemaChairId,
    __price = price;

  factory Ticket.fromJSON(Map<String, dynamic> json) => Ticket(
    id: json['id'] as int,
    cinemaChairId: json['cinema_chair_id'] as int,
    price: json['price'] as int);

  int getId() => __id;
  int getCinemaChairId() => __cinemaChairId;
  int getPrice() => __price;
  
}