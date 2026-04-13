import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'failure.dart';

typedef Result<T> = Future<Either<Failure, T>>;

Result<T> executeApiCall<T>(Future<T> Function() call) async {
  try {
    return Right(await call());
  } on DioException catch (e) {
    final int? status = e.response?.statusCode;
    return Left(switch (status) {
      401 => const Failure.unauthorized(),
      404 => const Failure.notFound(),
      final int s when s >= 500 => const Failure.serverError(),
      _ => const Failure.network(),
    });
  } catch (e) {
    return Left(Failure.unknown(e.toString()));
  }
}
