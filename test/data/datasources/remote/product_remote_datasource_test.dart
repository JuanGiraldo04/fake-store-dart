import 'package:dio/dio.dart';
import 'package:fake_store/core/api/api_endpoints.dart';
import 'package:fake_store/data/datasources/datasources.dart';
import 'package:fake_store/data/models/models.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  group('ProductRemoteDatasource', () {
    late ProductRemoteDatasource productRemoteDatasource;
    late MockDio mockDio;
    setUp(() {
      mockDio = MockDio();
      productRemoteDatasource = ProductRemoteDatasource(dio: mockDio);
    });

    test('Given a json response, should return a list of products', () async {
      when(mockDio.get(any)).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          requestOptions: RequestOptions(path: ApiEndpoints.products),
          data: [
            {
              "id": 1,
              "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
              "price": 109.95,
              "description":
                  "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
              "category": "men's clothing",
              "image":
                  "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
              "rating": {"rate": 3.9, "count": 120},
            },
            {
              "id": 2,
              "title": "Mens Casual Premium Slim Fit T-Shirts ",
              "price": 22.3,
              "description":
                  "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
              "category": "men's clothing",
              "image":
                  "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_t.png",
              "rating": {"rate": 4.1, "count": 259},
            },
            {
              "id": 3,
              "title": "Mens Cotton Jacket",
              "price": 55.99,
              "description":
                  "great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions, such as working, hiking, camping, mountain/rock climbing, cycling, traveling or other outdoors. Good gift choice for you or your family member. A warm hearted love to Father, husband or son in this thanksgiving or Christmas Day.",
              "category": "men's clothing",
              "image":
                  "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_t.png",
              "rating": {"rate": 4.7, "count": 500},
            },
          ],
        ),
      );
      final result = await productRemoteDatasource.getProducts();
      expect(result, isA<List<ProductModel>>());
      expect(result.length, 3);
      expect(result[0].id, 1);
      expect(
        result[0].title,
        'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
      );
      expect(result[0].price, 109.95);
      expect(
        result[0].description,
        'Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday',
      );
      expect(result[0].category, 'men\'s clothing');
      expect(
        result[0].image,
        'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
      );
      expect(result[0].rating.rate, 3.9);
      expect(result[0].rating.count, 120);
    });

    test('Given a json response, should return a product by id', () async {
      when(mockDio.get(any)).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          requestOptions: RequestOptions(path: ApiEndpoints.products),
          data: {
            "id": 1,
            "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
            "price": 109.95,
            "description":
                "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
            "category": "men's clothing",
            "image":
                "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
            "rating": {"rate": 3.9, "count": 120},
          },
        ),
      );
      final result = await productRemoteDatasource.getProductById(1);
      expect(result, isA<ProductModel>());
      expect(result.id, 1);
      expect(
        result.title,
        'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
      );
      expect(result.price, 109.95);
      expect(
        result.description,
        'Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday',
      );
      expect(result.category, 'men\'s clothing');
    });
  });
}
