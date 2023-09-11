import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failures with _$Failures {
  const factory Failures.noInternetConnection() = _NoInternetConnection;

  const factory Failures.api({required String message}) = _API;

  const factory Failures.unexpected({required String message}) = _Unexpected;
}
