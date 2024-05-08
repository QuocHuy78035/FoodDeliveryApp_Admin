import 'dart:io';

import 'package:ddnangcao_project/features/main/controllers/main_controllers.dart';
import 'package:flutter/cupertino.dart';

import '../models/category.dart';
import '../models/pending_vendor.dart';

class MainProvider extends ChangeNotifier{
  List<PendingVendor> listPendingVendor = [];
  List<Category> listCate = [];
  final MainControllers mainControllers = MainControllers();

  getPendingVendor() async{
    try{
      listPendingVendor = await mainControllers.getAllPendingVendors();
    }catch(e){
      print("Fail to get pending vendor main provider");
      throw Exception(e.toString());
    }finally{
      notifyListeners();
    }
    return listPendingVendor;
  }

  changeStatusUser(String userId, String status, int index) async{
    try{
      await mainControllers.changeStatusUser(status, userId);
      listPendingVendor.removeAt(index);
    }catch(e){
      print("Fail to change status user provider");
      throw Exception(e.toString());
    }finally{
      notifyListeners();
    }
  }


  getCategory() async {
    try{
      listCate = await mainControllers.getAllCategory();
    }catch(e){
      throw Exception(e);
    }finally{
      notifyListeners();
    }
    return listCate;
  }

  addCate(String cateName, File img) async {
    try {
      await mainControllers.addCategory(cateName, img);
    } catch (e) {
      throw Exception(e);
    } finally {
      notifyListeners();
    }
  }

  editCate(String cateId, String cateName, File img) async{
    try {
      await mainControllers.editCategory(
          cateId, cateName, img);
    } catch (e) {
      throw Exception(e.toString());
    } finally {}
  }
}