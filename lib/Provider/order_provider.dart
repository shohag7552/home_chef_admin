
import 'package:flutter/cupertino.dart';
import 'package:home_chef_admin/Model/orders_model.dart';
import 'package:home_chef_admin/Model/totalUser.dart';
import 'package:home_chef_admin/server/http_request.dart';

class OrderProvider with ChangeNotifier{

  //Orders orders = Orders();
  List<Orders> orderList = [];
  bool onProgress = false;

  getRecentOrders(context) async {
    onProgress = true;

    orderList = await CustomHttpRequest.getOrder(context);

    onProgress = false;
    notifyListeners();
  }
}