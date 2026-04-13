import 'package:fake_store/core/errors/execute_api_call.dart';
import 'package:fake_store/domain/entities/cart_entity.dart';

abstract interface class CartRepository {
  Result<List<CartEntity>> getCarts();
}
