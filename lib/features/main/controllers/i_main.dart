import 'dart:io';

import 'package:ddnangcao_project/models/category.dart';
import 'package:ddnangcao_project/models/pending_vendor.dart';

abstract class IMain {
  Future<List<PendingVendor>> getAllPendingVendors();
  Future changeStatusUser(String status, String userId);
  Future<List<Category>> getAllCategory();
  Future<int> addCategory(String cateName, File img);
}