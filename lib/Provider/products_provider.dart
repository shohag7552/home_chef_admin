
import 'package:flutter/cupertino.dart';
import 'package:home_chef_admin/Model/categories_model.dart';
import 'package:home_chef_admin/Model/orders_model.dart';
import 'package:home_chef_admin/Model/products_model.dart';
import 'package:home_chef_admin/Model/totalUser.dart';
import 'package:home_chef_admin/server/http_request.dart';

class ProductsProvider with ChangeNotifier{

  List<Products> productsList = [];
  bool onProgress = false;

  getProducts(context,bool onProgress) async {
    onProgress = true;

    print('$onProgress');

    productsList = await CustomHttpRequest.getProducts(context);
    //print(productsList);
    onProgress = false;
    print('$onProgress');
    notifyListeners();
  }
}