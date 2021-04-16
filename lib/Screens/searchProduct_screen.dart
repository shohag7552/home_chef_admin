import 'package:flutter/material.dart';
import 'package:home_chef_admin/Model/products_model.dart';
class ProductSearchHere extends SearchDelegate<Products>{
  final List<Products> itemsList;
  ProductSearchHere({this.itemsList});
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
    return  myList.isEmpty ? Center(child: Text('No result found',style: TextStyle(fontSize: 18),)) : ListView.builder(
        itemCount: myList.length,
        itemBuilder: (context,index){
          return Card(
            elevation: 0.2,
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context){
                  //   return SearchDetailsPage(id: myList[index].id,);
                  // }));
                },
                title: Text(myList[index].name.toString()),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://homechef.masudlearn.com/category/${myList[index].image}"),
                  radius: 30,
                ),
              ),
            ),
          );
        });
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
                  /*Navigator.push(context, MaterialPageRoute(builder: (context){
                    return SearchDetailsPage(id: myList[index].id,);
                  }));*/
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

}