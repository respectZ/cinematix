class Cinema {
  final int __id;
  final String __name;

  Cinema (
    {required int id,
    required String name})
    :__name = name,
    __id = id;

  factory Cinema.fromJSON(Map<String, dynamic> json) => Cinema(
    name: json['name'] as String,
    id: json['id'] as int);

  String getName() => __name;
  int    getId() => __id;

  }