import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
abstract class Failure with _$Failure {
  const Failure._();

  const factory Failure.network() = _NetworkFailure;
  const factory Failure.unauthorized() = _UnauthorizedFailure;
  const factory Failure.notFound() = _NotFoundFailure;
  const factory Failure.serverError() = _ServerErrorFailure;
  const factory Failure.unknown([String? message]) = _UnknownFailure;

  String get userMessage => when(
    network: () => 'Sin conexión a internet',
    unauthorized: () => 'Sesión expirada',
    notFound: () => 'Recurso no encontrado',
    serverError: () => 'Error del servidor. Intenta de nuevo más tarde.',
    unknown: (message) => message ?? 'Error inesperado',
  );
}
