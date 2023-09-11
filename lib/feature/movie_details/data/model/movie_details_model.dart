import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app/feature/movie_details/domain/entity/movie_details.dart';

part 'movie_details_model.freezed.dart';

part 'movie_details_model.g.dart';

@freezed
class MovieDetailsModel with _$MovieDetailsModel {
  const MovieDetailsModel._();

  const factory MovieDetailsModel({
    required int id,
    @JsonKey(name: "original_title") required String title,
    @JsonKey(name: "overview") required String description,
    @JsonKey(name: "poster_path") required String image,
    @JsonKey(name: "vote_average") required double rating,
    @JsonKey(name: "runtime") required int movieTime,
    @JsonKey(name: "status") required String releasedStatus,
    @JsonKey(name: "tagline") required String movieTag,
    @JsonKey(name: "adult") required bool adultMovie,
    required List<GenreModel> genres,
  }) = _MovieDetailsModel;

  MovieDetails toDomain() => MovieDetails(
      id: id,
      title: title,
      description: description,
      image: image,
      rating: rating,
      movieTime: movieTime,
      releasedStatus: releasedStatus,
      movieTag: movieTag,
      adultMovie: adultMovie,
      genres: genres.map((e) => e.toDomain()).toList());

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsModelFromJson(json);
}

@freezed
class GenreModel with _$GenreModel {
  const GenreModel._();

  const factory GenreModel({
    required int id,
    required String name,
  }) = _GenreModel;

  Genre toDomain() => Genre(id: id, name: name);

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);
}
