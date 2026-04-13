import 'package:fake_store/core/errors/execute_api_call.dart';
import 'package:fake_store/data/datasources/datasources.dart';
import 'package:fake_store/domain/entities/product_entity.dart';
import 'package:fake_store/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource productRemoteDatasource;

  ProductRepositoryImpl({required this.productRemoteDatasource});

  @override
  Result<List<ProductEntity>> getProducts() async => executeApiCall(
    () => productRemoteDatasource.getProducts().then(
      (value) => value.map((e) => e.toEntity()).toList(),
    ),
  );

  @override
  Result<ProductEntity> getProductById(int id) {
    return executeApiCall(
      () => productRemoteDatasource
          .getProductById(id)
          .then((value) => value.toEntity()),
    );
  }
}
