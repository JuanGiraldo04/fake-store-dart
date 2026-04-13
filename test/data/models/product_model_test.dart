import 'package:fake_store/data/models/product_model.dart';
import 'package:test/test.dart';

void main() {
  group('ProductModel', () {
    test('Given a valid JSON, should return a ProductModel', () {
      final json = {
        "id": 1,
        "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
        "price": 109.95,
        "description":
            "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
        "category": "men's clothing",
        "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
        "rating": {"rate": 3.9, "count": 120},
      };
      expect(ProductModel.fromJson(json), isA<ProductModel>());
    });
  });
}
