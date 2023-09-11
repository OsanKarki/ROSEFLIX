import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../../shared/presentation/notifier/app_state.dart';
import '../../domain/repository/movie_repository.dart';

@injectable
class MovieProvider extends StateNotifier<AppState> {
  final MovieRepository movieRepository;

  MovieProvider(this.movieRepository) : super(const AppState.initial());

  getMovies() async {
    state = const AppState.loading();
    final either = await movieRepository.getMovies();
    either.fold(
      (l) {
        state = AppState.failure(l);
      },
      (r) {
        state = AppState.success(r);
      },
    );
  }

  getUpcomingMovies() async {
    state = const AppState.loading();
    final either = await movieRepository.getUpcomingMovies();
    either.fold(
      (l) {
        state = AppState.failure(l);
      },
      (r) {
        state = AppState.success(r);
      },
    );
  }

  getTopRatedMovies() async {
    state = const AppState.loading();
    final either = await movieRepository.getTopRatedMovies();
    either.fold(
      (l) {
        state = AppState.failure(l);
      },
      (r) {
        state = AppState.success(r);
      },
    );
  }

  getSearchMovies(String searchQuery) async {
    state = const AppState.loading();
    final either = await movieRepository.getSearchMovies(searchQuery);
    either.fold(
      (l) {
        state = AppState.failure(l);
      },
      (r) {
        state = AppState.success(r);
      },
    );
  }

  getRecomendedMovies(int id) async {
    state = const AppState.loading();
    final either = await movieRepository.getRecomendedMovies(id);
    either.fold(
      (l) {
        state = AppState.failure(l);
      },
      (r) {
        state = AppState.success(r);
      },
    );
  }
}
