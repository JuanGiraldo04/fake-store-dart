import 'package:fake_store/data/models/cart_product_model.dart';
import 'package:fake_store/domain/entities/cart_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
abstract class CartModel with _$CartModel {
  const CartModel._();
  const factory CartModel({
    required int id,
    required int userId,
    required DateTime date,
    required List<CartProductModel> products,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  CartEntity toEntity() => CartEntity(
    id: id,
    userId: userId,
    date: date,
    products: products.map((e) => e.toEntity()).toList(),
  );
}
