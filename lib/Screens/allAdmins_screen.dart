import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Model/admin_model.dart';
import 'package:home_chef_admin/Provider/admins_provider.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AllAdmins extends StatefulWidget {
  @override
  _AllAdminsState createState() => _AllAdminsState();
}

class _AllAdminsState extends State<AllAdmins> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool onProgress = false;

  Admin admin;

  getAdminWithId(context, int id) async {

    try {
      String url = "https://apihomechef.antapp.space/api/admin/edit/$id";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
        myUri,
        headers: await CustomHttpRequest.getHeaderWithToken(),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {


        final item = json.decode(response.body);
        admin = Admin.fromJson(item);
        print(admin);


        nameController.text = admin.name;
        emailController.text = admin.email;


      } else {
        print('Data not found');
        setState(() {
          onProgress = false;
        });
      }
    } catch (e) {
      print(e);

    }
  }

  updateAdmin(BuildContext context, int id) async {
    try {
      setState(() {
        onProgress =true;
      });
      var data;
      print('updating');
      print('$id');

      final uri =
          Uri.parse("https://apihomechef.antapp.space/api/admin/update/$id");
      var request = http.MultipartRequest("POST", uri);
      request.headers.addAll(await CustomHttpRequest.getHeaderWithToken());
      request.fields['name'] = nameController.text.toString();
      request.fields['email'] = emailController.text.toString();

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("responseBody " + responseString);
      data = jsonDecode(responseString);
      print(response.statusCode);
      //stay here
      if (response.statusCode == 200) {
        print("responseBody1 " + responseString);
        //data = jsonDecode(responseString);
        //var data = jsonDecode(responseString);
        if(data['message'] != null) {
          showInToast(data['message']);

          print(data['message'].toString());
          setState(() {
            onProgress = false;
            nameController.clear();
            emailController.clear();
          });

          Navigator.pop(context);
        }
        if(data['errors']['email'][0] != null) {
          showInToast(data['errors']['email'][0]);
        }
      }
      else {
        setState(() {
          onProgress = false;
        });
        //showInToast(responseString);
        showInToast('something wrong');
       // var errorr = jsonDecode(responseString.trim().toString());
        //showInToast("Registered Failed, please fill all the fields");
        print("Registered failed " + responseString);
      }
    } catch (e) {
      print("something went wrong $e");
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
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void initState() {
    final allAdmin = Provider.of<AdminsProvider>(context, listen: false);
    allAdmin.getAdmins(context, onProgress);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final allAdmin = Provider.of<AdminsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: aNavBarColor,
        elevation: 1,
        title: Text('All Admins'),
      ),
      body: Container(
        child: allAdmin.adminsList.isNotEmpty ?  ListView.builder(
            itemCount: allAdmin.adminsList.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Card(
                elevation: 0.5,
                child: ListTile(
                  title: Text(
                    '${allAdmin.adminsList[index].name}',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    "${allAdmin.adminsList[index].email}",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      "$profileImageUri/${allAdmin.adminsList[index].image}",
                    ),
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      String choice = value;
                      if (choice == Constants.Edit) {
                        print('edit');
                        int id = allAdmin.adminsList[index].id;
                        String name = allAdmin.adminsList[index].name;
                        String email = allAdmin.adminsList[index].email;

                        nameController.text = name;
                        emailController.text = email;

                       // getAdminWithId(context, id);

                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Form(
                                  key: _formKey,
                                  child: SingleChildScrollView(

                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.33,
                                      /*width: MediaQuery.of(context).size.width*0.8,*/
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Change Name and email',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: aPrimaryColor,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                hintText: 'new name..',
                                                //labelText: 'old password'
                                              ),
                                              controller: nameController,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return '*please write new name';
                                                }
                                              },
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                hintText: 'new email..',
                                                //labelText: 'new password'
                                              ),
                                              controller: emailController,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "*email is empty";
                                                }
                                              },
                                            ),

                                            Spacer(),
                                            Container(
                                              height: 40,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                color: aTextColor,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: TextButton(
                                                  onPressed: () {
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      _formKey.currentState
                                                          .save();
                                                      updateAdmin(context, id);
                                                      setState(() {

                                                        allAdmin.getAdmins(context, onProgress);
                                                      });
                                                    }
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                      'Confirm',
                                                      style: TextStyle(
                                                          color: aPrimaryColor,
                                                          fontSize: 16),
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).then((value) => allAdmin.getAdmins(context, onProgress));
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
                                titlePadding:
                                    EdgeInsets.only(left: 35, top: 25),
                                content: Text(
                                    'Once you delete, the Admin will gone permanently.'),
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
                                          horizontal: 15, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                              color: aTextColor, width: 0.2)),
                                      child: Text(
                                        'CANCEL',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
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
                                          horizontal: 15, vertical: 10),
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.redAccent.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: aPriceTextColor),
                                      ),
                                    ),
                                    onPressed: () async {
                                      CustomHttpRequest.deleteAdmin(context,
                                              allAdmin.adminsList[index].id)
                                          .then((value) => value);
                                      setState(() {
                                        allAdmin.adminsList.removeAt(index);
                                      });
                                      allAdmin.getAdmins(context, onProgress);
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
              );
            }) : Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
