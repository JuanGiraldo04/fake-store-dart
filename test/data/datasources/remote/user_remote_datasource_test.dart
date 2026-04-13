import 'package:dio/dio.dart';
import 'package:fake_store/core/api/api_endpoints.dart';
import 'package:fake_store/data/datasources/remote/user_remote_datasource.dart';
import 'package:fake_store/data/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'product_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  group('UserRemoteDatasource', () {
    late UserRemoteDatasource userRemoteDatasource;
    late MockDio mockDio;
    setUp(() {
      mockDio = MockDio();
      userRemoteDatasource = UserRemoteDatasource(dio: mockDio);
    });

    test('Given a json response, should return a list of users', () async {
      when(mockDio.get(any)).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          requestOptions: RequestOptions(path: ApiEndpoints.users),
          data: [
            {
              "id": 1,
              "username": "johndoe",
              "name": {"firstname": "John", "lastname": "Doe"},
              "email": "johndoe@example.com",
            },
          ],
        ),
      );
      final result = await userRemoteDatasource.getUsers();
      expect(result, isA<List<UserModel>>());
      expect(result.length, 1);
      expect(result[0].id, 1);
      expect(result[0].username, 'johndoe');
      expect(result[0].email, 'johndoe@example.com');
    });
  });
}
