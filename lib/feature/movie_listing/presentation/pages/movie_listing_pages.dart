import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:movie_app/core/routes/app_routes.gr.dart';
import 'package:provider/provider.dart';

import '../../../../injection.dart';
import '../../../home/domain/entity/movie.dart';
import '../../../home/presentation/providers/movie_provider.dart';
import '../../../shared/presentation/notifier/app_state.dart';

@RoutePage()
class MovieListingPage extends StatelessWidget {
  final String searchQuery;

  const MovieListingPage({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<MovieProvider, AppState>(
      create: (BuildContext context) =>
          getIt<MovieProvider>()..getSearchMovies(searchQuery),
      builder: (context, child) {
        final state = context.watch<AppState>();
        return state.map(
          initial: (_) => const SizedBox.shrink(),
          loading: (_) => const Center(child: CircularProgressIndicator()),
          success: (value) {
            final List<Movie> searchMovies = value.data;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            context.router.pop();
                          },
                          child: const Icon(Icons.arrow_back_ios)),
                    ],
                  ),
                ),
                Expanded(
                  child: MasonryGridView.builder(
                      itemCount: searchMovies.length,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  context.router
                                      .push(MovieDetailsRoute(id: searchMovies[index].id));
                                },
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500/${searchMovies[index].image}',
                                  // height: 150,
                                ),
                              ),
                            ),
                          )),
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
