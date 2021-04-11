import 'package:flutter/material.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Provider/admins_provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
class AllAdmins extends StatefulWidget {
  @override
  _AllAdminsState createState() => _AllAdminsState();
}

class _AllAdminsState extends State<AllAdmins> {
  bool onProgress = false;
  @override
  void initState() {
    final allAdmins = Provider.of<AdminsProvider>(context, listen: false);
    allAdmins.getAdmins(context, onProgress);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final allAdmin = Provider.of<AdminsProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: onProgress,
      opacity: 0.1,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: aNavBarColor,
          elevation: 1,
          title: Text('All Admins'),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: allAdmin.adminsList.length,
              itemBuilder: (context,index){
            return ListTile(
              title: Text('${allAdmin.adminsList[index].name}', style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500),),
              subtitle: Text("${allAdmin.adminsList[index].email}", style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400),),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://homechef.masudlearn.com/avatar/${allAdmin.adminsList[index].image}",
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
