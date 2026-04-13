import 'package:fake_store/domain/entities/name_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'name_model.freezed.dart';
part 'name_model.g.dart';

@freezed
abstract class NameModel with _$NameModel {
  const NameModel._();
  const factory NameModel({
    required String firstname,
    required String lastname,
  }) = _NameModel;

  factory NameModel.fromJson(Map<String, dynamic> json) =>
      _$NameModelFromJson(json);

  NameEntity toEntity() => NameEntity(firstname: firstname, lastname: lastname);
}
