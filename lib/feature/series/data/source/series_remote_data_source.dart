import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/feature/series/data/model/series_model.dart';

import '../../../../core/errors/exceptions.dart';

abstract class SeriesRemoteDataSource {
  Future<List<SeriesModel>> getSeries();

  Future<List<SeriesModel>> getOnAirSeries();

  Future<List<SeriesModel>> getTopRatedSeries();
}

@LazySingleton(as: SeriesRemoteDataSource)
class SeriesRemoteDataSourceImpl implements SeriesRemoteDataSource {
  SeriesRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<List<SeriesModel>> getSeries() async {
    try {
      final response = await dio.get(
          "https://api.themoviedb.org/3/tv/airing_today",
          queryParameters: {"api_key": "fe9e3f2f0ca3c0f390349e9b5fae1625"});

      final results = response.data["results"];

      final seriesModelList =
          results.map<SeriesModel>((e) => SeriesModel.fromJson(e)).toList();

      return seriesModelList;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<List<SeriesModel>> getOnAirSeries() async {
    try {
      final response = await dio.get(
          "https://api.themoviedb.org/3/tv/on_the_air",
          queryParameters: {"api_key": "fe9e3f2f0ca3c0f390349e9b5fae1625"});

      final results = response.data["results"];

      final onAirSeriesModelList =
          results.map<SeriesModel>((e) => SeriesModel.fromJson(e)).toList();

      return onAirSeriesModelList;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<List<SeriesModel>> getTopRatedSeries() async {
    try {
      final response = await dio.get(
          "https://api.themoviedb.org/3/tv/top_rated",
          queryParameters: {"api_key": "fe9e3f2f0ca3c0f390349e9b5fae1625"});

      final results = response.data["results"];

      final topRatedSeriesModelList =
          results.map<SeriesModel>((e) => SeriesModel.fromJson(e)).toList();

      return topRatedSeriesModelList;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
