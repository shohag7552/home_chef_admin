
import 'package:flutter/cupertino.dart';
import 'package:home_chef_admin/Model/totalUser.dart';
import 'package:home_chef_admin/server/http_request.dart';

class TotalUserProvider with ChangeNotifier{

  TotalUser totalUser = TotalUser();


  getTotalUser(context,bool onProgress) async {
    onProgress = true;
    totalUser = await CustomHttpRequest.getTotalUser(context);

    onProgress = false;
    notifyListeners();
  }
}