import 'package:freezed_annotation/freezed_annotation.dart';

part 'name_entity.freezed.dart';

@freezed
abstract class NameEntity with _$NameEntity {
  const factory NameEntity({
    required String firstname,
    required String lastname,
  }) = _NameEntity;
}
