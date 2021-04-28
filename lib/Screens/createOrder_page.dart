import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Widgets/productTextField.dart';
import 'package:home_chef_admin/Widgets/registerTextField.dart';
import 'package:home_chef_admin/server/http_request.dart';

class CreateOrderPage extends StatefulWidget {
  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage>
    with TickerProviderStateMixin {
  final titleController = TextEditingController();

  List<Map<String, dynamic>> myList = [];

  /*void deleteTransaction(int id) {
    setState(() {
      myList.removeAt(index)
    });
  }*/
  void submitData(BuildContext context) {
    print(myList);
    if (quantityController.text.isEmpty) {
      print(" cancle first");
      return;
    } else {
      print("inside decission");
      if (myList.isNotEmpty) {
        print("not empty list:????");
        for (var i = 0; i < myList.length; i++) {
          if (quantityController.text.isNotEmpty) {
            if (myList[i]['"quantity"'] == quantityController.text) {
              print("here found matching product");
              return showInToast(" product already added");
            } else {
              print("here not found matching product, so added");
              myList.add(
                {
                  '"product_id"': 10,
                  '"product_name"': 'Burger',
                  '"quantity"': quantityController.text,
                  '"price"': 250,
                },
              );
              quantityController.text = '';
              animate();
              print("added done");
              showInToast("Product Added Successfully");
              print(myList);
              return;
            }
          } else {
            return;
          }
        }
      } else {
        print('not any more empty:????');
        myList.add(
          {
            '"product_id"': 10,
            '"product_name"': 'Burger',
            '"quantity"': quantityController.text,
            '"price"': 250,
          },
        );
        animate();
        quantityController.text = '';
        showInToast("Product Added Successfully");
        print(myList);
        return;
      }
    }
  }

  showInToast(String value) {
    Fluttertoast.showToast(
        msg: "$value",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: aPrimaryColor,
        textColor: aNavBarColor,
        fontSize: 16.0);
  }

  bool newUser = false;
  bool oldUser = true;

  bool _obscureText = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  //Shipping Address..

  TextEditingController contactController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController roadController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districController = TextEditingController();
  TextEditingController appertmentController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  String categoryType;

  List categoryList;

  Future<dynamic> getCategory() async {
    await CustomHttpRequest.getCategoriesDropDown().then((responce) {
      var dataa = json.decode(responce.body);
      setState(() {
        categoryList = dataa;
        print("all categories are : $categoryList");
      });
    });
  }

  //Animation

  AnimationController _controller;
  Animation<double> _animation;

  void animate() {
    _controller.forward();

    // animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.stop();
      }
    });
  }

  @override
  void initState() {
    //getCategory();
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    print('hi');
    _animation = Tween<double>(begin: 0.5, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    print(_animation.value);

    print(_animation.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: aBackgroundColor,
      appBar: AppBar(
        backgroundColor: aNavBarColor,
        elevation: 0,
        title: Text('Create new order'),
      ),
      body: RawScrollbar(
        thumbColor: aPrimaryColor,
        isAlwaysShown: true,
        thickness: 3.0,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: aNavBarColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Visibility(
                            visible: oldUser,
                            child: Text(
                              'User',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: oldUser,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            decoration: BoxDecoration(
                                color: aSearchFieldColor,
                                border:
                                    Border.all(color: Colors.grey, width: 0.2),
                                borderRadius: BorderRadius.circular(10.0)),
                            height: 60,
                            child: Center(
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 30,
                                ),
                                decoration:
                                    InputDecoration.collapsed(hintText: ''),
                                value: categoryType,
                                hint: Text(
                                  'Select User',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: aTextColor, fontSize: 16),
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    categoryType = newValue;
                                    print("my Category is $categoryType");
                                    if (categoryType.isEmpty) {
                                      return "Required";
                                    }
                                    // print();
                                  });
                                },
                                validator: (value) =>
                                    value == null ? 'field required' : null,
                                items: categoryList?.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(
                                          "${item['name']}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: aTextColor,
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        value: item['id'].toString(),
                                      );
                                    })?.toList() ??
                                    [],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              newUser = !newUser;
                              oldUser = !newUser;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: newUser ? aTextColor : aNavBarColor,
                                    border: Border.all(color: aTextColor),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Center(
                                      child: Icon(
                                    Icons.check,
                                    size: 15,
                                    color: aNavBarColor,
                                  )),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Create new user',
                                  style: TextStyle(
                                    color:
                                        newUser ? aTextColor : Colors.black45,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: newUser,
                          child: Container(
                            color: aNavBarColor,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RegiTextField(
                                  name: 'Name',
                                  hint: 'Enter name',
                                  controller: nameController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*username required";
                                    }
                                    if (value.length < 3) {
                                      return "*username is too short,write minimum 3 letter";
                                    } else if (value.length > 20) {
                                      return "*user name is long";
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                RegiTextField(
                                  name: 'Email',
                                  hint: 'Enter email address',
                                  controller: emailController,
                                  keytype: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*Email is empty";
                                    }
                                    if (!value.contains('@')) {
                                      return "*wrong email address";
                                    } else if (!value.contains('.')) {
                                      return "*wrong email address";
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Password',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*Password is empty";
                                    }
                                    if (value.length < 6) {
                                      return "*Password contants more then 6 carecters";
                                    }
                                    if (value.length > 20) {
                                      return "*Password not contains more then 10 carecters";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      gapPadding: 5.0,
                                      borderSide: BorderSide(
                                          color: aPrimaryColor, width: 2.5),
                                    ),
                                    hintText: 'Enter Password',
                                    hintStyle: TextStyle(fontSize: 14),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      child: Icon(_obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    ),
                                  ),
                                  obscureText: _obscureText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: aNavBarColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Product',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Stack(
                              overflow: Overflow.visible,
                              children: [
                                Container(

                                  child: IconButton(
                                    onPressed: (){

                                    },
                                    icon: Icon(
                                      Icons.shopping_cart,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            changeQuantity(
                                                int index, String type) {
                                              int quantity = int.parse(
                                                  myList[index]['"quantity"']);
                                              print(quantity);
                                              if (type == 'DEC' &&
                                                  quantity == 1) return 0;
                                              quantity = type == 'INC'
                                                  ? quantity + 1
                                                  : quantity - 1;
                                              setState(() {
                                                myList[index]['"quantity"'] =
                                                    quantity.toString();
                                              });
                                              print('1st =$quantity');
                                            }

                                            return Dialog(
                                              child: StatefulBuilder(
                                                builder: (BuildContext context,
                                                    StateSetter setState) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      border: Border.all(
                                                          color: aPrimaryColor,
                                                          width: 1),
                                                    ),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.6,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        //border: Border.all(color: aTextColor,width: 0.2)
                                                                        ),
                                                                child: Center(
                                                                  child: Text(
                                                                      'Selected Products',
                                                                      style: GoogleFonts
                                                                          .roboto(
                                                                        textStyle: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: aTextColor),
                                                                      )),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                  right: 0,
                                                                  top: 0,
                                                                  child:
                                                                      IconButton(
                                                                    icon: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      size: 16,
                                                                      color: Colors
                                                                          .red
                                                                          .withOpacity(
                                                                              0.9),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        myList
                                                                            .clear();
                                                                        showInToast(
                                                                            'All product cleared');
                                                                      });
                                                                    },
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Expanded(
                                                          flex: 8,
                                                          child: myList
                                                                  .isNotEmpty
                                                              ? RawScrollbar(
                                                                  thumbColor:
                                                                      aPrimaryColor,
                                                                  isAlwaysShown:
                                                                      true,
                                                                  thickness:
                                                                      3.0,
                                                                  child: ListView
                                                                      .builder(
                                                                    itemCount:
                                                                        myList
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return Card(
                                                                        elevation:
                                                                            0.2,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Column(
                                                                                children: [
                                                                                  Text(
                                                                                    "${myList[index]['"product_name"']}",
                                                                                    style: GoogleFonts.roboto(color: aTextColor, textStyle: TextStyle(fontWeight: FontWeight.w600)),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Container(
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), border: Border.all(color: aTextColor.withOpacity(0.2))),
                                                                                    child: Row(
                                                                                      children: [
                                                                                        IconButton(
                                                                                            icon: Icon(Icons.minimize),
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                changeQuantity(index, "DEC");
                                                                                              });
                                                                                            }),
                                                                                        Text("${myList[index]['"quantity"']}"),
                                                                                        IconButton(
                                                                                            icon: Icon(Icons.add),
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                changeQuantity(index, "INC");
                                                                                              });
                                                                                            }),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Spacer(),
                                                                              Column(
                                                                                children: [
                                                                                  IconButton(
                                                                                      icon: Icon(
                                                                                        Icons.delete_rounded,
                                                                                        color: aPriceTextColor.withOpacity(0.5),
                                                                                      ),
                                                                                      onPressed: () {
                                                                                        print('delete click');
                                                                                        setState(() {
                                                                                          myList.removeAt(index);
                                                                                        });
                                                                                        showInToast('Product delete');
                                                                                        submitData(context);
                                                                                      }),
                                                                                  Text("\$${(myList[index]['"price"']) * int.parse(myList[index]['"quantity"'])}"),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                )
                                                              : Center(
                                                                  child: Text(
                                                                    'Products not added',
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          aPriceTextColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Center(
                                                            child: Container(
                                                              width: 100,
                                                              child:
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "Ok")),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          }).then((value) {
                                        setState(() {
                                          submitData(context);
                                        });
                                      });
                                    },
                                    child: ScaleTransition(
                                      scale: _animation,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${myList.length}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        decoration: BoxDecoration(
                            color: aSearchFieldColor,
                            border: Border.all(color: Colors.grey, width: 0.2),
                            borderRadius: BorderRadius.circular(10.0)),
                        height: 60,
                        child: Center(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 30,
                            ),
                            decoration: InputDecoration.collapsed(hintText: ''),
                            value: categoryType,
                            hint: Text(
                              'Select Product',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: aTextColor, fontSize: 16),
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                categoryType = newValue;
                                print("my Category is $categoryType");
                                if (categoryType.isEmpty) {
                                  return "Required";
                                }
                                // print();
                              });
                            },
                            validator: (value) =>
                                value == null ? 'field required' : null,
                            items: categoryList?.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(
                                      "${item['name']}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: aTextColor,
                                          fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    value: item['id'].toString(),
                                  );
                                })?.toList() ??
                                [],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ProductTextField(
                              name: 'Quantity',
                              hint: 'Enter quantity',
                              controller: quantityController,
                              keytype: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "*How much product you have";
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Price",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        color: aTextColor, width: 0.5)),
                                child: Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 16, color: aTextColor),
                                ),
                              )
                            ],
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            print("click");
                            setState(() {
                              submitData(context);

                              ///..Animation call
                            });
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: aTextColor,
                            ),
                            child: Center(
                              child: Text(
                                'add',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ),
                        ),
                      ),
                      /*TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                List<ProductOrders> products = [];
                                // ProductOrders product;
                                // products = myList.map((e) => product);
                                //myList.firstWhere((element) => element == product.productId);
                                //myList.map((e) => product);
                                return Dialog(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    child: ListView.builder(
                                        itemCount: myList.length,
                                        itemBuilder: (context, index) {

                                          //myList.forEach((element) {})
                                          return ListTile(
                                            title: Text("${myList}"),
                                          );
                                        }),
                                  ),
                                );
                              });
                        },
                        child: Text(
                          'selected products',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),*/
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: aNavBarColor,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        'Shipping Address',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RegiTextField(
                        name: 'Contact Number',
                        hint: '018..',
                        controller: contactController,
                        keytype: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: RegiTextField(
                            name: 'Appartment',
                            hint: 'your appartment',
                            controller: appertmentController,
                          )),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: RegiTextField(
                            name: 'Zip-code',
                            hint: '125-10',
                            controller: zipController,
                            keytype: TextInputType.number,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: RegiTextField(
                            name: 'House',
                            hint: '53/A',
                            controller: houseController,
                          )),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: RegiTextField(
                            name: 'Road',
                            hint: '15',
                            controller: roadController,
                          )),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: RegiTextField(
                            name: 'Area',
                            hint: 'Sector-5',
                            controller: areaController,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RegiTextField(
                              name: 'City',
                              hint: 'your city',
                              controller: cityController,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: RegiTextField(
                              name: 'District',
                              hint: 'your district',
                              controller: districController,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  color: aBackgroundColor,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.black,
                      border: Border.all(color: aTextColor, width: 0.5),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          'Publish Product',
                          style: TextStyle(
                              color: aPrimaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
class OrderLine{
  String name;
  String price;
  String qty;

  OrderLine.fromElement(Element element){
    //number = element.childNodes[0].value;
    /// ...
    name = element.
  }}

for(Element element in elements){
orderLines.add(new OrderLine.fromElement(element.childNodes[i]));
}
*/
