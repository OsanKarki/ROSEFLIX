import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/feature/home/domain/repository/movie_repository.dart';
import 'package:movie_app/feature/shared/presentation/notifier/app_state.dart';
@injectable
class MovieDetailsProvider extends StateNotifier<AppState> {
  MovieDetailsProvider(this.movieRepository) : super(const AppState.initial());

  final MovieRepository movieRepository;

  getMoviesDetails(int id) async {
    state = const AppState.loading();
    final either = await movieRepository.getMoviesDetails(id);
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
