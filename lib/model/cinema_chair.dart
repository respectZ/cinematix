class CinemaChair {
  final String __id;
  final String __code;
  final int __row;
  final int __column;
  int? __bottomMargin;
  int? __rightMargin;

  CinemaChair(
      {required String id,
      required String code,
      int? row,
      int? column,
      int? bottomMargin,
      int? rightMargin})
      : __code = code,
        __id = id,
        __row = row!,
        __column = column!,
        __bottomMargin = bottomMargin,
        __rightMargin = rightMargin;

  factory CinemaChair.fromJSON(Map<String, dynamic> json) => CinemaChair(
      code: json['code'] as String,
      id: json['id'] as String,
      row: json['row'] as int,
      column: json['column'] as int,
      bottomMargin: json['bottom_margin'] as int?,
      rightMargin: json['right_margin'] as int?);

  String getCode() => __code;
  String getId() => __id;
  int getRow() => __row;
  int getColumn() => __column;
  int? getBottomMargin() => __bottomMargin;
  int? getRightMargin() => __rightMargin;
}
