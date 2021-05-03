import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Model/products_model.dart';
import 'package:home_chef_admin/Provider/products_provider.dart';
import 'package:home_chef_admin/Screens/editProduct_page.dart';
import 'package:home_chef_admin/Widgets/CustomSwitch.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class ProductSearchHere extends SearchDelegate<Products>{
  bool visible;
  bool available;
  bool onProgress = false;
  final List<Products> itemsList;
  ProductSearchHere({this.itemsList});

  Future<void> availabilityUpdate(BuildContext context,int id) async{
    onProgress =true;
    final uri = Uri.parse(
        "https://apihomechef.antapp.space/api/admin/product/update/available/status/$id");
    var request =
    http.MultipartRequest(
        "POST", uri);
    request.headers.addAll(
        await CustomHttpRequest
            .getHeaderWithToken());
    var response =
    await request.send();
    var responseData =
    await response.stream
        .toBytes();
    var responseString =
    String.fromCharCodes(
        responseData);
    print("responseBody " +
        responseString);
    print(
        'responseStatus ${response.statusCode}');
    if (response.statusCode ==
        200) {
      print("responseBody1 " +
          responseString);
      var data = jsonDecode(
          responseString);
      print('oooooooooooooooooooo');
      print(data['success']);
      showInToast(data['success']);
      onProgress = false;
    } else {
        onProgress = false;

    }
  }
  Future<void> visibilityUpdate(BuildContext context,int id) async{

      onProgress =true;
    final uri = Uri.parse(
        "https://apihomechef.antapp.space/api/admin/product/update/visible/status/$id");
    var request =
    http.MultipartRequest(
        "POST", uri);
    request.headers.addAll(
        await CustomHttpRequest
            .getHeaderWithToken());
    var response =
    await request.send();
    var responseData =
    await response.stream
        .toBytes();
    var responseString =
    String.fromCharCodes(
        responseData);
    print("responseBody " +
        responseString);
    print(
        'responseStatus ${response.statusCode}');
    if (response.statusCode ==
        200) {
      print("responseBody1 " +
          responseString);
      var data = jsonDecode(
          responseString);
      print('oooooooooooooooooooo');
      print(data['message']);
      showInToast(data['message']);
      onProgress = false;
    } else {
      onProgress = false;
    }
  }

  showInToast(String value){
    Fluttertoast.showToast(
        msg: "$value",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: aPrimaryColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
      close(context, null);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final myList = query.isEmpty? productsData.productsList :
    productsData.productsList.where((element) => element.name.toLowerCase().startsWith(query)).toList();
    return  myList.isEmpty ? Center(child: Text('No result found',style: TextStyle(fontSize: 18),))
        : ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: myList.length??'',
        itemBuilder: (context, index) {
          visible = myList[index].isVisible.toString() == '1'? true : myList[index].isVisible.toString() == '0'? false : false;
          available =  myList[index].isAvailable.toString() == '1'? true : myList[index].isAvailable.toString() == '0'? false : false;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white.withOpacity(0.8),
                          spreadRadius: -5,
                          offset: Offset(-1, -1),
                          blurRadius: 10),
                      BoxShadow(
                          color: aBlackCardColor,
                          spreadRadius: -5,
                          offset: Offset(1, 1),
                          blurRadius: 5),
                    ],
                    color: aNavBarColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://homechef.antapp.space/images/${myList[index].image ?? ""}"))),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${myList[index].foodItemCategory.isEmpty ? "Category not found": myList[index].foodItemCategory[0].name }',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: aTextColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    Text(
                                      '${myList[index].name ?? ""}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: aTextColor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '\৳${myList[index].price[0].discountedPrice ?? ""}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.w500,
                                              color: aPriceTextColor),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '\৳${myList[index].price[0].originalPrice ?? ""}',
                                          style: TextStyle(
                                              decoration:
                                              TextDecoration
                                                  .lineThrough,
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.w400,
                                              color: aTextColor
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: aTextColor.withOpacity(0.3),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Visibility',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight:
                                            FontWeight.w500,
                                            color: aTextColor,
                                          ),
                                        ),
                                        Spacer(),
                                        MCustomSwitch(
                                          value: visible,
                                          activeColor: aTextColor,
                                          activeTogolColor: aPrimaryColor,
                                          onChanged: (value) async {
                                            print("default : $visible");
                                            visible = !visible;
                                            onProgress = false;
                                            print("$visible");
                                            int productId = myList[index].id;

                                            visibilityUpdate(context, productId).then((value) => productsData.getProducts(context,onProgress),);

                                          },
                                        ),
                                        SizedBox(width: 10,)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Availability',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight:
                                            FontWeight.w500,
                                            color: aTextColor,
                                          ),
                                        ),
                                        Spacer(),
                                        MCustomSwitch(
                                          value: available,
                                          activeColor: aTextColor,
                                          activeTogolColor: aPrimaryColor,
                                          onChanged: (value) async {
                                            print("default : $available");
                                              available = !available;
                                              onProgress = false;
                                            print("$available");
                                            int productId = myList[index].id;

                                            availabilityUpdate(context, productId).then((value) => productsData.getProducts(context,onProgress),);

                                          },
                                        ),
                                        SizedBox(width: 10,)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: PopupMenuButton<String>(
                    onSelected: (value) {
                      String choice = value;
                      if (choice == Constants.Edit) {
                        print('edit');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return EditProductPage(
                                id: myList[index].id,
                                categoryName: myList[index].foodItemCategory[0].name.toString(),
                                categoryId: myList[index].foodItemCategory[0].id,
                              );
                            })).then((value) => productsData.getProducts(context,onProgress));
                      } else if (choice == Constants.Delete) {
                        print('delete');
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Are you sure ?'),
                                titleTextStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: aTextColor),
                                titlePadding: EdgeInsets.only(
                                    left: 35, top: 25),
                                content: Text(
                                    'Once you delete, the item will gone permanently.'),
                                contentTextStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: aTextColor),
                                contentPadding: EdgeInsets.only(
                                    left: 35, top: 10, right: 40),
                                actions: <Widget>[
                                  TextButton(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                              color: aTextColor,
                                              width: 0.2)),
                                      child: Text(
                                        'CANCEL',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight:
                                            FontWeight.w500,
                                            color: aTextColor),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent
                                            .withOpacity(0.2),
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight:
                                            FontWeight.w500,
                                            color: aPriceTextColor),
                                      ),
                                    ),
                                    onPressed: () async {
                                      CustomHttpRequest
                                          .deleteProductItem(
                                          context,
                                          myList[
                                          index]
                                              .id)
                                          .then((value) {
                                        productsData.getProducts(context,onProgress);
                                        print('api call');
                                      });
                                      print('api call');
                                      //productsData.getProducts(context,onProgress);
                                        productsData.productsList
                                            .removeAt(index);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    itemBuilder: (context) {
                      return Constants.choices.map((String e) {
                        return PopupMenuItem<String>(
                            value: e, child: Text(e));
                      }).toList();
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final myList = query.isEmpty? productsData.productsList :
    productsData.productsList.where((element) => element.name.toLowerCase().startsWith(query)).toList();
    return myList.isEmpty ? Center(child: Text('No result found',style: TextStyle(fontSize: 18),))
        :  ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: myList.length??'',
        itemBuilder: (context, index) {
          visible = myList[index].isVisible.toString() == '1'? true : myList[index].isVisible.toString() == '0'? false : false;
          available =  myList[index].isAvailable.toString() == '1'? true : myList[index].isAvailable.toString() == '0'? false : false;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white.withOpacity(0.8),
                          spreadRadius: -5,
                          offset: Offset(-1, -1),
                          blurRadius: 10),
                      BoxShadow(
                          color: aBlackCardColor,
                          spreadRadius: -5,
                          offset: Offset(1, 1),
                          blurRadius: 5),
                    ],
                    color: aNavBarColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://homechef.antapp.space/images/${myList[index].image ?? ""}"))),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${myList[index].foodItemCategory.isEmpty ? "Category not found": myList[index].foodItemCategory[0].name }',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: aTextColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    Text(
                                      '${myList[index].name ?? ""}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: aTextColor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '\৳${myList[index].price[0].discountedPrice ?? ""}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.w500,
                                              color: aPriceTextColor),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '\৳${myList[index].price[0].originalPrice ?? ""}',
                                          style: TextStyle(
                                              decoration:
                                              TextDecoration
                                                  .lineThrough,
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.w400,
                                              color: aTextColor
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: aTextColor.withOpacity(0.3),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Visibility',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight:
                                            FontWeight.w500,
                                            color: aTextColor,
                                          ),
                                        ),
                                        Spacer(),
                                        MCustomSwitch(
                                          value: visible,
                                          activeColor: aTextColor,
                                          activeTogolColor: aPrimaryColor,
                                          onChanged: (value) async {
                                            print("default : $visible");
                                            visible = !visible;
                                            onProgress = false;
                                            print("$visible");
                                            int productId = myList[index].id;

                                            visibilityUpdate(context, productId).then((value) => productsData.getProducts(context,onProgress),);

                                          },
                                        ),
                                        SizedBox(width: 10,)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Availability',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight:
                                            FontWeight.w500,
                                            color: aTextColor,
                                          ),
                                        ),
                                        Spacer(),
                                        MCustomSwitch(
                                          value: available,
                                          activeColor: aTextColor,
                                          activeTogolColor: aPrimaryColor,
                                          onChanged: (value) async {
                                            print("default : $available");
                                            available = !available;
                                            onProgress = false;
                                            print("$available");
                                            int productId = myList[index].id;

                                            availabilityUpdate(context, productId).then((value) => productsData.getProducts(context,onProgress),);

                                          },
                                        ),
                                        SizedBox(width: 10,)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: PopupMenuButton<String>(
                    onSelected: (value) {
                      String choice = value;
                      if (choice == Constants.Edit) {
                        print('edit');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return EditProductPage(
                                id: myList[index].id,
                                categoryName: myList[index].foodItemCategory[0].name.toString(),
                                categoryId: myList[index].foodItemCategory[0].id,
                              );
                            })).then((value) => productsData.getProducts(context,onProgress));
                      } else if (choice == Constants.Delete) {
                        print('delete');
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Are you sure ?'),
                                titleTextStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: aTextColor),
                                titlePadding: EdgeInsets.only(
                                    left: 35, top: 25),
                                content: Text(
                                    'Once you delete, the item will gone permanently.'),
                                contentTextStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: aTextColor),
                                contentPadding: EdgeInsets.only(
                                    left: 35, top: 10, right: 40),
                                actions: <Widget>[
                                  TextButton(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                              color: aTextColor,
                                              width: 0.2)),
                                      child: Text(
                                        'CANCEL',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight:
                                            FontWeight.w500,
                                            color: aTextColor),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent
                                            .withOpacity(0.2),
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight:
                                            FontWeight.w500,
                                            color: aPriceTextColor),
                                      ),
                                    ),
                                    onPressed: () async {
                                      CustomHttpRequest
                                          .deleteProductItem(
                                          context,
                                          myList[
                                          index]
                                              .id)
                                          .then((value) => value);
                                      productsData.productsList
                                          .removeAt(index);
                                      productsData.getProducts(context,onProgress);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    itemBuilder: (context) {
                      return Constants.choices.map((String e) {
                        return PopupMenuItem<String>(
                            value: e, child: Text(e));
                      }).toList();
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

}