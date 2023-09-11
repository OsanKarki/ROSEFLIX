import 'package:auto_route/auto_route.dart';

import 'app_routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: "/"),
        AutoRoute(page: MovieDetailsRoute.page, path: "/movieDetails"),
        AutoRoute(page: SeriesDisplayRoute.page, path: "/seriesView"),
        AutoRoute(page: MovieListingRoute.page, path: "/movieList"),
      ];
}
