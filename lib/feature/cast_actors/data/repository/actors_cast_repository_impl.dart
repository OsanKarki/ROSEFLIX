import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/errors/failures.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/feature/cast_actors/domain/entity/actors_cast.dart';
import 'package:movie_app/feature/cast_actors/domain/repository/actor_cast_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../source/actors_casting_remote_data_source.dart';


@LazySingleton(as: ActorsCastRepository)
class ActorsCastRepositoryImpl implements ActorsCastRepository {
  ActorsCastRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});

  final ActorsCastRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failures, List<ActorsCast>>> getCastingActors(int id) async{

      if (await networkInfo.isConnected) {
        try {
          final movieActorsList = await remoteDataSource.getCastingActors(id);

          final castActors =
          movieActorsList.map((actorsCast) => actorsCast.toDomain()).toList();
          return right(castActors);
        } on ApiException catch (e) {
          return left(Failures.api(message: e.message));
        }
      } else {
        return left(const Failures.noInternetConnection());
      }
    }


  }

