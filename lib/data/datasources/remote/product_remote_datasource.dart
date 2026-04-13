import 'package:dio/dio.dart';
import 'package:fake_store/core/api/api_endpoints.dart';
import 'package:fake_store/data/models/product_model.dart';

class ProductRemoteDatasource {
  final Dio dio;

  ProductRemoteDatasource({required this.dio});

  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get(ApiEndpoints.products);
    return (response.data as List<dynamic>)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ProductModel> getProductById(int id) async {
    final response = await dio.get('${ApiEndpoints.products}/$id');
    return ProductModel.fromJson(response.data as Map<String, dynamic>);
  }
}
