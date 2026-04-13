import 'package:dartz/dartz.dart';
import 'package:fake_store/data/datasources/datasources.dart';
import 'package:fake_store/data/models/models.dart';
import 'package:fake_store/data/repositories/product_repository_impl.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProductRemoteDatasource>()])
void main() {
  group('ProductRepositoryImpl', () {
    late ProductRepositoryImpl productRepositoryImpl;
    late MockProductRemoteDatasource mockProductRemoteDatasource;
    setUp(() {
      mockProductRemoteDatasource = MockProductRemoteDatasource();
      productRepositoryImpl = ProductRepositoryImpl(
        productRemoteDatasource: mockProductRemoteDatasource,
      );
    });

    test(
      'Given a get products successful call, should return a list of products',
      () async {
        when(mockProductRemoteDatasource.getProducts()).thenAnswer(
          (_) async => [
            const ProductModel(
              id: 1,
              title: 'Product 1',
              price: 100,
              description: 'Description 1',
              category: 'Category 1',
              image: 'Image 1',
              rating: RatingModel(rate: 1, count: 1),
            ),
          ],
        );
        final result = await productRepositoryImpl.getProducts();
        expect(result, isA<Right>());
      },
    );

    test('Given a get products failed call, should return a failure', () async {
      when(
        mockProductRemoteDatasource.getProducts(),
      ).thenAnswer((_) async => throw Exception('Error'));
      final result = await productRepositoryImpl.getProducts();
      expect(result, isA<Left>());
    });

    test(
      'Given a get product by id successful call, should return a product by id',
      () async {
        when(mockProductRemoteDatasource.getProductById(1)).thenAnswer(
          (_) async => const ProductModel(
            id: 1,
            title: 'Product 1',
            price: 100,
            description: 'Description 1',
            category: 'Category 1',
            image: 'Image 1',
            rating: RatingModel(rate: 1, count: 1),
          ),
        );
        final result = await productRepositoryImpl.getProductById(1);
        expect(result, isA<Right>());
      },
    );

    test(
      'Given a get product by id failed call, should return a failure',
      () async {
        when(
          mockProductRemoteDatasource.getProductById(1),
        ).thenAnswer((_) async => throw Exception('Error'));
        final result = await productRepositoryImpl.getProductById(1);
        expect(result, isA<Left>());
      },
    );
  });
}
