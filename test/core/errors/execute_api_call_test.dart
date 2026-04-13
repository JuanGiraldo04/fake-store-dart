import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fake_store/core/api/api_endpoints.dart';
import 'package:fake_store/core/errors/execute_api_call.dart';
import 'package:fake_store/core/errors/failure.dart';
import 'package:test/test.dart';

void main() {
  group('ExecuteApiCall', () {
    test('Given a successful call, should return a Right', () async {
      final result = await executeApiCall(() => Future.value(1));
      expect(result, isA<Right>());
      expect(result.fold((l) => l, (r) => r), 1);
    });

    test('Given a failed call, should return a Left', () async {
      final result = await executeApiCall(
        () => Future.value(throw Exception('Error')),
      );
      expect(result, isA<Left>());
      expect(
        result.fold((l) => l, (r) => r),
        Failure.unknown(Exception('Error').toString()),
      );
    });

    test(
      'Given a 401 status code, should return a UnauthorizedFailure',
      () async {
        final result = await executeApiCall(
          () => Future.value(
            throw DioException(
              requestOptions: RequestOptions(path: ApiEndpoints.products),
              response: Response(
                statusCode: 401,
                requestOptions: RequestOptions(path: ApiEndpoints.products),
              ),
            ),
          ),
        );
        expect(result, isA<Left>());
        expect(result.fold((l) => l, (r) => r), Failure.unauthorized());
      },
    );
    test('Given a 404 status code, should return a NotFoundFailure', () async {
      final result = await executeApiCall(
        () => Future.value(
          throw DioException(
            requestOptions: RequestOptions(path: ApiEndpoints.products),
            response: Response(
              statusCode: 404,
              requestOptions: RequestOptions(path: ApiEndpoints.products),
            ),
          ),
        ),
      );
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), Failure.notFound());
    });
    test(
      'Given a 500 status code, should return a ServerErrorFailure',
      () async {
        final result = await executeApiCall(
          () => Future.value(
            throw DioException(
              requestOptions: RequestOptions(path: ApiEndpoints.products),
              response: Response(
                statusCode: 500,
                requestOptions: RequestOptions(path: ApiEndpoints.products),
              ),
            ),
          ),
        );
        expect(result, isA<Left>());
        expect(result.fold((l) => l, (r) => r), Failure.serverError());
      },
    );
    test('Given a unknown error, should return a UnknownFailure', () async {
      final result = await executeApiCall(
        () => Future.value(throw Exception('Unknown error')),
      );
      expect(result, isA<Left>());
      expect(
        result.fold((l) => l, (r) => r),
        Failure.unknown(Exception('Unknown error').toString()),
      );
    });
  });
}
