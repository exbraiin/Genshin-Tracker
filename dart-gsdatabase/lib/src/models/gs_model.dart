export 'package:gsdatabase/src/enums/ge_enum.dart';

typedef JsonMap = Map<String, dynamic>;

DateTime modelDateFromJson(dynamic value) =>
    DateTime.tryParse(value.toString()) ?? DateTime(0);

String modelDateToJson(DateTime value) => value.toString();

abstract class GsModel<T extends GsModel<T>> implements Comparable<T> {
  String get id;
  JsonMap toJson();

  @override
  int compareTo(T other) {
    return sorters
        .map((e) => e(this as T).compareTo(e(other)))
        .firstWhere((e) => e != 0, orElse: () => id.compareTo(other.id));
  }

  Iterable<Comparable Function(T a)> get sorters => [];
}

mixin GsVersionable<T extends GsModel<T>> on GsModel<T> {
  String get version;
}
