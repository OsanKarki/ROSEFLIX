import 'package:freezed_annotation/freezed_annotation.dart';

part 'series.freezed.dart';

@freezed
class Series with _$Series {
  const factory Series({
    required int id,
    required String name,
    required String description,
    required String image,
    required double rating,
  }) = _Series;
}
