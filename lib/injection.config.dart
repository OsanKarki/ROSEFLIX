// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i4;

import 'core/di/injectable_module.dart' as _i19;
import 'core/network/network_info.dart' as _i6;
import 'feature/cast_actors/data/repository/actors_cast_repository_impl.dart'
    as _i12;
import 'feature/cast_actors/data/source/actors_casting_remote_data_source.dart'
    as _i10;
import 'feature/cast_actors/domain/repository/actor_cast_repository.dart'
    as _i11;
import 'feature/cast_actors/presentation/provider/actors_cast_provider.dart'
    as _i16;
import 'feature/home/data/repository/movie_repository_impl.dart' as _i14;
import 'feature/home/data/source/movie_remote_data_source.dart' as _i5;
import 'feature/home/domain/repository/movie_repository.dart' as _i13;
import 'feature/home/presentation/providers/movie_provider.dart' as _i18;
import 'feature/movie_details/presentation/provider/movie_details_provider.dart'
    as _i17;
import 'feature/series/data/repository/series_repository_impl.dart' as _i9;
import 'feature/series/data/source/series_remote_data_source.dart' as _i7;
import 'feature/series/domain/repository/series_repository.dart' as _i8;
import 'feature/series/presentation/provider/series_provider.dart' as _i15;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.Dio>(() => registerModule.dio);
    gh.factory<_i4.InternetConnectionChecker>(
        () => registerModule.internetConnectionChecker);
    gh.lazySingleton<_i5.MovieRemoteDataSource>(
        () => _i5.MovieRemoteDataSourceImpl(gh<_i3.Dio>()));
    gh.lazySingleton<_i6.NetworkInfo>(
        () => _i6.NetworkInfoImpl(gh<_i4.InternetConnectionChecker>()));
    gh.lazySingleton<_i7.SeriesRemoteDataSource>(
        () => _i7.SeriesRemoteDataSourceImpl(gh<_i3.Dio>()));
    gh.lazySingleton<_i8.SeriesRepository>(() => _i9.SeriesRepositoryImpl(
          remoteDataSource: gh<_i7.SeriesRemoteDataSource>(),
          networkInfo: gh<_i6.NetworkInfo>(),
        ));
    gh.lazySingleton<_i10.ActorsCastRemoteDataSource>(
        () => _i10.ActorsCastRemoteDataSourceImpl(gh<_i3.Dio>()));
    gh.lazySingleton<_i11.ActorsCastRepository>(
        () => _i12.ActorsCastRepositoryImpl(
              networkInfo: gh<_i6.NetworkInfo>(),
              remoteDataSource: gh<_i10.ActorsCastRemoteDataSource>(),
            ));
    gh.lazySingleton<_i13.MovieRepository>(() => _i14.MovieRepositoryImpl(
          remoteDataSource: gh<_i5.MovieRemoteDataSource>(),
          networkInfo: gh<_i6.NetworkInfo>(),
        ));
    gh.factory<_i15.SeriesProvider>(
        () => _i15.SeriesProvider(gh<_i8.SeriesRepository>()));
    gh.factory<_i16.ActorsCastProvider>(
        () => _i16.ActorsCastProvider(gh<_i11.ActorsCastRepository>()));
    gh.factory<_i17.MovieDetailsProvider>(
        () => _i17.MovieDetailsProvider(gh<_i13.MovieRepository>()));
    gh.factory<_i18.MovieProvider>(
        () => _i18.MovieProvider(gh<_i13.MovieRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i19.RegisterModule {}
