import 'package:fake_store/core/errors/execute_api_call.dart';
import 'package:fake_store/domain/entities/user_entity.dart';

abstract interface class UserRepository {
  Result<List<UserEntity>> getUsers();
}
