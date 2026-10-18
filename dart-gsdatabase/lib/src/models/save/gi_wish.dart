import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gi_wish.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GiWish({
  @override final String id = '',
  final int number = 0,
  final String itemId = '',
  final String bannerId = '',
  @JsonKey(fromJson: modelDateFromJson, toJson: modelDateToJson)
  required final DateTime date,
}) extends GsModel<GiWish> {
  static const kTableKey = 'wishes';

  factory GiWish.fromJson(JsonMap json) => _$GiWishFromJson(json);

  @override
  JsonMap toJson() => _$GiWishToJson(this);

  @override
  Iterable<Comparable Function(GiWish a)> get sorters => [
    (a) => a.date,
    (a) => a.number,
    (a) => a.bannerId,
    (a) => a.bannerDate,
  ];
}

extension GiWishExt on GiWish {
  DateTime get bannerDate {
    final e = bannerId.split('_').toList();
    final date = '${e[e.length - 3]}-${e[e.length - 2]}-${e[e.length - 1]}';
    return DateTime.parse(date);
  }
}
