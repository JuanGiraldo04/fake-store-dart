import 'package:dio/dio.dart';
import 'package:fake_store/core/api/api_endpoints.dart';
import 'package:fake_store/core/errors/failure.dart';
import 'package:fake_store/data/datasources/datasources.dart';
import 'package:fake_store/data/repositories/repositories.dart';
import 'package:fake_store/domain/entities/cart_entity.dart';
import 'package:fake_store/domain/entities/product_entity.dart';
import 'package:fake_store/domain/entities/user_entity.dart';

void main() async {
  final dio = Dio()..options.baseUrl = ApiEndpoints.baseUrl;

  final productRepository = ProductRepositoryImpl(
    productRemoteDatasource: ProductRemoteDatasource(dio: dio),
  );
  final cartRepository = CartRepositoryImpl(
    cartRemoteDatasource: CartRemoteDatasource(dio: dio),
  );
  final userRepository = UserRepositoryImpl(
    userRemoteDatasource: UserRemoteDatasource(dio: dio),
  );

  // Products
  final products = await productRepository.getProducts().then(
    (result) => result.fold(_handleError, (r) => r),
  );
  if (products != null) _printProducts(products);

  // Product by ID
  final product = await productRepository
      .getProductById(1)
      .then((result) => result.fold(_handleError, (r) => r));
  if (product != null) _printProduct(product);

  // Carts
  final carts = await cartRepository.getCarts().then(
    (result) => result.fold(_handleError, (r) => r),
  );
  if (carts != null) _printCarts(carts);

  // Users
  final users = await userRepository.getUsers().then(
    (result) => result.fold(_handleError, (r) => r),
  );
  if (users != null) _printUsers(users);
}

// ─── Error handler ────────────────────────────────────────────────────────────

Null _handleError(Failure failure) {
  print('❌ Error: ${failure.userMessage}');
  return null;
}

// ─── Separators ───────────────────────────────────────────────────────────────

void _printHeader(String title) {
  print('');
  print('═' * 50);
  print('  $title');
  print('═' * 50);
}

void _printDivider() => print('─' * 50);

// ─── Products ─────────────────────────────────────────────────────────────────

void _printProducts(List<ProductEntity> products) {
  _printHeader('PRODUCTOS (${products.length})');
  for (final p in products) {
    _printProductRow(p);
    _printDivider();
  }
}

void _printProduct(ProductEntity product) {
  _printHeader('PRODUCTO #${product.id}');
  _printProductRow(product);
  _printDivider();
}

void _printProductRow(ProductEntity p) {
  print('  [${p.id}] ${p.title}');
  print('  Categoría : ${p.category}');
  print('  Precio    : \$${p.price.toStringAsFixed(2)}');
  print('  Rating    : ${p.rating.rate} ⭐ (${p.rating.count} reseñas)');
  print('  Descripción: ${_truncate(p.description)}');
}

// ─── Carts ────────────────────────────────────────────────────────────────────

void _printCarts(List<CartEntity> carts) {
  _printHeader('CARRITOS (${carts.length})');
  for (final c in carts) {
    print('  Carrito #${c.id} — Usuario: ${c.userId}');
    print('  Fecha    : ${c.date.toLocal().toString().split(' ')[0]}');
    print('  Productos: ${c.products.length} ítem(s)');
    for (final p in c.products) {
      print('    • Producto #${p.productId} x${p.quantity}');
    }
    _printDivider();
  }
}

// ─── Users ────────────────────────────────────────────────────────────────────

void _printUsers(List<UserEntity> users) {
  _printHeader('USUARIOS (${users.length})');
  for (final u in users) {
    print('  [${u.id}]: ${u.name.firstname} ${u.name.lastname}');
    print('  Username : ${u.username}');
    print('  Email    : ${u.email}');
    _printDivider();
  }
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

String _truncate(String text, {int maxLength = 80}) {
  if (text.length <= maxLength) return text;
  return '${text.substring(0, maxLength)}...';
}
