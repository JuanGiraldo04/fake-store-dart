import 'package:fake_store/core/errors/execute_api_call.dart';
import 'package:fake_store/domain/entities/product_entity.dart';

abstract interface class ProductRepository {
  Result<List<ProductEntity>> getProducts();
  Result<ProductEntity> getProductById(int id);
}
