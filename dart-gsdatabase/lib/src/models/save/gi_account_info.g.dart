// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_account_info.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GiAccountInfo extends _GiAccountInfo {
  @override
  final String id;
  @override
  final String monThuChar;
  @override
  final String tueFriChar;
  @override
  final String wedSatChar;

  /// Creates a new [GiAccountInfo] instance.
  GiAccountInfo({
    required this.id,
    this.monThuChar = '',
    this.tueFriChar = '',
    this.wedSatChar = '',
  });

  /// Creates a new [GiAccountInfo] instance from the given map.
  GiAccountInfo.fromJson(JsonMap m)
    : id = m['id'] as String? ?? '',
      monThuChar = m['mon_thu_char'] as String? ?? '',
      tueFriChar = m['tue_fri_char'] as String? ?? '',
      wedSatChar = m['wed_sat_char'] as String? ?? '';

  /// Copies this model with the given parameters.
  @override
  GiAccountInfo copyWith({
    String? id,
    String? monThuChar,
    String? tueFriChar,
    String? wedSatChar,
  }) {
    return GiAccountInfo(
      id: id ?? this.id,
      monThuChar: monThuChar ?? this.monThuChar,
      tueFriChar: tueFriChar ?? this.tueFriChar,
      wedSatChar: wedSatChar ?? this.wedSatChar,
    );
  }

  /// Creates a [JsonMap] from this model.
  @override
  JsonMap toMap() {
    return {
      'id': id,
      'mon_thu_char': monThuChar,
      'tue_fri_char': tueFriChar,
      'wed_sat_char': wedSatChar,
    };
  }
}
