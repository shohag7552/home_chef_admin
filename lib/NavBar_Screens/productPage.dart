import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Provider/products_provider.dart';
import 'package:home_chef_admin/Provider/profile_provider.dart';
import 'package:home_chef_admin/Screens/Profile_screen.dart';
import 'package:home_chef_admin/Screens/addProduct_screen.dart';
import 'package:home_chef_admin/Screens/editProduct_page.dart';
import 'package:home_chef_admin/Screens/searchProduct_screen.dart';
import 'package:home_chef_admin/Widgets/CustomSwitch.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool visible;
  bool available;
  bool onProgress = false;

  ScrollController _scrollController;
  bool showFav = true;


  Future<void> availabilityUpdate(BuildContext context,int id) async{
    setState(() {
      onProgress =true;
    });
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
      setState(() {
        onProgress = false;

      });
    } else {
      setState(() {
        onProgress = false;
      });
    }
  }
  Future<void> visibilityUpdate(BuildContext context,int id) async{
    setState(() {
      onProgress =true;
    });
    print(id);
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
    setState(() {
    onProgress = false;

    });
    } else {
    setState(() {
    onProgress = false;
    });
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
  void initState() {
    final productsData = Provider.of<ProductsProvider>(context, listen: false);
      productsData.getProducts(context,onProgress);
   // print('$onProgress');

    _scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<ProfileProvider>(context);
    final productsData = Provider.of<ProductsProvider>(context);

    return ModalProgressHUD(
      inAsyncCall: onProgress,
      opacity: 0.1,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        backgroundColor: aBackgroundColor,
        appBar: AppBar(
          backgroundColor: aNavBarColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/menu.svg"),
          ),
          title: Text('Product List'),
          actions: [
            /*Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProductPage())).then((value) => productsData.getProducts(context,onProgress));
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ),*/
            SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ProfilePage();
                }));
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  "${profileData.profile !=null ? profileData.profile.image != null ? "$profileImageUri/${profileData.profile.image }" : "https://yeureka.com/wp-content/uploads/2016/08/default.png" : ''}",),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        floatingActionButton: showFav ? FloatingActionButton(

        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddProductPage())).then((value) => productsData.getProducts(context,onProgress));
        },
        backgroundColor: aBlackCardColor,
        child: Icon(
          Icons.add,
          size: 30,
          color: aPrimaryColor,
        ),
        ) : null,
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: aSearchFieldColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextButton(
                      onPressed: (){
                        showSearch(context: context, delegate: ProductSearchHere(itemsList: productsData.productsList ));

                      },
                      child: Row(
                        children: [
                          Text(
                            'Search Products',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset(
                              'assets/search.svg',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              flex: 12,
              child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 10),
                child: productsData.productsList.isNotEmpty? NotificationListener<UserScrollNotification>(
                  onNotification: (notification){
                    setState(() {
                      if(notification.direction == ScrollDirection.forward){
                        showFav = true;
                      }
                      else if(notification.direction == ScrollDirection.reverse){
                        showFav = false;
                      }
                    });
                    return true;
                  },
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: _scrollController,
                      itemCount: productsData.productsList.length??'',
                      itemBuilder: (context, index) {
                        String productVisible = productsData.productsList[index].isVisible.toString();
                        String productAvailable = productsData.productsList[index].isAvailable.toString();
                        print('product name :  ${productsData.productsList[index].name}');
                        print('product Category id :  ${productsData.productsList[index].foodItemCategory[0].id}');
                        print('product Category Name:  ${productsData.productsList[index].foodItemCategory[0].name.toString()}');
                        print('product discount type:  ${productsData.productsList[index].price[0].discountType}');


                        visible = productVisible == '1'? true : productVisible == '0'? false : false;
                        available =  productAvailable == '1'? true : productAvailable == '0'? false : false;
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
                                                    "https://homechef.antapp.space/images/${productsData.productsList[index].image ?? ""}"))),
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
                                                    '${productsData.productsList[index].foodItemCategory.isEmpty ? "Category not found": productsData.productsList[index].foodItemCategory[0].name }',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      color: aTextColor
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${productsData.productsList[index].name ?? ""}',
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
                                                        '\৳${productsData.productsList[index].price[0].discountedPrice ?? ""}',
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
                                                        '\৳${productsData.productsList[index].price[0].originalPrice ?? ""}',
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
                                                          setState(() {
                                                            visible = !visible;
                                                            onProgress = false;
                                                          });
                                                          print("$visible");
                                                          int productId = productsData.productsList[index].id;

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
                                                          setState(() {
                                                            available = !available;
                                                            onProgress = false;
                                                          });
                                                          print("$available");
                                                          int productId = productsData.productsList[index].id;

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
                                      print('id  : ${productsData.productsList[index].id}');
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return EditProductPage(
                                          id: productsData.productsList[index].id,
                                          categoryName: productsData.productsList[index].foodItemCategory.isEmpty? null :productsData.productsList[index].foodItemCategory[0].name.toString(),
                                          //categoryName: productsData.productsList[index].foodItemCategory.isEmpty ? null : productsData.productsList[index].foodItemCategory[0].name ,
                                          categoryId: productsData.productsList[index].foodItemCategory.isEmpty ? null : productsData.productsList[index].foodItemCategory[0].id ,
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
                                                                productsData
                                                                    .productsList[
                                                                        index]
                                                                    .id)
                                                        .then((value) => productsData.getProducts(context,onProgress));
                                                    setState(() {
                                                      productsData.productsList
                                                          .removeAt(index);
                                                    });
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
                      }),
                ):Center(child: CircularProgressIndicator(),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
