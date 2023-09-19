import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:movie_app/core/routes/app_routes.gr.dart';
import 'package:movie_app/feature/home/domain/entity/movie.dart';
import 'package:movie_app/feature/home/presentation/providers/movie_provider.dart';
import 'package:movie_app/injection.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/notifier/app_state.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String searchQuery = "";
    return StateNotifierProvider<MovieProvider, AppState>(
      create: (BuildContext context) => getIt<MovieProvider>()..getMovies(),
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.black,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ROSEFLIX',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: Colors.red)),
                    Text('The Entertainment place',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontStyle: FontStyle.italic, color: Colors.red)),
                    Text('Place to release the stress',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontStyle: FontStyle.italic, color: Colors.grey)),
                  ],
                ),
              ),
              ListTile(
                title: Text('Movies',
                    style: Theme.of(context).textTheme.titleLarge),
                onTap: () {
                  // Add your logic for handling Movies here
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: Text('Series',
                    style: Theme.of(context).textTheme.titleLarge),
                onTap: () {
                  // Add your logic for handling Series here
                  context.router
                      .push(const SeriesDisplayRoute()); // Close the drawer
                },
              ),
              // Add more ListTile items for other sub-items as needed
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            SizedBox(
              width: 100,
              child: SwitchListTile(
                value:
                    AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light,
                onChanged: (value) {
                  AdaptiveTheme.of(context).toggleThemeMode();
                },
              ),
            )
          ],
          title: Text("ROSEFLIX",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieSearchBarSection(
                  string: searchQuery,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Now Releases",
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
                const MovieListBuilder(),
                const UpcomingMovieList(),
                const SizedBox(
                  height: 10,
                ),
                const TopRatedMoviesList()
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class MovieSearchBarSection extends StatelessWidget {
  final String string;
  final TextEditingController searchController = TextEditingController();

  MovieSearchBarSection({
    super.key,
    required this.string,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    String searchQuery = "";
    final state = context.watch<AppState>();
    return state.map(
      initial: (_) => const SizedBox.shrink(),
      loading: (_) => const Center(child: CircularProgressIndicator()),
      success: (value) {
        final List<Movie> searchMovies = value.data;
        return Container(
            height: 58,
            child: FloatingSearchBar(
              hint: 'Search...',
              scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
              transitionDuration: const Duration(milliseconds: 800),
              transitionCurve: Curves.easeInOut,
              physics: const BouncingScrollPhysics(),
              openAxisAlignment: 0.0,
              // controller: textEditingController,
              debounceDelay: const Duration(milliseconds: 500),
              onSubmitted: (query) {
                context.router.push(MovieListingRoute(searchQuery: query));
              },

              // Specify a custom transition to be used for
              // animating between opened and closed stated.
              transition: CircularFloatingSearchBarTransition(),
              actions: [
                FloatingSearchBarAction(
                  showIfOpened: false,
                  child: CircularButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
                FloatingSearchBarAction.searchToClear(
                  showIfClosed: false,
                ),
              ],
              builder: (context, transition) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                );
              },
            ));
      },
      failure: (value) => Text(value.failure.maybeMap(
        orElse: () => "",
        noInternetConnection: (value) => "No Internet Connection",
        api: (value) => value.message,
      )),
    );
  }
}

class UpcomingMovieList extends StatelessWidget {
  const UpcomingMovieList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<MovieProvider, AppState>(
      create: (BuildContext context) =>
          getIt<MovieProvider>()..getUpcomingMovies(),
      builder: (context, child) {
        final state = context.watch<AppState>();
        return state.map(
          initial: (_) => const SizedBox.shrink(),
          loading: (_) => const Center(child: CircularProgressIndicator()),
          success: (value) {
            final List<Movie> upcomingMovieList = value.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upcoming Movies:",
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
                  height: 210,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: upcomingMovieList.length,
                    itemBuilder: (context, index) {
                      final movie = upcomingMovieList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            context.router
                                .push(MovieDetailsRoute(id: movie.id));
                          },
                          child: SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 170, // Adjust the height as needed
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500/${movie.image}',
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      movie.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Released on: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      Text(
                                        movie.releaseDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  )
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

class TopRatedMoviesList extends StatelessWidget {
  const TopRatedMoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<MovieProvider, AppState>(
      create: (BuildContext context) =>
          getIt<MovieProvider>()..getTopRatedMovies(),
      builder: (context, child) {
        final state = context.watch<AppState>();
        return state.map(
          initial: (_) => const SizedBox.shrink(),
          loading: (_) => const Center(child: CircularProgressIndicator()),
          success: (value) {
            final List<Movie> topRatedMovies = value.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top-rated Movies:",
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
                    itemCount: topRatedMovies.length,
                    itemBuilder: (context, index) {
                      final movie = topRatedMovies[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            context.router
                                .push(MovieDetailsRoute(id: movie.id));
                          },
                          child: SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    'https://image.tmdb.org/t/p/w500/${movie.image}',
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
                                          movie.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
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
                                            movie.rating.toString(),
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

class MovieListBuilder extends StatelessWidget {
  const MovieListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return SizedBox(
      height: 350,
      child: state.map(
        initial: (_) => const SizedBox.shrink(),
        loading: (_) => const Center(child: CircularProgressIndicator()),
        success: (value) {
          final List<Movie> movieList = value.data;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movieList.length,
            itemBuilder: (context, index) {
              final movie = movieList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () {
                    context.router.push(MovieDetailsRoute(id: movie.id));
                  },
                  child: SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            'https://image.tmdb.org/t/p/w500/${movie.image}',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  movie.name,
                                  style: Theme.of(context).textTheme.bodyMedium,
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
                                    movie.rating.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(color: Colors.yellowAccent),
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
          );
        },
        failure: (value) => Text(value.failure.maybeMap(
          orElse: () => "",
          noInternetConnection: (value) => "No Internet Connection",
          api: (value) => value.message,
        )),
      ),
    );
  }
}
