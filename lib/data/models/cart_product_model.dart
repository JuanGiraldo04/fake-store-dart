import 'package:fake_store/domain/entities/cart_product_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_product_model.freezed.dart';
part 'cart_product_model.g.dart';

@freezed
abstract class CartProductModel with _$CartProductModel {
  const CartProductModel._();
  const factory CartProductModel({
    required int productId,
    required int quantity,
  }) = _CartProductModel;

  factory CartProductModel.fromJson(Map<String, dynamic> json) =>
      _$CartProductModelFromJson(json);

  CartProductEntity toEntity() =>
      CartProductEntity(productId: productId, quantity: quantity);
}
