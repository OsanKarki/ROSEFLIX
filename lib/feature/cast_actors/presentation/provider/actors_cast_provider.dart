import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/feature/cast_actors/domain/repository/actor_cast_repository.dart';
import 'package:movie_app/feature/shared/presentation/notifier/app_state.dart';


@injectable
class ActorsCastProvider extends StateNotifier<AppState> {
  ActorsCastProvider(this.actorsCastRepository): super(const AppState.initial());

  final ActorsCastRepository actorsCastRepository;

  getCastingActors(int id) async {
    state = const AppState.loading();
    final either = await actorsCastRepository.getCastingActors(id);
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
