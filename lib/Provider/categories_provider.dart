
import 'package:flutter/cupertino.dart';
import 'package:home_chef_admin/Model/categories_model.dart';
import 'package:home_chef_admin/Model/orders_model.dart';
import 'package:home_chef_admin/Model/totalUser.dart';
import 'package:home_chef_admin/server/http_request.dart';

class CategoriesProvider with ChangeNotifier{

  List<Categories> categoriesList = [];


  getCategories(context,bool onProgress) async {
    onProgress = true;

    categoriesList = await CustomHttpRequest.getCategories(context);
    onProgress = false;
    notifyListeners();
  }
}