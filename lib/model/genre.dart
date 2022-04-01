class Genre {
  final int __id;
  final String __name; 
 
  Genre (
    {required int id,
    required String name})
    :__id = id,
    __name = name;

  factory Genre.fromJSON(Map<String, dynamic> json) => Genre(
    id: json['id'] as int,
    name: json['name'] as String);

  int getId() => __id;
  String getName() => __name;
  
}