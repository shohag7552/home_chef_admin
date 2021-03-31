
import 'package:flutter/cupertino.dart';
import 'package:home_chef_admin/Model/totalOrder.dart';
import 'package:home_chef_admin/Model/totalUser.dart';
import 'package:home_chef_admin/server/http_request.dart';

class TotalOrderProvider with ChangeNotifier{

  TotalOrder totalOrder = TotalOrder();
  bool onProgress = false;

  getTotalUser(context) async {
    onProgress = true;
    totalOrder = await CustomHttpRequest.getTotalOrder(context);

    onProgress = false;
    notifyListeners();
  }
}