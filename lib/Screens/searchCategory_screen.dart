/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_chef_admin/Model/searchCategory_model.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController controller = TextEditingController();

  bool onProgress = false;
  List<SearchCategory> list = [];

  Future fatchItems() async {
    setState(() {
      onProgress = true;
    });
    final uri = Uri.parse(
        "https://apihomechef.masudlearn.com/api/admin/search/category");

    var request = http.Request("POST", uri);
    request.headers.addAll(await CustomHttpRequest.getHeaderWithToken());
    request.bodyFields['name'] = controller.text;
    var response = await request.send();
    var responseData = await response.stream.toBytes();

    var responseString = String.fromCharCodes(responseData);

    print("responseBody1 " + responseString);
    var data = jsonDecode(responseString);
    print(response.statusCode);
    //search = Search.fromJson(data);
    print("print all search is : $data");

  }

  @override
  void initState() {
    fatchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text('Search'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchHere(itemsList: list));
            },
            icon: Icon(Icons.search),)
        ],
      ),
      body:  ModalProgressHUD(
        inAsyncCall: onProgress,
        opacity: 0.2,
        progressIndicator: CircularProgressIndicator(),
        child: Container(
          child: ListView.builder(
              itemCount: list.length,

              itemBuilder: (context,index){
                if(list.length >0){
                  return  Card(
                    elevation: 0.2,
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return SearchDetailsPage(id: list[index].id,);
                          }));
                        },
                        title: Text('${list[index].name}', style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                            FontWeight.w500)),
                        //subtitle: Text("${list[index].id}"),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://homechef.masudlearn.com/images/${list[index].image}"),
                          radius: 30,
                        ),
                      ),
                    ),
                  );
                }else{
                  return Center(child: Spin(),);
                }
              }),
        ),
      ),
    );
  }
}
class SearchHere extends SearchDelegate<Search>{
  final List<Search> itemsList;
  SearchHere({this.itemsList});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
      close(context, null);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    final myList = query.isEmpty? itemsList :
    itemsList.where((element) => element.name.toLowerCase().startsWith(query)).toList();
    return  myList.isEmpty
        ? Center(child: Text('No result found',style: TextStyle(fontSize: 18),))
        :
        */
/*: ListView.builder(
        itemCount: myList.length,
        itemBuilder: (context,index){
          return Card(
            elevation: 0.2,
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return SearchDetailsPage(id: myList[index].id,);
                  }));
                },
                title: Text(myList[index].name.toString()),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://homechef.masudlearn.com/images/${myList[index].image}"),
                  radius: 30,
                ),
              ),
            ),
          );
        });*//*

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final myList = query.isEmpty? itemsList :
    itemsList.where((element) => element.name.toLowerCase().startsWith(query)).toList();
    return myList.isEmpty ? Center(child: Text('No result found',style: TextStyle(fontSize: 18),)) : ListView.builder(
        itemCount: myList.length,
        itemBuilder: (context,index){
          return Card(
            elevation: 0.2,
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return SearchDetailsPage(id: myList[index].id,);
                  }));
                },
                title: Text(myList[index].name.toString()),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://homechef.masudlearn.com/images/${myList[index].image}"),
                  radius: 30,
                ),
              ),
            ),
          );
        });
  }

}*/
