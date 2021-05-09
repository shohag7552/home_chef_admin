

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Model/admins_model.dart';
import 'package:home_chef_admin/Model/categories_model.dart';
import 'package:home_chef_admin/Model/category_model.dart';
import 'package:home_chef_admin/Model/order_model.dart';
import 'package:home_chef_admin/Model/orders_model.dart';
import 'package:home_chef_admin/Model/products_model.dart';
import 'package:home_chef_admin/Model/profile_model.dart';
import 'package:home_chef_admin/Model/totalOrder.dart';
import 'package:home_chef_admin/Model/totalUser.dart';
import 'package:home_chef_admin/Screens/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class CustomHttpRequest{
  static const String uri = "https://apihomechef.antapp.space";
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

  static Future<dynamic> getProfile() async {
    try {
      String url = "$uri/api/admin/profile";
      Uri myUri = Uri.parse(url);
      var response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      print(e);
      return {"error": "Something Wrong Exception"};
    }
  }
  //Provider..........
  static Future<Profile> fetchProfile(context) async {
    Profile profile;
    try {
      String url = "$uri/api/admin/profile";
      Uri myUri = Uri.parse(url);
      var response = await http.get(
          myUri, headers: await CustomHttpRequest.getHeaderWithToken()
      );
      print("Profile status code${response.statusCode}");
      if (response.statusCode == 401){
        final item = json.decode(response.body);
        print("401 response :$item");
        print(item['errors']);
        showInToast(context, "${item['errors']}");
        /*Navigator.push(context, MaterialPageRoute(builder: (context){
         return LoginPage();
        }));*/
        //return Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> LoginPage()));
      }
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print(item);
        profile = Profile.fromJson(item);
      } else {
        print('Data not found');

      }
    } catch (e) {
      print(e);
    }
    return profile;

  }
  // Provider...
  static Future<dynamic> getTotalUser(context) async{
    TotalUser totalUser;
    try{
      String url = "$uri/api/admin/total/user";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      if(response.statusCode == 200){
        final item = json.decode(response.body);
        totalUser = TotalUser.fromJson(item);
      }
      else{
        print('Data not found');
      }
    } catch(e){
      print(e);
    }
    return totalUser;
  }

  //provider...
  static Future<dynamic> getTotalOrder(context) async{
    TotalOrder totalOrder;
    try{
      String url = "$uri/api/admin/total/orders";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      if(response.statusCode == 200){
        final item = json.decode(response.body);
        totalOrder = TotalOrder.fromJson(item);
      }
      else{
        print('Data not found');
      }
    } catch(e){
      print(e);
    }
    return totalOrder;
  }


  static Future<String> login(String email, String password) async {
    try {
      String url = "$uri/api/admin/sign-in";
      var map = Map<String, dynamic>();
      map['email'] = email;
      map['password'] = password;
      Uri myUri = Uri.parse(url);
      final response = await http.post(myUri, body: map, headers: defaultHeader);
      print(response.body);
      if (response.statusCode == 200) {
        return response.body;
      }
      else{
        print('................');
        print(response.body);
      }
      print(response.body);
      return "Something Wrong";
    } catch (e) {
      return e.toString();
    }
  }

  //provider...
  static Future<dynamic> getOrder(context) async{
    Orders orders;
    List<Orders> orderList = [];
    try{
      String url = "$uri/api/admin/all/orders";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      print(response.statusCode);
      if(response.statusCode == 200){

        final item = json.decode(response.body);
        print(item);
        for(var i in item){
          orders = Orders.fromJson(i);
          orderList.add(orders);
          print("orders: $orderList");
        }

      }
      else{
        print('Data not found');
      }
    } catch(e){
      print(e);
    }
    return orderList;
  }

  //for dropdownButton
  static Future<dynamic> getCategoriesDropDown() async {
    try {
      String url = "$uri/api/admin/category";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      if (response.statusCode == 200) {
        print(response);
        return response;
      } else
        return "Error";
    } catch (e) {
      print(e);
      return "Something Wrong...!!!";
    }

  }
  //for dropdownButton
  static Future<dynamic> getUsersDropDown() async {
    try {
      String url = "$uri/api/admin/all/user";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      if (response.statusCode == 200) {
        print(response);
        return response;
      } else
        return "Error";
    } catch (e) {
      print(e);
      return "Something Wrong...!!!";
    }

  }
  //for dropdownButton
  static Future<dynamic> getProductDropDown() async {
    try {
      String url = "$uri/api/admin/products";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      if (response.statusCode == 200) {
        print(response);
        return response;
      } else
        return "Error";
    } catch (e) {
      print(e);
      return "Something Wrong...!!!";
    }

  }


  //provider...
  static Future<dynamic> getCategories(context) async{
    Categories categories;
    List<Categories> categoriesList = [];
    try{
      String url = "$uri/api/admin/category";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      if(response.statusCode == 200){

        final item = json.decode(response.body);
        print(item);
        for(var i in item){
          categories = Categories.fromJson(i);
          categoriesList.add(categories);
        }

      }
      else{
        print('Data not found');
      }
    } catch(e){
      print(e);
    }
    return categoriesList;
  }

//provider...

  static Future<dynamic> getAllAdmin(context) async{
    Admins admins;
    List<Admins> adminsList = [];
    try{
      String url = "$uri/api/admin/all/admins";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      if(response.statusCode == 200){

        final item = json.decode(response.body);
        for(var i in item){
          admins = Admins.fromJson(i);
          adminsList.add(admins);
        }

      }
      else{
        print('Data not found');
      }
    } catch(e){
      print(e);
    }
    return adminsList;
  }

  //provider...
  static Future<dynamic> getProducts(context) async{
    Products products;
    List<Products> productsList = [];
    try{


      String url = "$uri/api/admin/products";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      print('product');
      print(response.statusCode);
      if(response.statusCode == 200){

        final item = json.decode(response.body);
        print(item);
        print('done----------------------');
        for(var i in item){
          products = Products.fromJson(i);
          productsList.add(products);
        }
        /*for(int i=0 ; i<item.length;i++){
          products = Products.fromJson(item[i]);
          productsList.add(products);
        }*/


      }
      else{
        print('Data not found');
      }
    } catch(e){
      print(e);
    }
    return productsList;
  }

  //Categories item delete...
  static Future<dynamic> deleteCategoryItem(BuildContext context,int id)async{
    try{
      print(id.toString());
      String url = "$uri/api/admin/category/$id/delete";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.delete(
          myUri,headers: await getHeaderWithToken()
      );
      final data = jsonDecode(response.body);
      print(data.toString());

      if(response.statusCode==200){
        print(data);
        print("delete sucessfully");
        print(data['message'].toString());
        showInToast(context,'${data['message']}');
        return response;

      }
      else{
        throw Exception("Can't delete ");
      }
    }catch(e){
      print(e);
    }
  }
  //Product item delete...
  static Future<dynamic> deleteProductItem(BuildContext context,int id)async{
    try{
      print(id.toString());
      String url = "$uri/api/admin/product/$id/delete";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.delete(
          myUri,headers: await getHeaderWithToken()
      );
      final data = jsonDecode(response.body);
      print(data.toString());
      print(response.statusCode);
      if(response.statusCode==200){
        print(data);
        print("delete sucessfully");
        if(data['message'] != null) {
          print(data['message'].toString());
          showInToast(context, '${data['message']}');
        }
        if(data['error'] != null){
          showInToast(context,'${data['error']}');
        }

        return response;

      }
      else{
        throw Exception("Can't delete ");
      }
    }catch(e){
      print(e);
    }
  }

  //Product item delete...
  static Future<dynamic> deleteOrderItem(BuildContext context,int id,bool onProgress)async{
    try{
      onProgress = true;
      print(id.toString());
      String url = "$uri/api/admin/order/$id/delete";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.delete(
          myUri,headers: await getHeaderWithToken()
      );
      final data = jsonDecode(response.body);
      print(data.toString());
      print(response.statusCode);
      if(response.statusCode==200){
        print(data);
        print("delete sucessfully");
        print(data['message'].toString());
        onProgress = false;
        showInToast(context,'${data['message']}');
        return response;

      }
      else{
        onProgress = false;
        throw Exception("Can't delete ");
      }
    }catch(e){
      onProgress = false;
      print(e);
    }
  }
  //Admin delete...
  static Future<dynamic> deleteAdmin(BuildContext context,int id)async{
    try{
      print(id.toString());
      String url = "$uri/api/admin/delete/$id";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.delete(
          myUri,headers: await getHeaderWithToken()
      );
      final data = jsonDecode(response.body);
      //showInToast(context,'${data['message']}');
      print(data.toString());
      print(response.statusCode);
      if(response.statusCode==200){
        print(data);
        print("delete sucessfully");
        if(data['message'] != null) {
          print('here');
          print(data['message']);
          showInToast(context, '${data['message']}');
        }
        if(data['error'] != null){
          print('here also');
          print(data['error']);
          showInToast(context, data['error']);
        }
        return response;

      }
      else{
        throw Exception("Can't delete ");
      }
    }catch(e){
      print(e);
    }
  }
  static showInToast(BuildContext context,String value) {
    Fluttertoast.showToast(
        msg: "$value",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: aPrimaryColor,
        textColor: aNavBarColor,
        fontSize: 16.0);
  }

  //provider
  static Future<Category> getCategoryEditId(context,int id) async {
    Category category;
    try {
      String url = "$uri/api/admin/category/$id/edit/";
      Uri myUri = Uri.parse(url);
      var response = await http.get(
          myUri, headers: await CustomHttpRequest.getHeaderWithToken()
      );
        print(response.statusCode);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print(item);
        category = Category.fromJson(item);
        print(category);
      } else {
        print('Data not found');

      }
    } catch (e) {
      print(e);
    }
    return category;

  }

  //provider
  static Future<Products> getProductEditId(context,int id) async {
    Products products;
    try {
      String url = "$uri/api/admin/product/$id/edit/";
      Uri myUri = Uri.parse(url);
      var response = await http.get(
          myUri, headers: await CustomHttpRequest.getHeaderWithToken()
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print(item);
        products = Products.fromJson(item);
      } else {
        print('Data not found');

      }
    } catch (e) {
      print(e);
    }
    return products;

  }

  //provider
  static Future<Order> getOrderWithId(context,int id) async {
    Order order;
    try {
      String url = "$uri/api/admin/order/$id/invoice";
      Uri myUri = Uri.parse(url);
      var response = await http.get(
          myUri, headers: await CustomHttpRequest.getHeaderWithToken()
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print(item);
        print('data found');
        order = Order.fromJson(item);
        print(order);
      } else {
        print('Data not found');

      }
    } catch (e) {
      print(e);
    }
    return order;

  }


}