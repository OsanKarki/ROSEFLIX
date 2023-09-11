import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app/feature/home/domain/entity/movie.dart';

part 'movie_model.freezed.dart';

part 'movie_model.g.dart';

@freezed
class MovieModel with _$MovieModel {
  const MovieModel._();

  const factory MovieModel({
    required int id,
    @JsonKey(name: "original_title") required String name,
    @JsonKey(name: "overview") required String description,
    @JsonKey(name: "vote_average") required double rating,
    @JsonKey(name: "poster_path")  String? image,
    @JsonKey(name: "release_date") required String releaseDate,
  }) = _MovieModel;

  Movie toDomain() => Movie(
      id: id,
      name: name,
      description: description,
      rating: rating,
      image: image,
      releaseDate: releaseDate);

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}
