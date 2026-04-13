import 'package:dartz/dartz.dart';
import 'package:fake_store/data/datasources/remote/user_remote_datasource.dart';
import 'package:fake_store/data/models/name_model.dart';
import 'package:fake_store/data/models/user_model.dart';
import 'package:fake_store/data/repositories/user_repository_impl.dart';
import 'package:fake_store/domain/entities/user_entity.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserRemoteDatasource>()])
void main() {
  group('UserRepositoryImpl', () {
    late UserRepositoryImpl userRepositoryImpl;
    late MockUserRemoteDatasource mockUserRemoteDatasource;
    setUp(() {
      mockUserRemoteDatasource = MockUserRemoteDatasource();
      userRepositoryImpl = UserRepositoryImpl(
        userRemoteDatasource: mockUserRemoteDatasource,
      );
    });
    test(
      'Given a get users successful call, should return a list of users',
      () async {
        when(mockUserRemoteDatasource.getUsers()).thenAnswer(
          (_) async => [
            UserModel(
              id: 1,
              username: 'johndoe',
              email: 'johndoe@example.com',
              name: NameModel(firstname: 'John', lastname: 'Doe'),
            ),
          ],
        );
        final result = await userRepositoryImpl.getUsers();
        expect(result, isA<Right>());
        expect(result.fold((l) => l, (r) => r), isA<List<UserEntity>>());
      },
    );

    test('Given a get users failed call, should return a failure', () async {
      when(
        mockUserRemoteDatasource.getUsers(),
      ).thenAnswer((_) async => throw Exception('Error'));
      final result = await userRepositoryImpl.getUsers();
      expect(result, isA<Left>());
    });
  });
}
