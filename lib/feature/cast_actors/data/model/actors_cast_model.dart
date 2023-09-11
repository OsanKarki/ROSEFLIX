import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app/feature/cast_actors/domain/entity/actors_cast.dart';

part 'actors_cast_model.freezed.dart';

part 'actors_cast_model.g.dart';


@freezed
class ActorsCastModel with _$ActorsCastModel {
 const ActorsCastModel._();

  const factory ActorsCastModel({
    required int id,
    required String name,
    @JsonKey(name: "profile_path")   String? image,
    @JsonKey(name: "known_for_department") required String department,
  }) = _ActorsCastModel;

  ActorsCast toDomain() => ActorsCast(
        id: id,
        name: name,
        image: image,
        department: department,
      );

  factory ActorsCastModel.fromJson(Map<String, dynamic> json) =>
      _$ActorsCastModelFromJson(json);
}
