import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String fildName;
  bool onProgress = false;

  File icon, image;
  final picker = ImagePicker();

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

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double weidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
        title: Text('Add new category'),
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Container(
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
                  onSaved: (name) {
                    fildName = name;
                  },
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
                          borderSide:
                              BorderSide(color: aTextColor, width: 2.5)),
                      hintText: 'Enter Category Name'),
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
                    DottedBorder(
                      color: aTextColor,
                      strokeWidth: 1,
                      dashPattern: [6],
                      child: Container(
                        height: height * 0.2,
                        width: weidth * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: icon == null
                            ? InkWell(
                          onTap: (){
                            getIconformGallery();
                          },
                              child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image,color: aTextColor.withOpacity(0.5),
                                        size: 40,),
                                      Text("UPLOAD",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: aTextColor.withOpacity(0.5)),),

                                    ],
                                  ),
                                ),
                            )
                            : Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(icon),
                                )),
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
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.black,
                            border:
                                Border.all(color: aNavBarColor, width: 1.5)),
                        child: TextButton(
                          onPressed: () {
                            print('click');
                            getIconformGallery();
                          },
                          child: Center(
                            child: Container(
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset("assets/image_logo.svg"),
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
                    DottedBorder(
                      color: aTextColor,
                      strokeWidth: 1,
                      dashPattern: [6],
                      child: Container(
                        height: height * 0.3,
                        width: weidth * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(5)),

                        ),
                        child:  image == null
                            ? InkWell(
                          onTap: (){
                            getImageformGallery();
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image,color: aTextColor.withOpacity(0.5),
                                  size: 40,),
                                Text("UPLOAD",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: aTextColor.withOpacity(0.5)),),

                              ],
                            ),
                          ),
                        )
                            : Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(image),
                              )),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.black,
                              border:
                                  Border.all(color: aNavBarColor, width: 1.5)),
                          child: Center(
                            child: Container(
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset("assets/image_logo.svg"),
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
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.black,
                      border: Border.all(color: aTextColor, width: 0.5),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // if (_formKey.currentState.validate()) {
                        //   _formKey.currentState.save();
                        //   //categoryUpdate(categoryData.category.id);
                        // }
                      },
                      child: Center(
                        child: Text(
                          'Publish Category',
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
        ),
      ),
    );
  }
}
