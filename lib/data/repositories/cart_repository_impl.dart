import 'package:fake_store/core/errors/execute_api_call.dart';
import 'package:fake_store/data/datasources/datasources.dart';
import 'package:fake_store/domain/entities/cart_entity.dart';
import 'package:fake_store/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDatasource cartRemoteDatasource;

  CartRepositoryImpl({required this.cartRemoteDatasource});

  @override
  Result<List<CartEntity>> getCarts() {
    return executeApiCall(
      () => cartRemoteDatasource.getCarts().then(
        (value) => value.map((e) => e.toEntity()).toList(),
      ),
    );
  }
}
