import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required int id,
    required String name,
    required String description,
    required double rating,
    String? image,
    required String releaseDate,
  }) = _Movie;
}
