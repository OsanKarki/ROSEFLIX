import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/failures.dart';

import '../../../movie_details/domain/entity/movie_details.dart';
import '../entity/movie.dart';

abstract class MovieRepository {
  Future<Either<Failures, List<Movie>>> getMovies();

  Future<Either<Failures, MovieDetails>> getMoviesDetails(int id);

  Future<Either<Failures, List<Movie>>> getUpcomingMovies();

  Future<Either<Failures, List<Movie>>> getTopRatedMovies();

  Future<Either<Failures, List<Movie>>> getRecomendedMovies(int id);

  Future<Either<Failures, List<Movie>>> getSearchMovies(String searchQuery);
}
