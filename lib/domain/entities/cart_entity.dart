import 'package:fake_store/domain/entities/cart_product_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_entity.freezed.dart';

@freezed
abstract class CartEntity with _$CartEntity {
  const factory CartEntity({
    required int id,
    required int userId,
    required DateTime date,
    required List<CartProductEntity> products,
  }) = _CartEntity;
}
