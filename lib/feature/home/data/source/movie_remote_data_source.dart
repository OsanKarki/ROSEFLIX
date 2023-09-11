import 'package:injectable/injectable.dart';
import 'package:movie_app/core/errors/exceptions.dart';
import 'package:movie_app/feature/home/data/model/movie_model.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/feature/movie_details/data/model/movie_details_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getMovies();

  Future<List<MovieModel>> getUpcomingMovies();

  Future<List<MovieModel>> getTopRatedMovies();

  Future<List<MovieModel>> getSearchMovies(String movieName);

  Future<MovieDetailsModel> getMoviesDetails(int id);

  Future<List<MovieModel>> getRecomendedMovies(int id);
}

@LazySingleton(as: MovieRemoteDataSource)
class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  MovieRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<List<MovieModel>> getMovies() async {
    try {
      final response = await dio.get(
          "https://api.themoviedb.org/3/movie/now_playing",
          queryParameters: {"api_key": "fe9e3f2f0ca3c0f390349e9b5fae1625"});

      final results = response.data["results"];

      final movieModelList =
          results.map<MovieModel>((e) => MovieModel.fromJson(e)).toList();

      return movieModelList;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies() async {
    try {
      final response = await dio.get(
          "https://api.themoviedb.org/3/movie/upcoming",
          queryParameters: {"api_key": "fe9e3f2f0ca3c0f390349e9b5fae1625"});

      final results = response.data["results"];

      final movieModelList =
          results.map<MovieModel>((e) => MovieModel.fromJson(e)).toList();

      return movieModelList;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      final response = await dio.get(
          "https://api.themoviedb.org/3/movie/top_rated",
          queryParameters: {"api_key": "fe9e3f2f0ca3c0f390349e9b5fae1625"});

      final results = response.data["results"];

      final movieModelList =
          results.map<MovieModel>((e) => MovieModel.fromJson(e)).toList();

      return movieModelList;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<MovieDetailsModel> getMoviesDetails(int id) async {
    try {
      final response = await dio.get("https://api.themoviedb.org/3/movie/$id",
          queryParameters: {"api_key": "fe9e3f2f0ca3c0f390349e9b5fae1625"});

      final result = response.data;

      final movieModelDetails = MovieDetailsModel.fromJson(result);

      return movieModelDetails;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<List<MovieModel>> getRecomendedMovies(int id) async {
    try {
      final response = await dio.get(
          "https://api.themoviedb.org/3/movie/$id/recommendations",
          queryParameters: {"api_key": "fe9e3f2f0ca3c0f390349e9b5fae1625"});

      final result = response.data["results"];

      final movieModelDetails =
          result.map<MovieModel>((e) => MovieModel.fromJson(e)).toList();

      return movieModelDetails;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<List<MovieModel>> getSearchMovies(String searchQuery) async {
    try {
      final response = await dio.get(
        "https://api.themoviedb.org/3/search/movie?api_key=fe9e3f2f0ca3c0f390349e9b5fae1625&query=$searchQuery",
      );

      final result = response.data["results"];
      print(result);

      final movieModelDetails =
          result.map<MovieModel>((e) => MovieModel.fromJson(e)).toList();

      return movieModelDetails;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
