import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_details.freezed.dart';

@freezed
class MovieDetails with _$MovieDetails {
  const factory MovieDetails({
    required int id,
    required String title,
    required String description,
    required String image,
    required double rating,
    required int movieTime,
    required String releasedStatus,
    required String movieTag,
    required bool adultMovie,
    required List<Genre> genres,
  }) = _MovieDetails;
}

@freezed
class Genre with _$Genre {
  const factory Genre({
    required int id,
    required String name

}) = _Genre;

}