import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_product_entity.freezed.dart';

@freezed
abstract class CartProductEntity with _$CartProductEntity {
  const factory CartProductEntity({
    required int productId,
    required int quantity,
  }) = _CartProductEntity;
}
