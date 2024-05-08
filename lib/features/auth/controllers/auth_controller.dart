import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api_services.dart';
import '../../../providers/user_provider.dart';
import 'i_auth.dart';

class AuthController implements IAuth {
  static String resetUrl = "";
  ApiServiceImpl apiServiceImpl = ApiServiceImpl();

  @override
  Future<String> loginUser(
      String email, String password, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String resMessage;
    final response = await apiServiceImpl.post(
        url: 'login',
        params: {'email': email, 'password': password},
        needTokenAndUserId: false);
    final Map<String, dynamic> data = jsonDecode(response.body);
    resMessage = data["message"];
    if (response.statusCode == 200 && data['metadata']['user']['role'] == "admin") {
      String accessToken = data['metadata']['tokens']['accessToken'].toString();
      String refreshToken =
          data['metadata']['tokens']['refreshToken'].toString();
      String userId = data['metadata']['user']['_id'].toString();
      String name = data['metadata']['user']['name'].toString();
      String email = data['metadata']['user']['email'].toString();
      await prefs.setString('accessToken', accessToken);
      await prefs.setString("refreshToken", refreshToken);
      await prefs.setString("userId", userId);
      await prefs.setString("name", name);
      await prefs.setString("email", email);
      Provider.of<UserProvider>(context, listen: false)
          .setUser(data['metadata']['user']);
    } else {
      return "Incorrect email or password";
    }
    return resMessage;
  }

}
