import 'package:dio/dio.dart';
import 'package:fake_store/core/api/api_endpoints.dart';
import 'package:fake_store/data/models/user_model.dart';

class UserRemoteDatasource {
  final Dio dio;

  UserRemoteDatasource({required this.dio});

  Future<List<UserModel>> getUsers() async {
    final response = await dio.get(ApiEndpoints.users);
    return (response.data as List<dynamic>)
        .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
