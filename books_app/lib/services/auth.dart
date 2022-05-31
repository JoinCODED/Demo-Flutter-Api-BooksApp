import 'package:dio/dio.dart';

import '../models/user.dart';
import 'client.dart';

class AuthServices {
  final _dio = Dio();

  Future<String> signUp({required User user}) async {
    late String token;
    try {
      Response res = await Client.dio.post("/signup", data: user.toJson());
      token = res.data["token"];
    } on DioError catch (error) {
      print(error);
    }
    return token;
  }

  Future<String> signIn({required User user}) async {
    late String token;
    try {
      Response res = await Client.dio.post("/signin", data: user.toJson());
      token = res.data["token"];
      print(res);
    } on DioError catch (error) {
      print(error);
    }
    return token;
  }
}
