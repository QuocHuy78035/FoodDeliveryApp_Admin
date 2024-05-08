
import 'package:flutter/cupertino.dart';

abstract class IAuth{
  Future<String> loginUser(String email, String password, BuildContext context);
}