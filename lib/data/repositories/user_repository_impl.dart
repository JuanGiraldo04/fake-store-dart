import 'package:fake_store/core/errors/execute_api_call.dart';
import 'package:fake_store/data/datasources/datasources.dart';
import 'package:fake_store/domain/entities/user_entity.dart';
import 'package:fake_store/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource userRemoteDatasource;

  UserRepositoryImpl({required this.userRemoteDatasource});

  @override
  Result<List<UserEntity>> getUsers() {
    return executeApiCall(
      () => userRemoteDatasource.getUsers().then(
        (value) => value.map((e) => e.toEntity()).toList(),
      ),
    );
  }
}
