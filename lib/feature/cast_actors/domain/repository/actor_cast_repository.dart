import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/failures.dart';

import '../entity/actors_cast.dart';

abstract class ActorsCastRepository {
  Future<Either<Failures, List<ActorsCast>>> getCastingActors(int id);
}
