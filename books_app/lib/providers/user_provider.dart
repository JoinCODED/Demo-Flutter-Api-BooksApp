import 'package:books_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String token = "";
  late User user;

  void signUp({required User user}) async {
    token = await AuthServices().signUp(user: user);
    setToken(token);
    notifyListeners();
  }

  void signin({required User user}) async {
    token = await AuthServices().signIn(user: user);
    setToken(token);
    notifyListeners();
  }

  void setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  void getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
  }

  bool get isAuths {
    getToken();
    print(token);
    if (token.isNotEmpty && Jwt.getExpiryDate(token)!.isAfter(DateTime.now())) {
      print(Jwt.parseJwt(token));
      // user = User.fromJson(Jwt.parseJwt(token));
      return true;
    }
    return false;
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    token = "";
    notifyListeners();
  }
}
