import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:home_chef_admin/Model/profile_model.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:http/http.dart' as http;

class ProfileProvider with ChangeNotifier{

  Profile profile = Profile();


  getProfileData(context,bool onProgress) async {
    onProgress = true;
    profile = await CustomHttpRequest.fetchProfile(context);
    onProgress = false;
    notifyListeners();
  }
}