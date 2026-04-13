import 'package:fake_store/data/models/user_model.dart';
import 'package:fake_store/domain/entities/user_entity.dart';
import 'package:test/test.dart';

void main() {
  group('UserModel', () {
    test('Given a valid JSON, should return a UserModel', () {
      final json = {
        "id": 1,
        "username": "johndoe",
        "name": {"firstname": "John", "lastname": "Doe"},
        "email": "johndoe@example.com",
      };
      expect(UserModel.fromJson(json), isA<UserModel>());
      expect(UserModel.fromJson(json).toEntity(), isA<UserEntity>());
    });
  });
}
