import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:home_chef_admin/Model/category_model.dart';
import 'package:home_chef_admin/Model/products_model.dart';
import 'package:home_chef_admin/Model/profile_model.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:http/http.dart' as http;

class EditProductProvider with ChangeNotifier{

  Products products = Products();

  getProductData(context, int id, bool onProgress) async {
    onProgress = true;
    products = await CustomHttpRequest.getProductEditId(context, id);

    onProgress = false;
    notifyListeners();
  }
}