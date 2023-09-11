import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/errors/failures.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/feature/series/domain/entity/series.dart';
import 'package:movie_app/feature/series/domain/repository/series_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../source/series_remote_data_source.dart';

@LazySingleton(as: SeriesRepository)
class SeriesRepositoryImpl implements SeriesRepository {
  SeriesRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  final NetworkInfo networkInfo;
  final SeriesRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failures, List<Series>>> getSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final seriesModelDetails = await remoteDataSource.getSeries();

        final seriesDetails = seriesModelDetails
            .map((seriesModel) => seriesModel.toDomain())
            .toList();
        return right(seriesDetails);
      } on ApiException catch (e) {
        return left(Failures.api(message: e.message));
      }
    } else {
      return left(const Failures.noInternetConnection());
    }
  }

  @override
  Future<Either<Failures, List<Series>>> getOnAirSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final seriesModelDetails = await remoteDataSource.getOnAirSeries();

        final seriesDetails = seriesModelDetails
            .map((seriesModel) => seriesModel.toDomain())
            .toList();
        return right(seriesDetails);
      } on ApiException catch (e) {
        return left(Failures.api(message: e.message));
      }
    } else {
      return left(const Failures.noInternetConnection());
    }
  }

  @override
  Future<Either<Failures, List<Series>>> getTopRatedSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final seriesModelDetails = await remoteDataSource.getTopRatedSeries();

        final topRatedSeriesDetails = seriesModelDetails
            .map((seriesModel) => seriesModel.toDomain())
            .toList();
        return right(topRatedSeriesDetails);
      } on ApiException catch (e) {
        return left(Failures.api(message: e.message));
      }
    } else {
      return left(const Failures.noInternetConnection());
    }
  }
}
