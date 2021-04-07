import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Provider/products_provider.dart';
import 'package:home_chef_admin/Provider/profile_provider.dart';
import 'package:home_chef_admin/Screens/addProduct_screen.dart';
import 'package:home_chef_admin/Screens/editProduct_page.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool visible;
  bool available;

  bool _visibleSwitchCondition = false;
  int _visibleValue = 0;
  bool _availabilitySwitchCondition = false;
  int _availabilityValue = 0;

  void visibleSwitch(bool value) {
    if (_visibleSwitchCondition == false) {
      setState(() {
        _visibleSwitchCondition = true;
        _visibleValue = 1;
      });
      print("visibleValue");
      print("$_visibleSwitchCondition");
      print("$_visibleValue");
    } else {
      setState(() {
        _visibleSwitchCondition = false;
        _visibleValue = 0;
      });
      print("visibleValue");
      print("$_visibleSwitchCondition");
      print("$_visibleValue");
    }
  }

  void availabilitySwitch(bool value) {
    if (_availabilitySwitchCondition == false) {
      setState(() {
        _availabilitySwitchCondition = true;
        _availabilityValue = 1;
      });
      print("availabilityValue");
      print("$_availabilitySwitchCondition");
      print("$_availabilityValue");
    } else {
      setState(() {
        _availabilitySwitchCondition = false;
        _availabilityValue = 0;
      });
      print("availabilityValue");
      print("$_availabilitySwitchCondition");
      print("$_availabilityValue");
    }
  }

  @override
  void initState() {
    final productsData = Provider.of<ProductsProvider>(context, listen: false);
    productsData.getProducts(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<ProfileProvider>(context);
    final productsData = Provider.of<ProductsProvider>(context);

    return Scaffold(
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
          Padding(
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
                          builder: (context) => AddProductPage()));
                },
                child: Icon(Icons.add),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
                "https://homechef.masudlearn.com/avatar/${profileData.profile.image ?? ""}"),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: aSearchFieldColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Search Categories',
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
          SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 12,
            child: Container(
              // padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: productsData.productsList.length ?? 0,
                  itemBuilder: (context, index) {
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
                                    color: Colors.white.withOpacity(0.5),
                                    spreadRadius: 5,
                                    offset: Offset(-1, -1),
                                    blurRadius: 20),
                                BoxShadow(
                                    color: aBlackCardColor.withOpacity(0.8),
                                    spreadRadius: -4,
                                    offset: Offset(1, 1),
                                    blurRadius: 7),
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
                                                "https://homechef.masudlearn.com/images/${productsData.productsList[index].image ?? ""}"))),
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
                                                '${productsData.productsList[index].foodItemCategory[0].name ?? ""}',
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
                                                    '\$${productsData.productsList[index].price[0].discountedPrice ?? ""}',
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
                                                    '\$${productsData.productsList[index].price[0].originalPrice ?? ""}',
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
                                                MainAxisAlignment.center,
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
                                                 /* CustomSwitch(
                                                    value: productsData
                                                                .productsList[
                                                                    index]
                                                                .isAvailable ==
                                                            "1"
                                                        ? visible = true
                                                        : productsData
                                                                    .productsList[
                                                                        index]
                                                                    .isAvailable ==
                                                                "0"
                                                            ? visible = false
                                                            : visible = false,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        visible = !visible;
                                                        *//*productsData.productsList[index].isAvailable="1";
                                                       print(" mehadi chela ${chela}");*//*
                                                      });
                                                    },
                                                  )*/
                                                  Switch(
                                                    value: productsData
                                                        .productsList[
                                                    index]
                                                        .isVisible ==
                                                        "1"
                                                        ? visible = true
                                                        : productsData
                                                        .productsList[
                                                    index]
                                                        .isAvailable ==
                                                        "0"
                                                        ? visible = false
                                                        : visible = false,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        visible = !visible;
                                                        /*productsData.productsList[index].isAvailable="1";
                                                       print(" mehadi chela ${chela}");*/
                                                      });
                                                    },
                                                    activeColor: aPrimaryColor,
                                                    activeTrackColor:
                                                    aTextColor,
                                                  ),
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
                                                  Switch(
                                                    value: productsData
                                                                .productsList[
                                                                    index]
                                                                .isAvailable ==
                                                            "1"
                                                        ? available = true
                                                        : productsData
                                                                    .productsList[
                                                                        index]
                                                                    .isAvailable ==
                                                                "0"
                                                            ? available = false
                                                            : available = false,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        available = !available;
                                                        /*productsData.productsList[index].isAvailable="1";
                                                       print(" mehadi chela ${chela}");*/
                                                      });
                                                    },
                                                    activeColor: aPrimaryColor,
                                                    activeTrackColor:
                                                        aTextColor,
                                                  ),
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
                                      id: productsData.productsList[index].id,
                                    );
                                  }));
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
                                                    .then((value) => value);
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
            ),
          ),
        ],
      ),
    );
  }
// void choiceAction({String choice, int id}){
//   if(choice == Constants.Edit){
//     print('Edit');
//   }else if(choice == Constants.Delete){
//     print('Delete');
//     CustomHttpRequest.deleteProductItem(context, )
//   }
// }
}
