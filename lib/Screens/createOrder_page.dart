import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Widgets/productTextField.dart';
import 'package:home_chef_admin/Widgets/registerTextField.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:http/http.dart' as http;

class CreateOrderPage extends StatefulWidget {
  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _fullformKey = GlobalKey<FormState>();
  bool onProgress = false;

  // final titleController = TextEditingController();

  /*shipping_area, shipping_contact, shipping_appartment,
  shipping_house, shipping_road, shipping_city, shipping_district,
  shipping_zip_code, user_id(optional) , product_id, price,
   quantity, user_name, user_email, user_password, product[]*/

  //final array = [["product_id"=> "6", "quantity"=> "2", "price"=> "276"]];

  Future createOrder(BuildContext context) async{
    try{

      if(mounted){
        setState(() {
          onProgress = true;
        });
        var data;

        final uri = Uri.parse("https://apihomechef.antapp.space/api/admin/order/create");
        var request = http.MultipartRequest("POST",uri);
        request.headers.addAll(await CustomHttpRequest.getHeaderWithToken());
        request.fields['shipping_area'] = areaController.text.toString();
        request.fields['shipping_contact'] = contactController.text.toString();
        request.fields['shipping_appartment'] = appertmentController.text.toString();
        request.fields['shipping_house'] = houseController.text.toString();
        request.fields['shipping_road'] = roadController.text.toString();
        request.fields['shipping_city'] = cityController.text.toString();
        request.fields['shipping_district'] = districController.text.toString();
        request.fields['shipping_zip_code'] = zipController.text.toString();
        request.fields['product'] = myList.toString();
       // request.fields['product'] = [{product_id: 6,quantity: 2, price: 276},[product_id: 34, quantity: 2, price: 100]].toString();
        print(myList.toString());

        if(userId != null){
          request.fields['user_id'] = userId;

        }else{
          request.fields['user_name'] = nameController.text.toString();
          request.fields['user_email'] = emailController.text.toString();
          request.fields['user_password'] = passwordController.text.toString();

        }

        var response = await request.send();
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print("responseBody " + responseString);
        data = jsonDecode(responseString);
        print(data);
        //var data = jsonDecode(responseString);
        //showInToast(data['email'].toString());
        //stay here
        print(response.statusCode);
        // if (response.statusCode == 201) {
        //   print("responseBody1 " + responseString);
        //   data = jsonDecode(responseString);
        //   //var data = jsonDecode(responseString);
        //   showInToast(data['message'].toString());
        //
        //   //go to the login page
        //   Navigator.pop(context);
        //
        // }
        // else{
        //   showInToast(data['errors']['image'][0]);
        //   setState(() {
        //     onProgress = false;
        //   });
        //   var errorr = jsonDecode(responseString.trim().toString());
        //   //showInToast("Registered Failed, please fill all the fields");
        //   print("Registered failed " + responseString);
        //
        // }
      }
    }catch(e){
      print("something went wrong $e");
    }
  }

  int price;
  int totalPrice;
  String productId;
  String productName;

  List<Map<String, dynamic>> myList = [];

  void submitData(BuildContext context) {
    if (quantityController.text.isEmpty) {
      return;
    }
    else {
      print("inside decission");
             print("not empty list:????");
        /*myList.forEach((element) {
          print(element['"quantity"']);
          print('////');
          print(quantityController.text);
          if(element['"quantity"'] == quantityController.text){
            print("${element['"quantity"']} equal to ${quantityController.text}");
            return showInToast(" product already added");
          }
          else if(element['"quantity"'] != quantityController.text){
            print("${element['"quantity"']} not equal to ${quantityController.text}");
            myList.add(
                    {
                      '"product_id"': 10,
                      '"product_name"': 'Burger',
                      '"quantity"': quantityController.text,
                      '"price"': totalPrice,
                    },
                  );
            quantityController.text = '';
              totalPrice = null;
              animate();
              print("added done");
              showInToast("Product Added Successfully");
              print(myList);
            return;
          }
            // if (element['"quantity"'] == quantityController.text) {
            //   print("here found matching product");
            //   return showInToast(" product already added");
            // }
            // else {
            //   print("${quantityController.text} here not found matching product, so added");
            //   myList.add(
            //     {
            //       '"product_id"': 10,
            //       '"product_name"': 'Burger',
            //       '"quantity"': quantityController.text,
            //       '"price"': totalPrice,
            //     },
            //   );
            //   quantityController.text = '';
            //   totalPrice = null;
            //   animate();
            //   print("added done");
            //   showInToast("Product Added Successfully");
            //   print(myList);
            //   return;
            // }

        });*/
        int count = 0;
        for (var i = 0; i < myList.length; i++) {
          //print(quantityController.text);
          if (myList[i]['product_id'] == productId) {
            count = 1;
            showInToast('Already selected product');
            break;
          }
        }
            if(count == 0) {
              print(
                  "$productId here not found matching product, so added");
              myList.add(
                {
                  'product_id': productId,
                  //'"product_name"': productName,
                  'quantity': quantityController.text,
                  'price': totalPrice,
                },
              );
              quantityController.text = '';
              totalPrice = null;
              productId = null;
              price = null;
              animate();
              print("added done");
              showInToast("Product Added Successfully");
              print(myList);

            }


    }
  }

/*  void submitData(BuildContext context) {
    print(myList);
    if (quantityController.text.isEmpty) {
      print(" cancle first");
      return;
    } else {
      print("inside decission");
      if (myList.isNotEmpty) {
        print("not empty list:????");
        */
  /*myList.forEach((element) {
          print(element['"quantity"']);
          print('////');
          print(quantityController.text);
          if(element['"quantity"'] == quantityController.text){
            print("${element['"quantity"']} equal to ${quantityController.text}");
            return showInToast(" product already added");
          }
          else if(element['"quantity"'] != quantityController.text){
            print("${element['"quantity"']} not equal to ${quantityController.text}");
            myList.add(
                    {
                      '"product_id"': 10,
                      '"product_name"': 'Burger',
                      '"quantity"': quantityController.text,
                      '"price"': totalPrice,
                    },
                  );
            quantityController.text = '';
              totalPrice = null;
              animate();
              print("added done");
              showInToast("Product Added Successfully");
              print(myList);
            return;
          }
            // if (element['"quantity"'] == quantityController.text) {
            //   print("here found matching product");
            //   return showInToast(" product already added");
            // }
            // else {
            //   print("${quantityController.text} here not found matching product, so added");
            //   myList.add(
            //     {
            //       '"product_id"': 10,
            //       '"product_name"': 'Burger',
            //       '"quantity"': quantityController.text,
            //       '"price"': totalPrice,
            //     },
            //   );
            //   quantityController.text = '';
            //   totalPrice = null;
            //   animate();
            //   print("added done");
            //   showInToast("Product Added Successfully");
            //   print(myList);
            //   return;
            // }

        });*/
  /*
        for (var i = 0; i < myList.length; i++) {
          //print(quantityController.text);
          if (quantityController.text.isNotEmpty) {
            if (myList[i]['"quantity"'] == quantityController.text) {

              print(quantityController.text);
              print(myList[i]['"quantity"']);
              print("here found matching product");
              showInToast(" product already added");
              return;
            } else {
              print("${quantityController.text} here not found matching product, so added");
              myList.add(
                {
                  '"product_id"': 10,
                  '"product_name"': 'Burger',
                  '"quantity"': quantityController.text,
                  '"price"': totalPrice,
                },
              );
              quantityController.text = '';
              totalPrice = null;
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
            '"price"': totalPrice,
          },
        );
        animate();
        quantityController.text = '';
        totalPrice = null;
        showInToast("Product Added Successfully");
        print(myList);
        return;
      }
    }
  }*/

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

  String userId;

  List usersList;

  Future<dynamic> getUser() async {

    await CustomHttpRequest.getUsersDropDown().then((responce) {
      var dataa = json.decode(responce.body);
      setState(() {
        usersList = dataa;
        print("all categories are : $usersList");
      });
    });
  }



  List productsList;

  Future<dynamic> getProduct() async {
    await CustomHttpRequest.getProductDropDown().then((responce) {
      var data = json.decode(responce.body);
      setState(() {
        productsList = data;
        print("all categories are : $productsList");
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
    getUser();
    getProduct();
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
            child: Form(
              key: _fullformKey,
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
                                  value: userId,
                                  hint: Text(
                                    'Select User',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: aTextColor, fontSize: 16),
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      userId = newValue;
                                      print("my user id is $userId");
                                      if (userId.isEmpty) {
                                        return "Required";
                                      }
                                      // print();
                                    });
                                  },
                                  validator: (value) =>
                                      value == null ? 'field required' : null,
                                  items: usersList?.map((item) {
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
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
                                        onPressed: () {},
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
                                                      myList[index]
                                                          ['quantity']);
                                                  print(quantity);
                                                  if (type == 'DEC' &&
                                                      quantity == 1) return 0;
                                                  quantity = type == 'INC'
                                                      ? quantity + 1
                                                      : quantity - 1;
                                                  setState(() {
                                                    myList[index]['quantity'] =
                                                        quantity;
                                                  });
                                                  myList[index]['price'] =
                                                      price *
                                                          int.parse(myList[index]
                                                              ['quantity']);
                                                  print('1st =$quantity');
                                                }

                                                return Dialog(
                                                  child: StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter setState) {
                                                      return Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      5)),
                                                          border: Border.all(
                                                              color:
                                                                  aPrimaryColor,
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
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: aTextColor),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                      right: 0,
                                                                      top: 0,
                                                                      child:
                                                                          IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .close,
                                                                          size:
                                                                              20,
                                                                          color: Colors
                                                                              .red
                                                                              .withOpacity(0.9),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
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
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        "${myList[index]['product_name']}",
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
                                                                                                icon: SvgPicture.asset('assets/-.svg'),
                                                                                                onPressed: () {
                                                                                                  setState(() {
                                                                                                    changeQuantity(index, "DEC");
                                                                                                  });
                                                                                                }),
                                                                                            Text("${myList[index]['quantity']}"),
                                                                                            IconButton(
                                                                                                icon: SvgPicture.asset('assets/+.svg'),
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
                                                                                      // Text("\$${(myList[index]['"price"']) * int.parse(myList[index]['"quantity"'])}"),
                                                                                      Text("\$${myList[index]['price']}"),
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
                                                                            setState(
                                                                                () {
                                                                              myList.clear();
                                                                              showInToast('All product cleared');
                                                                            });
                                                                          },
                                                                          child: Text(
                                                                              "Clear All")),
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
                                value: productId,
                                hint: Text(
                                  'Select Product',
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      TextStyle(color: aTextColor, fontSize: 16),
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    productId = newValue;

                                    print("my product id is $productId");
                                    if (productId.isEmpty) {
                                      return "Required";
                                    }
                                    // print();
                                  });
                                },
                                validator: (value) =>
                                    value == null ? 'field required' : null,
                                items: productsList?.map((item) {

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
                                        //value: item['price'][0]['discounted_price'].toString(),
                                        onTap: (){
                                          price = item['price'][0]['discounted_price'];
                                          print('product price is $price');
                                          productName = item['name'];
                                          print('product name is $productName');
                                          // setState(() {
                                          //   totalPrice = price *
                                          //       int.parse(quantityController.text);
                                          // });
                                        },
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
                                  onChange: (value) {
                                    setState(() {
                                      totalPrice = price *
                                          int.parse(quantityController.text);
                                    });
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
                                      '${totalPrice != null ? totalPrice : ''}',
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
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  setState(() {
                                    submitData(context);
                                  });
                                }

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
                          validator: (value) {
                            if (value.isEmpty) {
                              return "*contact number required";
                            }

                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: RegiTextField(
                              name: 'Apartment',
                              hint: 'your apartment',
                              controller: appertmentController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*apartment required";
                                    }

                                  },
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
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*zip_code required";
                                    }

                                  },
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
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*house number required";
                                    }

                                  },
                            )),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: RegiTextField(
                              name: 'Road',
                              hint: '15',
                              controller: roadController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "* required";
                                    }

                                  },
                            )),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: RegiTextField(
                              name: 'Area',
                              hint: 'Sector-5',
                              controller: areaController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "*area required";
                                    }

                                  },
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
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "*city required";
                                  }

                                },
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
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "*district required";
                                  }

                                },
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
                        onPressed: () {
                          if (_fullformKey.currentState.validate()) {
                            _fullformKey.currentState.save();
                            createOrder(context);
                          }
                        },
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
