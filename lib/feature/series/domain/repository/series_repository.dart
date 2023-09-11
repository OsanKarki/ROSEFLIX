import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/failures.dart';
import 'package:movie_app/feature/series/domain/entity/series.dart';

abstract class SeriesRepository{
  Future<Either<Failures,List<Series>>> getSeries();
  Future<Either<Failures,List<Series>>> getOnAirSeries();
  Future<Either<Failures,List<Series>>> getTopRatedSeries();
}