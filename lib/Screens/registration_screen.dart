import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Screens/login_page.dart';
import 'package:home_chef_admin/Widgets/registerTextField.dart';
import 'package:home_chef_admin/Widgets/spin.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  String username, useremail, userpassword, userconfirmpass;
  final picker = ImagePicker();
  File image = null;
  bool _obscureText = true;
  bool _conobscureText = true;
  bool onProgress = false;

  // _cropImage(pickedImage) async {
  //   final cropped = await ImageCropper.cropImage(
  //     androidUiSettings: AndroidUiSettings(
  //         lockAspectRatio: false,
  //         statusBarColor: hHighlightTextColor,
  //         toolbarColor: hHighlightTextColor,
  //         toolbarWidgetColor: kwhiteColor,
  //         toolbarTitle: 'Crop Image'),
  //     sourcePath: pickedImage.path,
  //       aspectRatioPresets: [
  //         CropAspectRatioPreset.original,
  //         CropAspectRatioPreset.ratio16x9,
  //         CropAspectRatioPreset.ratio4x3,
  //       ]
  //   );
  //   if(cropped != null){
  //     setState(() {
  //       _image = cropped;
  //     });
  //   }
  // }
  //
  // Future chooseGallery() async {
  //   // ignore: deprecated_member_use
  //   File pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     _cropImage(pickedImage);
  //   }
  //   Navigator.pop(context);
  // }
  //
  // Future chooseCamera() async {
  //   // ignore: deprecated_member_use
  //   File pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
  //   if (pickedImage != null) {
  //     _cropImage(pickedImage);
  //   }
  //   Navigator.pop(context);
  // }
  // Future getImage(BuildContext context) async{
  //   final image = await ImagePicker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     _image = image;
  //   });
  // }

  // picImage() async{
  //   final picImage = await picker.getImage(source: ImageSource.gallery);
  //   _image = File(picImage.path);
  //
  //   print('image get');
  // }

  //  selectImage(parentContext) {
  //   return showDialog(
  //       context: parentContext,
  //       builder: (context) {
  //         return SimpleDialog(
  //           title: Text(
  //             "Upload Image",
  //             style: TextStyle(),
  //           ),
  //           children: [
  //             SimpleDialogOption(
  //               child: Text("Image from Gallery"),
  //               onPressed: () {
  //                 print("Gallery");
  //                 chooseGallery();
  //                 // picImage();
  //               },
  //             ),
  //             SimpleDialogOption(
  //               child: Text("Image from Camera"),
  //               onPressed: () {
  //                 print("open camera");
  //                chooseCamera();
  //                //  getImage(parentContext);
  //               },
  //             ),
  //             SimpleDialogOption(
  //               child: Text("cancel"),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }
  Future getImageformGallery() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
      } else {
        print('no image found');
      }
    });
  }
  SharedPreferences sharedPreferences;
  String token;

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future getRegister(BuildContext context) async{
    sharedPreferences = await SharedPreferences.getInstance();
    print('creating 1');
    try{
      check().then((internet) async{
        if(internet != null && internet){
          print('creating');
          if(mounted){
            setState(() {
              onProgress = true;
            });
            var data;
            print('creating');

            final uri = Uri.parse("https://apihomechef.masudlearn.com/api/admin/create/new/admin");
            var request = http.MultipartRequest("POST",uri);
            request.headers.addAll(await CustomHttpRequest.getHeaderWithToken());
            request.fields['name'] = nameController.text.toString();
            request.fields['email'] = emailController.text.toString();
            request.fields['password'] = passwordController.text.toString();
            request.fields['password_confirmation'] = confirmPassController.text.toString();

            var response = await request.send();
            var responseData = await response.stream.toBytes();
            var responseString = String.fromCharCodes(responseData);
            print("responseBody " + responseString);
            data = jsonDecode(responseString);
            //var data = jsonDecode(responseString);
            //showInToast(data['errors'].toString());
            print(response.statusCode);
            //stay here
            if (response.statusCode == 201) {
              print("responseBody1 " + responseString);
              data = jsonDecode(responseString);
              //var data = jsonDecode(responseString);
              showInToast(data['message'].toString());

              print(data['message'].toString());
              //go to the login page

              Navigator.pop(context);


            }
            else{
              setState(() {
                onProgress = false;
              });
              showInToast(responseString);
              var errorr = jsonDecode(responseString.trim().toString());
              //showInToast("Registered Failed, please fill all the fields");
              print("Registered failed " + responseString);

            }
          }
        }else
          showInToast("No Internet Connection");
      });
    }catch(e){
      print("something went wrong $e");
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: ModalProgressHUD(
          inAsyncCall: onProgress,
          opacity: 0.2,
          progressIndicator: Spin(),
          child: Form(
            key: _formKey,
            child:  Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Create New account',
                      style: TextStyle(
                          fontSize: 22,
                          color: aBlackCardColor,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    /*Center(
                      child: Column(
                        children: [
                          Stack(children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50)),
                                border: Border.all(
                                    color: aPrimaryColor, width: 2.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: aBlackCardColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                    child: image == null
                                        ? IconButton(
                                      onPressed: () {
                                        // selectImage(context);
                                        getImageformGallery();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    )
                                        : CircleAvatar(
                                      backgroundImage: FileImage(image),
                                    )
                                  // : Image.file(
                                  //     image,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: -15,
                              top: -15,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    image = null;
                                  });
                                },
                                icon: image != null
                                    ? Icon(Icons.clear)
                                    : Icon(
                                  Icons.clear,
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Add your profile photo',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),*/
                    SizedBox(
                      height: 10,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 10),
                    //   child: Container(
                    //     child: TextFormField(
                    //       controller: name,
                    //       validator: (name) {
                    //         Pattern pattern =
                    //             r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                    //         RegExp regex = new RegExp(pattern);
                    //         if (!regex.hasMatch(name))
                    //           return 'Invalid username';
                    //         else
                    //           return null;
                    //       },
                    //       onSaved: (name) => _username = name,
                    //       textInputAction: TextInputAction.next,
                    //       decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10.0),
                    //           gapPadding: 5.0,
                    //           borderSide: BorderSide(
                    //               color: hHighlightTextColor, width: 2.5),
                    //         ),
                    //         hintText: 'Enter name',
                    //         hintStyle: TextStyle(fontSize: 14),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    RegiTextField(
                      name: 'Your name',
                      hint: 'Enter your name',
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
                      onSave: (String name) {
                        username = name;
                      },
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    RegiTextField(
                      name: 'Your email',
                      hint: 'Enter your email address',
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
                      onSave: (String email) {
                        useremail = email;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Text(
                      'Your password',
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
                        if (value.length < 3) {
                          return "*Password is too short";
                        }
                        if (value.length > 10) {
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
                        hintText: 'Enter your Password',
                        hintStyle: TextStyle(fontSize: 14),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                              _obscureText?
                              Icons.visibility: Icons.visibility_off),
                        ),
                      ),
                      obscureText: _obscureText,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Your Confirm password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: confirmPassController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Confirm Password required ";
                        }
                        if (passwordController.text !=
                            confirmPassController.text) {
                          return "Password do not match";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          gapPadding: 5.0,
                          borderSide:
                          BorderSide(color: aPrimaryColor, width: 2.5),
                        ),
                        hintText: 'Enter your Password',
                        hintStyle: TextStyle(fontSize: 14),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            setState(() {
                              _conobscureText = !_conobscureText;
                            });
                          },
                          child: Icon(
                              _conobscureText?
                              Icons.visibility: Icons.visibility_off),
                        ),
                      ),
                      obscureText: _conobscureText,
                    ),
                    // RegiTextField(
                    //   name: 'Confirm your password',
                    //   hint: 'Enter your password',
                    //   suffixIcon: Icon(
                    //     Icons.visibility,
                    //     size: 18,
                    //   ),
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return "*password doesn't match";
                    //     }
                    //     if (value < 3) {
                    //       return "*password doesn't match";
                    //     } else if (value > 10) {
                    //       return "*password doesn't match";
                    //     }
                    //   },
                    //   onSave: (pass) {
                    //     userconfirmpass = pass;
                    //   },
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: aBlackCardColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            getRegister(context);

                          }

                          print('clicked');
                        },
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    Row(
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Spacer(),
                        Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: aPrimaryColor, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                                child: Text(
                                  'Log In',
                                  style: TextStyle(color: aTextColor,fontSize: 14,fontWeight: FontWeight.w500),
                                )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
