import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Widgets/productTextField.dart';
import 'package:home_chef_admin/Widgets/registerTextField.dart';
import 'package:home_chef_admin/server/http_request.dart';
class CreateOrderPage extends StatefulWidget {
  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {

 List<Map<String,Object>>productList;
  final titleController = TextEditingController();

  void SubmitData (){
    if(titleController.text.isEmpty)
      return;
    else{
      productList.add({'quantity':titleController.text,
        'name': 'sokina',
        'price': 250.3,
      });
      titleController.text = '';
      print(productList);
    }




    print(productList);
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
  @override
  void initState() {
    getCategory();
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
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
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
                          visible: oldUser ,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
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
                                  'Select User',
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
                        ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        newUser = !newUser;
                        oldUser = !newUser;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: newUser
                                  ? aTextColor
                                  : aNavBarColor,
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
                              color: newUser
                                  ? aTextColor
                                  : Colors.black45,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                        SizedBox(height: 10,),
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
                                  validator: ( value) {
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
                                SizedBox(height: 10,),
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
                                      borderSide:
                                      BorderSide(color: aPrimaryColor, width: 2.5),
                                    ),
                                    hintText: 'Enter Password',
                                    hintStyle: TextStyle(fontSize: 14),
                                    suffixIcon: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      child: Icon(
                                          _obscureText?
                                          Icons.visibility_off: Icons.visibility),
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
                SizedBox(height: 20,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  color: aNavBarColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Product',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
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

                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: ProductTextField(
                              name: 'Quantity',
                              hint: 'Enter quantity',
                              controller: titleController,

                              validator: (value){
                                if(value.isEmpty){
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
                                        border:
                                        Border.all(color: aTextColor, width: 0.5)),
                                    child: Text(
                                      '',
                                      style: TextStyle(fontSize: 16, color: aTextColor),
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                      TextButton(onPressed: (){
                        SubmitData();
                      },
                          child: Text('add') )
                    ],
                  ),
                ),

                SizedBox(height: 20,),
                 Container(
                  color: aNavBarColor,
                  padding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 20),
                  child: Column(
                    children: [
                      Text('Shipping Address',style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),),
                      SizedBox(height: 10,),
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
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
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
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
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
                SizedBox(height: 10,),
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
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
