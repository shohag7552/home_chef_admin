import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Constants/MainPage.dart';
import 'package:home_chef_admin/Widgets/loginTextField.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool onProgress=false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obser = true;
  String token;
  SharedPreferences sharedPreferences;

  Future isLogin() async{
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    token = sharedPreferences.getString("token");
    if (token != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return MainPage();
      }));
    }
  }


  Future<String> _submit() async {
    if (mounted) {
      setState(() {
        onProgress = true;
      });
      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();
        print('|valeditor accessed |');
        if (await getLogin()) {
          print('|valeditor accessed |');
          emailController.clear();
          passwordController.clear();
          onProgress = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return MainPage();
          }));
          print(":Succcccccccccccccccccccccc");
          return "Logged In";
        } else {
          setState(() {
            onProgress = false;
          });
          return "Incorrect Credentials";
        }
      } else {
        setState(() {
          onProgress = false;
        });
        return "Required email and password";
      }
    }
  }

  Future<bool> getLogin() async {
    setState(() {
      onProgress = true;
    });
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      final result = await CustomHttpRequest.login(
          emailController.text.toString(),
          passwordController.text.toString());
      final data = jsonDecode(result);
      print('111111111111111111111');

      print(" the login data are : $data");
      if (data["access_token"] != null) {
        showInToast("Login successfully");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return MainPage();
        }));

        setState(() {
          sharedPreferences.setString("token", data['access_token']);

        });
        print("save token");
        token = sharedPreferences.getString("token");
        print('token is $token');

        return true;
      } else {
        showInToast("Email & Password didn't match");
        return false;
      }
    } catch (e) {
      setState(() {
        onProgress = false;
      });

      print("something wrong  $e");
      showInToast("Email & Password didn't match");
    }
  }

  @override
  void initState() {
    isLogin();
    super.initState();
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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: onProgress,
        opacity: 0.2,
        progressIndicator: CircularProgressIndicator(
          strokeWidth: 5,
        ),
        child: Container(
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(

                    color: aPrimaryColor,
                    width:  MediaQuery.of(context).size.width,
                    height: 220,
                    child: Image.network(
                      'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1000&q=80',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width:  MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 30, left: 12, right: 12),
                    child: ListView(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Hey!',
                          style: TextStyle(
                              fontSize: 22,
                              color: aPrimaryColor,
                              fontWeight: FontWeight.w800
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Get Start with Homechef Admin',
                          style: TextStyle(
                              fontSize: 18,
                              color: aTextColor,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        LoginTextEdit(
                          controller: emailController,
                          hintText: 'Enter your Email Address',
                          icon: Icons.email,
                          function: (value){
                            if (value.isEmpty) {
                              return "*email address required";
                            }
                            if (!value.contains('@')) {
                              return "*wrong email address";
                            }
                            if (!value.contains('.')) {
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
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordController,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                gapPadding: 5.0,
                                borderSide:  BorderSide(color: aPrimaryColor,width: 2.5)),
                            prefixIcon:Icon(Icons.lock_sharp,
                              color: Colors.black54,
                              size: 18,),
                            suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  obser = !obser;
                                });
                              },
                              child: Icon(
                                obser?
                                Icons.visibility_off
                                : Icons.visibility,
                                color: !obser ? aPrimaryColor : Colors.grey,
                                size: 18,
                              ),
                            ),
                            hintText: 'password',
                          ),
                          obscureText: obser,
                          validator: (value){
                            if(value.isEmpty){
                              return "*please enter password";
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          width:  MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            color: aTextColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _submit();
                            },
                            child: Center(
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                    color: aPrimaryColor, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        /*Center(
                          child: Text(
                            'Forgot your Password?',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              // decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                          endIndent: 98,
                          indent: 98,
                          height: 2,
                        ),
                        SizedBox(
                          height: 30,
                        ),*/
                        /*Row(
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Spacer(),
                            Container(
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: aPrimaryColor, width: 2.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return RegistrationPage();
                                  }));
                                },
                                child: Center(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    )),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 10,),*/
                      ],
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
