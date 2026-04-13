import 'package:dio/dio.dart';
import 'package:fake_store/core/api/api_endpoints.dart';
import 'package:fake_store/data/datasources/datasources.dart';
import 'package:fake_store/data/models/cart_model.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  late CartRemoteDatasource cartRemoteDatasource;
  late MockDio mockDio;
  setUp(() {
    mockDio = MockDio();
    cartRemoteDatasource = CartRemoteDatasource(dio: mockDio);
  });
  group('CartRemoteDatasource', () {
    test('Given a json response, should return a list of carts', () async {
      when(mockDio.get(any)).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          requestOptions: RequestOptions(path: ApiEndpoints.carts),
          data: [
            {
              "id": 1,
              "userId": 1,
              "date": "2020-03-02T00:00:00.000Z",
              "products": [
                {"productId": 1, "quantity": 1},
              ],
            },
          ],
        ),
      );
      final result = await cartRemoteDatasource.getCarts();
      expect(result, isA<List<CartModel>>());
      expect(result.length, 1);
      expect(result[0].id, 1);
      expect(result[0].userId, 1);
      expect(result[0].date, DateTime.parse("2020-03-02T00:00:00.000Z"));
      expect(result[0].products.length, 1);
      expect(result[0].products[0].productId, 1);
      expect(result[0].products[0].quantity, 1);
    });
  });
}
