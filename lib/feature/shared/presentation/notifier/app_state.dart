
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/failures.dart';

part 'app_state.freezed.dart';

@freezed
class AppState<T> with _$AppState {
  const factory AppState.initial() = _Initial;

  const factory AppState.loading() = _Loading;

  const factory AppState.success(T data) = _Success;

  const factory AppState.failure(Failures failure) = _Failure;
}