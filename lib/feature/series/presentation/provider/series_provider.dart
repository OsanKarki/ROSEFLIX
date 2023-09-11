import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/feature/shared/presentation/notifier/app_state.dart';

import '../../domain/repository/series_repository.dart';

@injectable
class SeriesProvider extends StateNotifier<AppState> {
  final SeriesRepository seriesRepository;

  SeriesProvider(this.seriesRepository) : super(const AppState.initial());

  getSeries() async {
    state = const AppState.loading();
    final either = await seriesRepository.getSeries();
    either.fold(
      (l) {
        state = AppState.failure(l);
      },
      (r) {
        state = AppState.success(r);
      },
    );
  }

  getOnAirSeries() async {
    state = const AppState.loading();
    final either = await seriesRepository.getOnAirSeries();
    either.fold(
      (l) {
        state = AppState.failure(l);
      },
      (r) {
        state = AppState.success(r);
      },
    );
  }

  getTopRatedSeries() async {
    state = const AppState.loading();
    final either = await seriesRepository.getTopRatedSeries();
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
