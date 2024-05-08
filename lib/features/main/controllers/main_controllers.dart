import 'dart:convert';
import 'dart:io';

import 'package:ddnangcao_project/api_services.dart';
import 'package:ddnangcao_project/models/category.dart';
import 'package:ddnangcao_project/models/pending_vendor.dart';

import 'i_main.dart';

class MainControllers implements IMain{
  final ApiServiceImpl apiService = ApiServiceImpl();
  @override
  Future<List<PendingVendor>> getAllPendingVendors() async{
    List<PendingVendor> listPendingVendor = [];
    final response = await apiService.get(url: "user/pendingvendors");
    final Map<String, dynamic> data = jsonDecode(response.body);
    if(data['status'] == 200){
      if (data['metadata']['users'] != null) {
        listPendingVendor = (data['metadata']['users'] as List)
            .map((item) => PendingVendor.fromJson(item))
            .toList();
      }
    }
    return listPendingVendor;
  }

  @override
  Future changeStatusUser(String status, String userId) async{
    final response = await apiService.post(url: "user/status", params: {
      "user" : userId,
      "status" : status
    });
  }

  @override
  Future<List<Category>> getAllCategory() async {
    final response = await apiService.get(url: "category");
    final Map<String, dynamic> data = jsonDecode(response.body);
    List<Category> categories = (data['metadata'] as List)
        .map((item) => Category.fromJson(item))
        .toList();
    return categories;
  }

  @override
  Future<int> addCategory(String cateName, File img) async {
    final response = await apiService.postFormData(url: "category", params: {
      "name" : cateName,
      "image" : img
    }, nameFieldImage: "image");
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data['status'];
  }
}