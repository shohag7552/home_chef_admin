import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Provider/profile_provider.dart';
import 'package:home_chef_admin/Screens/allAdmins_screen.dart';
import 'package:home_chef_admin/Screens/edit_profile_screen.dart';
import 'package:home_chef_admin/Screens/login_page.dart';
import 'package:home_chef_admin/Screens/registration_screen.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool onProgress = false;

  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confPassController = TextEditingController();

  Future changePassword(BuildContext context) async{

    final uri = Uri.parse("https://apihomechef.antapp.space/api/admin/update/password");
    var request = http.MultipartRequest("POST",uri);
    request.headers.addAll(await CustomHttpRequest.getHeaderWithToken());
    //old_password,password,  password_confirmation
    request.fields['old_password'] = oldPassController.text.toString();
    request.fields['password'] = newPassController.text.toString();
    request.fields['password_confirmation'] = confPassController.text.toString();

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    print("responseBody " + responseString);
    SharedPreferences preferences =
    await SharedPreferences.getInstance();
    await preferences.remove('token');

    print(response.statusCode);
    if (response.statusCode == 200) {
      print("responseBody1 " + responseString);
      var data = jsonDecode(responseString);
      showInToast(data['message']);
      print(data['message']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));

    }
    else{
      /* setState(() {
        onProgress = false;
      });*/
      var errorr = jsonDecode(responseString.trim().toString());
      print('Did not changed password...');
      // showInSnackBar("Registered Failed, ${errorr}");
      print("Registered failed " + responseString);

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
  Future<void> displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure want to LogOut ?',style: TextStyle(color: aTextColor),),
            actions: <Widget>[
              TextButton(
                // color: Colors.black,
                // textColor: Colors.white,
                child: Text('CANCEL',style: TextStyle(color: aTextColor.withOpacity(0.7)),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('OK',style: TextStyle(color: aPriceTextColor),),
                onPressed: () async {
                  SharedPreferences preferences =
                  await SharedPreferences.getInstance();
                  await preferences.remove('token');
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));

                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    //Profile data...
    final profileData = Provider.of<ProfileProvider>(context, listen: false);
    profileData.getProfileData(context,onProgress);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<ProfileProvider>(context);

    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: aNavBarColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text('Your Profile'),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditProfile();
                })).then((value) => profileData.getProfileData(context,onProgress));
              })
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  border: Border.all(color: aPrimaryColor, width: 2.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: aTextColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        //"${profileData.profile.image != null ? "https://homechef.antapp.space/avatar/${profileData.profile.image }" : "https://yeureka.com/wp-content/uploads/2016/08/default.png"}",
                        "${profileData.profile !=null ? profileData.profile.image != null ? "https://homechef.antapp.space/avatar/${profileData.profile.image }" : "https://yeureka.com/wp-content/uploads/2016/08/default.png" : ""}",
                    ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Name : ${profileData.profile != null ? profileData.profile.name : ''}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Email : ${profileData.profile != null ? profileData.profile.email : ""}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Contact : ${profileData.profile != null ? profileData.profile.contact == null?'Not provided yet': profileData.profile.contact : ''}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20,),

              InkWell(onTap: (){
                showDialog(context: context, builder: (context){
                  return Dialog(
                    child: SingleChildScrollView(

                      child: Form(
                        key: _formKey,
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.5,
                          width: MediaQuery.of(context).size.width*0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Text('Change Password',style: TextStyle(
                                    fontSize: 16,
                                    color: aPrimaryColor,
                                    fontWeight: FontWeight.w600
                                ),),
                                SizedBox(height: 10,),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'old password..',
                                      //labelText: 'old password'
                                    ),
                                    controller: oldPassController,
                                    validator: (value){
                                      if(value.isEmpty){
                                        return '*please write old password';
                                      }
                                    },
                                  ),

                                ),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'new password..',
                                      //labelText: 'new password'
                                    ),
                                    controller: newPassController,
                                    validator: (value){
                                      if (value.isEmpty) {
                                        return "*Password is empty";
                                      }
                                      if (value.length < 6) {
                                        return "*Password contains more then 6 carecters";
                                      }
                                      if (value.length > 20) {
                                        return "*Password not contains more then 20 carecters";
                                      }
                                    },
                                  ),

                                ),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'confirm password..',
                                      // labelText: 'confirm password..'
                                    ),
                                    controller: confPassController,
                                    validator: (value){
                                      if (value.isEmpty) {
                                        return "Confirm Password required ";
                                      }

                                      if (newPassController.text !=
                                          confPassController.text) {
                                        return "Password do not match";
                                      }
                                    },
                                  ),

                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 50,
                                  width:  MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: aTextColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: TextButton(onPressed: (){
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      // getRegister(context);
                                      changePassword(context);
                                    }
                                  },
                                      child: Center(
                                        child: Text('Confirm',style: TextStyle(
                                            color: aPrimaryColor, fontSize: 16),
                                        ),
                                      )),
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });

              },
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: aPrimaryColor,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Text('Change account password',style: TextStyle(color: aTextColor,),),
              )

              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return RegistrationPage();
                  }));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: aPrimaryColor,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Text('Create new admin ',style: TextStyle(color: aTextColor,),),
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return AllAdmins();
                  }));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: aPrimaryColor,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Text('All Admins ',style: TextStyle(color: aTextColor,),),
                ),
              ),
              SizedBox(height: 20,),

              InkWell(
                onTap: (){
                  displayTextInputDialog(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: aPrimaryColor,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: aPriceTextColor,
                  ),
                  child: Text('Logout ',style: TextStyle(color: aNavBarColor,),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
