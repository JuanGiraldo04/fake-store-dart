import 'package:fake_store/data/models/cart_product_model.dart';
import 'package:test/test.dart';

void main() {
  group('CartProductModel', () {
    test('Given a valid JSON, should return a CartProductModel', () {
      final json = {"productId": 1, "quantity": 1};
      expect(CartProductModel.fromJson(json), isA<CartProductModel>());
    });
  });
}
