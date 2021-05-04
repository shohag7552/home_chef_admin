import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Provider/category_provider.dart';
import 'package:home_chef_admin/Widgets/spin.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CategoryEditPage extends StatefulWidget {
  final int id,index;
  final String name;

  CategoryEditPage({this.id,this.index,this.name});

  @override
  _CategoryEditPageState createState() => _CategoryEditPageState();
}

class _CategoryEditPageState extends State<CategoryEditPage> {

  TextEditingController nameController ;
  final _formKey = GlobalKey<FormState>();

  File icon, image;
  final picker = ImagePicker();
  String fildName;

  bool onProgress = false;

  Future getIconformGallery() async {
    print('on the way of gallery');
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        icon = File(pickedImage.path);
        print('image found');
        print('$icon');
      } else {
        print('no image found');
      }
    });
  }

  Future getImageformGallery() async {
    print('on the way of gallery');
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
        print('image found');
        print('$image');
      } else {
        print('no image found');
      }
    });
  }

  Future categoryUpdate(int id) async {
    setState(() {
      onProgress = true;
    });
    final uri =
    Uri.parse(
        "https://apihomechef.antapp.space/api/admin/category/$id/update");
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(await CustomHttpRequest.getHeaderWithToken(),

    );
    request.fields['name'] = nameController.text.toString();
    if (image != null) {
      var photo = await http.MultipartFile.fromPath('image', image.path);
      print('processing');
      request.files.add(photo);
    }
    if (icon != null) {
      var _icon = await http.MultipartFile.fromPath('icon', icon.path);
      print('processing');
      request.files.add(_icon);
    }
    var response = await request.send();
    print("${response.statusCode}");
    var data;
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      print("responseBody1 $responseData");
      var responseString = String.fromCharCodes(responseData);
      data = jsonDecode(responseString);
      print('oooooooooooooooooooo');
      print(data['message']);
      if (data['message']==null){
        showInToast(data["errors"]["image"][0]);
      }else {
        showInToast(data['message']);
        Navigator.pop(context);
        /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return CategoryPage();
        }));*/
      }
      //showInToast(data["errors"]);
      print("***************");
      print("${response.statusCode}");


      setState(() {
        onProgress = false;
      });
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
    }else{
      print('else call');
      showInToast(data["errors"]);
      setState(() {
        onProgress = false;
      });
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

  @override
  void initState() {
    //category with id...
    final categoryData = Provider.of<CategoryProvider>(context, listen: false);

    categoryData.getCategoryData(context, widget.id);
    nameController = TextEditingController(text: widget.name);



    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryData = Provider.of<CategoryProvider>(context);
    //final categories = Provider.of<CategoriesProvider>(context);
   // nameController.text = categoryData.category.name;

    final double height = MediaQuery
        .of(context)
        .size
        .height;
    final double weidth = MediaQuery
        .of(context)
        .size
        .width;



    return ModalProgressHUD(
      inAsyncCall: onProgress,
      opacity: 0.1,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        backgroundColor: aNavBarColor,
        appBar: AppBar(
          backgroundColor: aNavBarColor,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: aTextColor,
            ),
          ),
          title: Text('Edit category'),
          titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        body: categoryData.category != null
            ? Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category Name', style: editPageTextStyle),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: nameController,

                    /*onSaved: (name) {
                      fildName = name;
                    },*/
                    validator: (value) {
                      if (value.isEmpty) {
                        return "*Write Category Name";
                      }
                      if (value.length < 3) {
                        return "*Write more then three word";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            gapPadding: 5.0,
                            borderSide: BorderSide(
                                color: aTextColor, width: 2.5)),
                        hintText: 'Name..'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Category Icon', style: editPageTextStyle),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        height: height * 0.2,
                        width: weidth * 0.4,
                        decoration: BoxDecoration(
                          color: aPrimaryColor,
                          border: Border.all(color: aTextColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: icon == null
                                ?
                            NetworkImage(
                              "https://homechef.antapp.space/category/${categoryData
                                  .category.icon}",
                            )
                                : FileImage(icon),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -20,
                        left: weidth * 0.15,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(50)),
                              color: Colors.black,
                              border: Border.all(
                                  color: aNavBarColor, width: 1.5)),
                          child: TextButton(
                            onPressed: () {
                              print('click');
                              getIconformGallery();
                            },
                            child: Center(
                              child: Container(
                                height: 20,
                                width: 20,
                                child: SvgPicture.asset(
                                    "assets/image_logo.svg"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    '* 320x320 is the Recommended Size',
                    style: TextStyle(
                        color: Colors.black26,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Category Image', style: editPageTextStyle),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        height: height * 0.3,
                        width: weidth * 0.9,
                        decoration: BoxDecoration(
                          color: aPrimaryColor,
                          border: Border.all(color: aTextColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: image == null ?
                            NetworkImage(
                              "https://homechef.antapp.space/category/${categoryData
                                  .category.image}",
                            ) : FileImage(image),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -25,
                        left: weidth * 0.4,

                        child: TextButton(
                          onPressed: () {
                            getImageformGallery();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50)),
                                color: Colors.black,
                                border: Border.all(
                                    color: aNavBarColor, width: 1.5)),
                            child: Center(
                              child: Container(
                                height: 20,
                                width: 20,
                                child: SvgPicture.asset(
                                    "assets/image_logo.svg"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    '* 640x360 is the Recommended Size',
                    style: TextStyle(
                        color: Colors.black26,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                       /* Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(8)),
                              color: Colors.white,
                              border: Border.all(color: aTextColor, width: 0.5),
                            ),
                            child: TextButton(
                              onPressed: () {
                                CustomHttpRequest.deleteCategoryItem(context,widget.id);
                                setState(() {
                                  categories.categoriesList.removeAt(widget.index);
                                });
                                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryPage()));
                                Navigator.pop(context);
                              },
                              child: Center(

                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: aPriceTextColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),*/
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(8)),
                              color: Colors.black,
                              border: Border.all(color: aTextColor, width: 0.5),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  categoryUpdate(categoryData.category.id);
                                }
                              },
                              child: Center(
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                      color: aNavBarColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ) : Container(child: CircularProgressIndicator(),),
      ),
    );
  }
}
