import 'package:fake_store/core/errors/failure.dart';
import 'package:test/test.dart';

void main() {
  group('Failure', () {
    test('Given a network failure, should return a failure', () {
      final failure = const Failure.network();
      expect(failure, isA<Failure>());
      expect(failure.userMessage, 'Sin conexión a internet');
    });
    test('Given a unauthorized failure, should return a failure', () {
      final failure = const Failure.unauthorized();
      expect(failure, isA<Failure>());
      expect(failure.userMessage, 'Sesión expirada');
    });
    test('Given a not found failure, should return a failure', () {
      final failure = const Failure.notFound();
      expect(failure, isA<Failure>());
      expect(failure.userMessage, 'Recurso no encontrado');
    });
    test('Given a server error failure, should return a failure', () {
      final failure = const Failure.serverError();
      expect(failure, isA<Failure>());
      expect(
        failure.userMessage,
        'Error del servidor. Intenta de nuevo más tarde.',
      );
    });
    test('Given a unknown failure, should return a failure', () {
      final failure = const Failure.unknown('Error');
      expect(failure, isA<Failure>());
      expect(failure.userMessage, 'Error');
    });
  });
}
