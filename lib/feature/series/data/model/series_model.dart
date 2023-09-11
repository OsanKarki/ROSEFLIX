import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app/feature/series/domain/entity/series.dart';

part 'series_model.freezed.dart';

part 'series_model.g.dart';

@freezed
class SeriesModel with _$SeriesModel {
  const SeriesModel._();

  const factory SeriesModel({
    required int id,
    required String name,
    @JsonKey(name: "overview") required String description,
    @JsonKey(name: "poster_path") required String image,
    @JsonKey(name: "vote_average") required double rating,
  }) = _SeriesModel;

  Series toDomain() => Series(
        id: id,
        name: name,
        description: description,
        image: image,
        rating: rating,
      );

  factory SeriesModel.fromJson(Map<String, dynamic> json) =>
      _$SeriesModelFromJson(json);
}
