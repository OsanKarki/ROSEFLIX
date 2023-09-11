import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:movie_app/core/routes/app_routes.gr.dart';
import 'package:movie_app/feature/series/presentation/provider/series_provider.dart';
import 'package:provider/provider.dart';

import '../../../../injection.dart';
import '../../../shared/presentation/notifier/app_state.dart';
import '../../domain/entity/series.dart';

@RoutePage()
class SeriesDisplayPage extends StatelessWidget {
  const SeriesDisplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("ROSEFLIX",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic)),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff000000),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SeriesRecentSection(),
              OnAirSeriesSection(),
              TopRatedSeriesSection(),
            ],
          ),
        ),
      ),
    );
  }
}


class TopRatedSeriesSection extends StatelessWidget {
  const TopRatedSeriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<SeriesProvider, AppState>(
      create: (BuildContext context) =>
      getIt<SeriesProvider>()..getTopRatedSeries(),
      builder: (context, child) {
        final state = context.watch<AppState>();
        return state.map(
          initial: (_) => const SizedBox.shrink(),
          loading: (_) => const Center(child: CircularProgressIndicator()),
          success: (value) {
            final List<Series> seriesList = value.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top-rated Series:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "See all",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: seriesList.length,
                    itemBuilder: (context, index) {
                      final series = seriesList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            // context.router
                            //     .push(MovieDetailsRoute(id: series.id));
                          },
                          child: SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    'https://image.tmdb.org/t/p/w500/${series.image}',
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          series.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Colors.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            series.rating.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                color: Colors.yellowAccent),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          failure: (value) => Text(value.failure.maybeMap(
            orElse: () => "",
            noInternetConnection: (value) => "No Internet Connection",
            api: (value) => value.message,
          )),
        );
      },
    );
  }
}
class OnAirSeriesSection extends StatelessWidget {
  const OnAirSeriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<SeriesProvider, AppState>(
      create: (BuildContext context) =>
          getIt<SeriesProvider>()..getOnAirSeries(),
      builder: (context, child) {
        final state = context.watch<AppState>();
        return state.map(
          initial: (_) => const SizedBox.shrink(),
          loading: (_) => const Center(child: CircularProgressIndicator()),
          success: (value) {
            final List<Series> seriesList = value.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Airing Today:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "See all",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: seriesList.length,
                    itemBuilder: (context, index) {
                      final series = seriesList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            // context.router
                            //     .push(MovieDetailsRoute(id: series.id));
                          },
                          child: SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    'https://image.tmdb.org/t/p/w500/${series.image}',
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          series.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Colors.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            series.rating.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: Colors.yellowAccent),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          failure: (value) => Text(value.failure.maybeMap(
            orElse: () => "",
            noInternetConnection: (value) => "No Internet Connection",
            api: (value) => value.message,
          )),
        );
      },
    );
  }
}

class SeriesRecentSection extends StatelessWidget {
  const SeriesRecentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<SeriesProvider, AppState>(
      create: (BuildContext context) => getIt<SeriesProvider>()..getSeries(),
      builder: (context, child) {
        final state = context.watch<AppState>();
        return state.map(
          initial: (_) => const SizedBox.shrink(),
          loading: (_) => const Center(child: CircularProgressIndicator()),
          success: (value) {
            final List<Series> seriesList = value.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Airing Today:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "See all",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: seriesList.length,
                    itemBuilder: (context, index) {
                      final series = seriesList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            // context.router
                            //     .push(MovieDetailsRoute(id: series.id));
                          },
                          child: SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    'https://image.tmdb.org/t/p/w500/${series.image}',
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          series.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Colors.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            series.rating.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: Colors.yellowAccent),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          failure: (value) => Text(value.failure.maybeMap(
            orElse: () => "",
            noInternetConnection: (value) => "No Internet Connection",
            api: (value) => value.message,
          )),
        );
      },
    );
  }
}
