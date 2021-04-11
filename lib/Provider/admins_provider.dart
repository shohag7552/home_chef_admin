
import 'package:flutter/cupertino.dart';
import 'package:home_chef_admin/Model/admins_model.dart';
import 'package:home_chef_admin/Model/categories_model.dart';
import 'package:home_chef_admin/Model/orders_model.dart';
import 'package:home_chef_admin/Model/totalUser.dart';
import 'package:home_chef_admin/server/http_request.dart';

class AdminsProvider with ChangeNotifier{

  List<Admins> adminsList = [];


  getAdmins(context,bool onProgress) async {
    onProgress = true;

    adminsList = await CustomHttpRequest.getAllAdmin(context);
    onProgress = false;
    notifyListeners();
  }
}