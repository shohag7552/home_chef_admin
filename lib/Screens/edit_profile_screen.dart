import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Provider/profile_provider.dart';
import 'package:home_chef_admin/Widgets/registerTextField.dart';
import 'package:home_chef_admin/Widgets/spin.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();
  File image = null;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController roadController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController appartmentController = TextEditingController();

  String name, email, contact, house, road, area, city, district;

  fetchProfile(){

  }



  bool onProgress = false;

  Future profileUpdate(ProfileProvider profileData) async {
    // if (isShipping == true) {
    setState(() {
      onProgress = true;
    });
    final uri =
    Uri.parse("https://apihomechef.antapp.space/api/admin/update/profile");
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(await CustomHttpRequest.getHeaderWithToken());
    request.fields['name'] = nameController.text.toString();

    request.fields['email'] = emailController.text.toString();
    request.fields['contact'] = contactController.text.toString();
    request.fields['house'] = houseController.text.toString();
    request.fields['road'] = roadController.text.toString();
    request.fields['area'] = areaController.text.toString();
    request.fields['city'] = cityController.text.toString();
    request.fields['district'] = district.toString();
    //request.fields['district'] = district.toString();
    request.fields['appartment'] = appartmentController.text.toString();
    request.fields['zip_code'] = zipController.text.toString();
    print(request.fields);
    if(image != null){
      var photo = await http.MultipartFile.fromPath('image', image.path);
      print('processing');
      print(profileData.profile.image);
      request.files.add(photo);
    }

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print("responseBody " + responseString);
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //   return MainPage();
    // }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("responseBody1 " + responseString);
      var data = jsonDecode(responseString);
      print('oooooooooooooooooooo');
      print("My image type is : ${profileData.profile.image}");
      print(data);

      if(data['message'] != null){
        showInToast(data['message']);
        Navigator.pop(context);
      }
      showInToast(data["errors"]["image"][0]);
      /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MainPage();
      }));*/


      setState(() {
        onProgress = false;
      });
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
    } else {
      setState(() {
        onProgress = false;
      });
      Navigator.pop(context);

      var errorr = jsonDecode(responseString.trim().toString());
      // showInSnackBar("Registered Failed, ${errorr}");
      print("profile update failed " + errorr);
      showInToast(errorr);
    }
  }

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


/*  Profile profile;

  loadProfileData() async {
    print("expenditure entries are");
    final data = await Provider.of<ProfileProvider>(context, listen: false)
        .fetchProfile();
    print("aaaaaaaaaaaaaaaa${data}");
  }*/





  @override
  void initState() {
    // fetchProfile();
    //Profile data...
    final profileData = Provider.of<ProfileProvider>(context, listen: false);
    profileData.getProfileData(context,onProgress);
    nameController.text = profileData.profile.name;

     emailController.text = profileData.profile.email;
     contactController.text = profileData.profile.contact;
     houseController.text = profileData.profile.billingAddress.house;
     roadController.text = profileData.profile.billingAddress.road;
     areaController.text = profileData.profile.billingAddress.area;
     cityController.text = profileData.profile.billingAddress.city;
     districtController.text = profileData.profile.billingAddress.district;
     zipController.text = profileData.profile.billingAddress.zipCode;
     appartmentController.text = profileData.profile.billingAddress.appartment;
    super.initState();
  }


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    contactController.dispose();
    houseController.dispose();
    roadController.dispose();
    areaController.dispose();
    cityController.dispose();
    districtController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // profile = Provider.of<ProfileProvider>(context).profile;
    // String name=profile != null ? profile.name : '';
    final profileData = Provider.of<ProfileProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: onProgress,
      opacity: 0.1,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        backgroundColor: aNavBarColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.0,
          title: Text('Update your profile'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: ModalProgressHUD(
                inAsyncCall: onProgress,
                opacity: 0.1,
                progressIndicator: Spin(),
                child: Column(
                  children: [
                    /* Text(
                  "Profile Update",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),*/
                    SizedBox(
                      height: 10,
                    ),
                    Stack(children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border:
                          Border.all(color: aPrimaryColor, width: 2.0),
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
                                  ? InkWell(
                                onTap: () {
                                  // selectImage(context);
                                  getImageformGallery();
                                },
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "${profileData.profile.image != null ? "https://homechef.antapp.space/avatar/${profileData.profile.image }" : "https://yeureka.com/wp-content/uploads/2016/08/default.png"}",
                                  ),
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
                    RegiTextField(
                      name: "Your Name",
                      hint: 'name..',
                      //initialText: "hello",
                      controller: nameController,
                      onSave: (String value) {
                        name = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "*username required";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RegiTextField(
                      name: "Your Email",
                      hint: 'email..',
                      controller: emailController,
                      onSave: (String value) {
                        email = value;
                      },
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
                    RegiTextField(
                      name: "Your Contact Number",
                      hint: 'number..',
                      controller: contactController,
                      onSave: (String value) {
                        contact = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "*user contact required";
                        }
                        if (value.length < 3) {
                          return "*please write more then 3 word";
                        } else if (value.length > 11) {
                          return "*please write valid contact";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RegiTextField(
                      name: "House",
                      hint: 'House number..',
                      controller: houseController,
                      onSave: (String value) {
                        house = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "*House number required";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RegiTextField(
                      name: "Road",
                      hint: 'Road number..',
                      controller: roadController,
                      onSave: (String value) {
                        road = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "*Road number required";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RegiTextField(
                      name: "Appartment",
                      hint: 'appartment number..',
                      controller: appartmentController,
                      onSave: (String value) {
                        road = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "*appartment number required";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RegiTextField(
                      name: "Area",
                      hint: 'Area..',
                      controller: areaController,
                      onSave: (String value) {
                        area = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "*Area required";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RegiTextField(
                      name: "Your City",
                      hint: 'City..',
                      controller: cityController,
                      onSave: (String value) {
                        city = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "*city required";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RegiTextField(
                      name: "Zip-code",
                      hint: 'code..',
                      controller: zipController,
                      onSave: (String value) {
                        city = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "*city required";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RegiTextField(
                      name: "Your District",
                      hint: 'District..',
                      controller: districtController,
                      onSave: (String value) {
                        district = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "*District required";
                        }
                      },
                    ),
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
                            profileUpdate(profileData);
                            /*if(image == null || profileData.profile.image != null){
                              showInToast('please upload your profile image');
                            }else{


                            }*/
                          }


                          print('clicked');
                        },
                        child: Center(
                          child: Text(
                            'Update Profile',
                            style: TextStyle(color: aPrimaryColor, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
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
