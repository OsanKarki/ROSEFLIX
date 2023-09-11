import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:movie_app/core/routes/app_routes.gr.dart';
import 'package:movie_app/feature/cast_actors/domain/entity/actors_cast.dart';
import 'package:movie_app/feature/cast_actors/presentation/provider/actors_cast_provider.dart';
import 'package:movie_app/feature/home/domain/entity/movie.dart';
import 'package:movie_app/feature/home/presentation/providers/movie_provider.dart';
import 'package:movie_app/feature/movie_details/domain/entity/movie_details.dart';
import 'package:movie_app/feature/movie_details/presentation/provider/movie_details_provider.dart';
import 'package:movie_app/feature/shared/presentation/notifier/app_state.dart';
import 'package:provider/provider.dart';

import '../../../../injection.dart';

@RoutePage()
class MovieDetailsPage extends StatelessWidget {
  final int id;

  const MovieDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<MovieDetailsProvider, AppState>(
      create: (BuildContext context) =>
          getIt<MovieDetailsProvider>()..getMoviesDetails(id),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MovieDetailsSection(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Casts:",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              CastingActorsSection(
                id: id,
              ),
              RecomendedMoviesSection(
                id: id,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RecomendedMoviesSection extends StatelessWidget {
  final int id;

  const RecomendedMoviesSection({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<MovieProvider, AppState>(
      create: (BuildContext context) =>
          getIt<MovieProvider>()..getRecomendedMovies(id),
      builder: (context, child) {
        final state = context.watch<AppState>();
        return state.map(
            initial: (_) => const SizedBox.shrink(),
            loading: (_) => const CircularProgressIndicator(),
            success: (value) {
              final List<Movie> recomendMovie = value.data;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recomended Movies:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Container(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recomendMovie.length,
                        itemBuilder: (context, index) {
                          final movie = recomendMovie[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: GestureDetector(
                                    onTap: () {
                                      context.router.push(
                                          MovieDetailsRoute(id: movie.id));
                                    },
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500/${movie.image}',
                                      height: 100,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    movie.name,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    maxLines: 1,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            failure: (value) => Text(value.failure.maybeMap(
                  orElse: () => "",
                  noInternetConnection: (value) => "No Internet Connection",
                  api: (value) => value.message,
                )));
      },
    );
  }
}

class CastingActorsSection extends StatelessWidget {
  final int id;

  const CastingActorsSection({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<ActorsCastProvider, AppState>(
      create: (BuildContext context) =>
          getIt<ActorsCastProvider>()..getCastingActors(id),
      builder: (context, child) {
        final state = context.watch<AppState>();
        return state.map(
            initial: (_) => const SizedBox.shrink(),
            loading: (_) => const CircularProgressIndicator(),
            success: (value) {
              final List<ActorsCast> actorsCast = value.data;

              return SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: actorsCast.length,
                  itemBuilder: (context, index) {
                    final actor = actorsCast[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500/${actor.image}',
                              height: 100,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            actor.name,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            },
            failure: (value) => Text(value.failure.maybeMap(
                  orElse: () => "",
                  noInternetConnection: (value) => "No Internet Connection",
                  api: (value) => value.message,
                )));
      },
    );
  }
}

class MovieDetailsSection extends StatelessWidget {
  const MovieDetailsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final state = context.watch<AppState>();

      return state.map(
          initial: (_) => const SizedBox.shrink(),
          loading: (_) => const Center(child: CircularProgressIndicator()),
          success: (value) {
            final MovieDetails movieDetails = value.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  Container(
                    height: 320, // Adjust the height as needed
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/${movieDetails.image}',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              context.router.pop();
                            },
                            child: const Icon(Icons.arrow_back_ios_new)),
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.favorite_border)),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 160, left: 10, right: 10),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.red.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 8)
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500/${movieDetails.image}',
                              height: 250,
                              width: 180,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieDetails.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 20),
                        maxLines: 3,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(movieDetails.movieTag,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey)),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text("Genre: "),
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade800,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(movieDetails.genres[0].name)),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_outlined,
                                size: 20,
                                color: Colors.grey,
                              ),
                              const Text(" "),
                              Text(movieDetails.movieTime.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: Colors.green)),
                              const Text(" min")
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: Colors.grey.shade50,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(movieDetails.releasedStatus,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: movieDetails.releasedStatus ==
                                            "Released"
                                        ? Colors.green
                                        : Colors.red,
                                  )),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              const Text(" "),
                              Text(movieDetails.rating.toString(),
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const Text(" / 10 (IMDB)"),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: movieDetails.adultMovie == false
                                    ? Colors.cyan
                                    : Colors.red, // Border color
                                width: 2.0, // Border width
                              ),
                              borderRadius: BorderRadius.circular(
                                  7.0), // Border radius (adjust as needed)
                            ),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              // Adjust padding as needed
                              child: Text(
                                movieDetails.adultMovie == false
                                    ? "12+"
                                    : "18+",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  // Adjust font size as needed
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: Colors.grey.shade50,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Descriptions:",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        movieDetails.description,
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                )
              ],
            );
          },
          failure: (value) => Text(value.failure.maybeMap(
                orElse: () => "",
                noInternetConnection: (value) => "No Internet Connection",
                api: (value) => value.message,
              )));
    });
  }
}
