import 'package:dio/dio.dart';
import 'package:fake_store/core/api/api_endpoints.dart';
import 'package:fake_store/data/models/cart_model.dart';

class CartRemoteDatasource {
  final Dio dio;

  CartRemoteDatasource({required this.dio});

  Future<List<CartModel>> getCarts() async {
    final response = await dio.get(ApiEndpoints.carts);
    return (response.data as List<dynamic>)
        .map((e) => CartModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
