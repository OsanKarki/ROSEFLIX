import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/feature/cast_actors/data/model/actors_cast_model.dart';

import '../../../../core/errors/exceptions.dart';

abstract class ActorsCastRemoteDataSource {
  Future<List<ActorsCastModel>> getCastingActors(int id);
}

@LazySingleton(as: ActorsCastRemoteDataSource)
class ActorsCastRemoteDataSourceImpl implements ActorsCastRemoteDataSource {
  ActorsCastRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<List<ActorsCastModel>>getCastingActors(int id) async {
    try {
      final response = await dio.get(
          "https://api.themoviedb.org/3/movie/$id/credits",
          queryParameters: {"api_key": "fe9e3f2f0ca3c0f390349e9b5fae1625"});

      final results = response.data["cast"];


      final castingActorsList = results
          .map<ActorsCastModel>((e) => ActorsCastModel.fromJson(e))
          .toList();
      return castingActorsList;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
