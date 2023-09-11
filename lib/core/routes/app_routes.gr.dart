// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:movie_app/feature/home/presentation/pages/home_screen.dart'
    as _i1;
import 'package:movie_app/feature/movie_details/presentation/pages/movie_details_page.dart'
    as _i2;
import 'package:movie_app/feature/movie_listing/presentation/pages/movie_listing_pages.dart'
    as _i3;
import 'package:movie_app/feature/series/presentation/pages/series_page.dart'
    as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    MovieDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<MovieDetailsRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.MovieDetailsPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    MovieListingRoute.name: (routeData) {
      final args = routeData.argsAs<MovieListingRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.MovieListingPage(
          key: args.key,
          searchQuery: args.searchQuery,
        ),
      );
    },
    SeriesDisplayRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SeriesDisplayPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MovieDetailsPage]
class MovieDetailsRoute extends _i5.PageRouteInfo<MovieDetailsRouteArgs> {
  MovieDetailsRoute({
    _i6.Key? key,
    required int id,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          MovieDetailsRoute.name,
          args: MovieDetailsRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieDetailsRoute';

  static const _i5.PageInfo<MovieDetailsRouteArgs> page =
      _i5.PageInfo<MovieDetailsRouteArgs>(name);
}

class MovieDetailsRouteArgs {
  const MovieDetailsRouteArgs({
    this.key,
    required this.id,
  });

  final _i6.Key? key;

  final int id;

  @override
  String toString() {
    return 'MovieDetailsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i3.MovieListingPage]
class MovieListingRoute extends _i5.PageRouteInfo<MovieListingRouteArgs> {
  MovieListingRoute({
    _i6.Key? key,
    required String searchQuery,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          MovieListingRoute.name,
          args: MovieListingRouteArgs(
            key: key,
            searchQuery: searchQuery,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieListingRoute';

  static const _i5.PageInfo<MovieListingRouteArgs> page =
      _i5.PageInfo<MovieListingRouteArgs>(name);
}

class MovieListingRouteArgs {
  const MovieListingRouteArgs({
    this.key,
    required this.searchQuery,
  });

  final _i6.Key? key;

  final String searchQuery;

  @override
  String toString() {
    return 'MovieListingRouteArgs{key: $key, searchQuery: $searchQuery}';
  }
}

/// generated route for
/// [_i4.SeriesDisplayPage]
class SeriesDisplayRoute extends _i5.PageRouteInfo<void> {
  const SeriesDisplayRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SeriesDisplayRoute.name,
          initialChildren: children,
        );

  static const String name = 'SeriesDisplayRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
