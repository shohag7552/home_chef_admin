

import 'dart:convert';

import 'package:home_chef_admin/Model/orders_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class CustomHttpRequest{
  static const String uri = "https://apihomechef.masudlearn.com";
  static const Map<String, String> defaultHeader = {
    "Accept": "application/json",
  };
  static SharedPreferences sharedPreferences;

  static Future<Map<String, String>> getHeaderWithToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      "Accept": "application/json",
      "Authorization": "bearer ${sharedPreferences.getString("token")}",
    };
    print("user token is :${sharedPreferences.getString('token')}");
    return header;
  }

  static Future<String> login(String email, String password) async {
    try {
      String url = "$uri/api/admin/login";
      var map = Map<String, dynamic>();
      map['email'] = email;
      map['password'] = password;
      Uri myUri = Uri.parse(url);
      final response = await http.post(myUri, body: map, headers: defaultHeader);
      print(response.body);
      if (response.statusCode == 200) {
        return response.body;
      }
      print(response.body);
      return "Something Wrong";
    } catch (e) {
      return e.toString();
    }
  }
  static Future<dynamic> getTotalUser() async{
    try{
      String url = "$uri/api/admin/total/user";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      final data = jsonDecode(response.body);
      return data;
    } catch(e){
      print(e);
      return {"error": "Something Wrong Exception"};
    }
  }  static Future<dynamic> getTotalOrder() async{
    try{
      String url = "$uri/api/admin/total/orders";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      final data = jsonDecode(response.body);
      return data;
    } catch(e){
      print(e);
      return {"error": "Something Wrong Exception"};
    }
  }

  static Future<List<Orders>> getOrder() async {

      String url = "$uri/api/admin/all/orders";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);

        List<Orders> posts = body
            .map(
              (dynamic item) => Orders.fromJson(item),
        )
            .toList();

        return posts;
      } else {
        throw "Unable to retrieve posts.";
      }

  }


}