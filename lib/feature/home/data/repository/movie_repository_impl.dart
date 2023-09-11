import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/errors/exceptions.dart';
import 'package:movie_app/core/errors/failures.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/feature/home/data/source/movie_remote_data_source.dart';
import 'package:movie_app/feature/home/domain/entity/movie.dart';
import 'package:movie_app/feature/home/domain/repository/movie_repository.dart';
import 'package:movie_app/feature/movie_details/domain/entity/movie_details.dart';

@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  final MovieRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failures, List<Movie>>> getMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final movieModelList = await remoteDataSource.getMovies();

        final movieList =
            movieModelList.map((movieModel) => movieModel.toDomain()).toList();
        return right(movieList);
      } on ApiException catch (e) {
        return left(Failures.api(message: e.message));
      }
    } else {
      return left(const Failures.noInternetConnection());
    }
  }

  @override
  Future<Either<Failures, List<Movie>>> getUpcomingMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final movieModelList = await remoteDataSource.getUpcomingMovies();

        final movieList =
            movieModelList.map((movieModel) => movieModel.toDomain()).toList();
        return right(movieList);
      } on ApiException catch (e) {
        return left(Failures.api(message: e.message));
      }
    } else {
      return left(const Failures.noInternetConnection());
    }
  }

  @override
  Future<Either<Failures, MovieDetails>> getMoviesDetails(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final movieModelDetails = await remoteDataSource.getMoviesDetails(id);

        final movieDetails = movieModelDetails.toDomain();
        return right(movieDetails);
      } on ApiException catch (e) {
        return left(Failures.api(message: e.message));
      }
    } else {
      return left(const Failures.noInternetConnection());
    }
  }

  @override
  Future<Either<Failures, List<Movie>>> getTopRatedMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final topRatedMovieModelList =
            await remoteDataSource.getTopRatedMovies();

        final topRatedMovieList = topRatedMovieModelList
            .map((movieModel) => movieModel.toDomain())
            .toList();
        return right(topRatedMovieList);
      } on ApiException catch (e) {
        return left(Failures.api(message: e.message));
      }
    } else {
      return left(const Failures.noInternetConnection());
    }
  }

  @override
  Future<Either<Failures, List<Movie>>> getRecomendedMovies(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final recomendedMovieModelList =
            await remoteDataSource.getRecomendedMovies(id);

        final recomendedMovieList = recomendedMovieModelList
            .map((movieModel) => movieModel.toDomain())
            .toList();
        return right(recomendedMovieList);
      } on ApiException catch (e) {
        return left(Failures.api(message: e.message));
      }
    } else {
      return left(const Failures.noInternetConnection());
    }
  }

  @override
  Future<Either<Failures, List<Movie>>> getSearchMovies(
      String searchQuery) async {
    if (await networkInfo.isConnected) {
      try {
        final searchMovieModelList =
            await remoteDataSource.getSearchMovies(searchQuery);

        final searchMovieList = searchMovieModelList
            .map((movieModel) => movieModel.toDomain())
            .toList();
        return right(searchMovieList);
      } on ApiException catch (e) {
        return left(Failures.api(message: e.message));
      }
    } else {
      return left(const Failures.noInternetConnection());
    }
  }
}
