import 'package:freezed_annotation/freezed_annotation.dart';

part 'actors_cast.freezed.dart';

@freezed
class ActorsCast with _$ActorsCast {
  const factory ActorsCast({
    required int id,
    required String name,
     String? image,
    required String department,
  }) = _ActorsCast;
}
