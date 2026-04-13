import 'package:fake_store/data/models/cart_model.dart';
import 'package:test/test.dart';

void main() {
  group('CartModel', () {
    test('Given a valid JSON, should return a CartModel', () {
      final json = {
        "id": 1,
        "userId": 1,
        "date": "2020-03-02T00:00:00.000Z",
        "products": [
          {"productId": 1, "quantity": 4},
          {"productId": 2, "quantity": 1},
          {"productId": 3, "quantity": 6},
        ],
      };
      expect(CartModel.fromJson(json), isA<CartModel>());
    });
  });
}
