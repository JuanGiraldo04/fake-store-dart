import 'package:dartz/dartz.dart';
import 'package:fake_store/data/datasources/datasources.dart';
import 'package:fake_store/data/models/cart_model.dart';
import 'package:fake_store/data/models/cart_product_model.dart';
import 'package:fake_store/data/repositories/cart_repository_impl.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CartRemoteDatasource>()])
void main() {
  group('CartRepositoryImpl', () {
    late CartRepositoryImpl cartRepositoryImpl;
    late MockCartRemoteDatasource mockCartRemoteDatasource;
    setUp(() {
      mockCartRemoteDatasource = MockCartRemoteDatasource();
      cartRepositoryImpl = CartRepositoryImpl(
        cartRemoteDatasource: mockCartRemoteDatasource,
      );
    });
    test(
      'Given a get carts successful call, should return a list of carts',
      () async {
        when(mockCartRemoteDatasource.getCarts()).thenAnswer(
          (_) async => [
            CartModel(
              id: 1,
              userId: 1,
              date: DateTime.now(),
              products: [const CartProductModel(productId: 1, quantity: 1)],
            ),
          ],
        );
        final result = await cartRepositoryImpl.getCarts();
        expect(result, isA<Right>());
      },
    );
    test('Given a get carts failed call, should return a failure', () async {
      when(
        mockCartRemoteDatasource.getCarts(),
      ).thenAnswer((_) async => throw Exception('Error'));
      final result = await cartRepositoryImpl.getCarts();
      expect(result, isA<Left>());
    });
  });
}
