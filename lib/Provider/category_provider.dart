import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:home_chef_admin/Model/category_model.dart';
import 'package:home_chef_admin/Model/profile_model.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier{

  Category category = Category();
  bool onProgress = false;

  getCategoryData(context, int id) async {
    onProgress = true;
    category = await CustomHttpRequest.getCategoryEditId(context,id);
    onProgress = false;
    notifyListeners();
  }
}