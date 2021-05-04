
import 'package:flutter/material.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Model/categories_model.dart';
import 'package:home_chef_admin/Provider/categories_provider.dart';
import 'package:home_chef_admin/Screens/editCategory_page.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:provider/provider.dart';


class SearchHere extends SearchDelegate<Categories>{
  final List<Categories> itemsList;
  SearchHere({this.itemsList});
  bool onProgress = false;
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
    final categories = Provider.of<CategoriesProvider>(context);
    final myList = query.isEmpty? categories.categoriesList :
    categories.categoriesList.where((element) => element.name.toLowerCase().startsWith(query)).toList();
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: myList.isEmpty ? Center(child: Text('No result found',style: TextStyle(fontSize: 18),))
          : GridView.builder(
          itemCount: myList.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              childAspectRatio: 0.8,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            return Card(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://homechef.antapp.space/category/${myList[index].image ?? ""}"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Column(
                              children: [
                                Text(
                                  '${myList[index].name ?? ""}',
                                  style: TextStyle(
                                      color: aTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.3),
                                        width: 0.1),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5)),
                                  ),
                                  child: TextButton(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          size: 15,
                                          color: aTextColor,
                                        ),
                                        Text(
                                          'Edit',
                                          style: TextStyle(
                                            color: aTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context) {
                                                return CategoryEditPage(
                                                  id: myList[index].id,
                                                  index: index,
                                                  name: myList[index].name,
                                                );
                                              })).then((value) => categories.getCategories(context,onProgress));
                                    },
                                  ),
                                )),
                            Container(
                              height: 30,
                              width: 0.5,
                              color: Colors.grey,
                            ),
                            Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.3),
                                        width: 0.1),
                                    borderRadius: BorderRadius.only(
                                        bottomRight:
                                        Radius.circular(5)),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Are you sure ?'),
                                              titleTextStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  color: aTextColor),
                                              titlePadding:
                                              EdgeInsets.only(
                                                  left: 35,
                                                  top: 25),
                                              content: Text(
                                                  'Once you delete, the item will gone permanently.'),
                                              contentTextStyle:
                                              TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight
                                                      .w400,
                                                  color:
                                                  aTextColor),
                                              contentPadding:
                                              EdgeInsets.only(
                                                  left: 35,
                                                  top: 10,
                                                  right: 40),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Container(
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        15,
                                                        vertical:
                                                        10),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .all(Radius
                                                            .circular(
                                                            5)),
                                                        border: Border.all(
                                                            color:
                                                            aTextColor,
                                                            width:
                                                            0.2)),
                                                    child: Text(
                                                      'CANCEL',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          color:
                                                          aTextColor),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context);
                                                  },
                                                ),
                                                TextButton(
                                                  child: Container(
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        15,
                                                        vertical:
                                                        10),
                                                    decoration:
                                                    BoxDecoration(
                                                      color: Colors
                                                          .redAccent
                                                          .withOpacity(
                                                          0.2),
                                                      borderRadius:
                                                      BorderRadius
                                                          .all(Radius
                                                          .circular(
                                                          5)),
                                                    ),
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          color:
                                                          aPriceTextColor),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    CustomHttpRequest.deleteCategoryItem(
                                                        context,
                                                        myList[
                                                        index]
                                                            .id)
                                                        .then((value) =>
                                                    value);
                                                    myList.removeAt(index);
                                                    categories.getCategories(context,onProgress);
                                                    Navigator.pop(
                                                        context);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          size: 15,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          'Delete',
                                          style: TextStyle(
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    right: 55,
                    top: 80,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          border: Border.all(
                              color: aTextColor, width: 0.5)),
                      child: Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://homechef.antapp.space/category/${myList[index].icon ?? ""}"),
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final categories = Provider.of<CategoriesProvider>(context);
    final myList = query.isEmpty? categories.categoriesList :
    categories.categoriesList .where((element) => element.name.toLowerCase().startsWith(query)).toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: myList.isEmpty ? Center(child: Text('No result found',style: TextStyle(fontSize: 18),))
          : GridView.builder(
          itemCount: myList.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              childAspectRatio: 0.8,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            return Card(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://homechef.antapp.space/category/${myList[index].image ?? ""}"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Column(
                              children: [
                                Text(
                                  '${myList[index].name ?? ""}',
                                  style: TextStyle(
                                      color: aTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.3),
                                        width: 0.1),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5)),
                                  ),
                                  child: TextButton(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          size: 15,
                                          color: aTextColor,
                                        ),
                                        Text(
                                          'Edit',
                                          style: TextStyle(
                                            color: aTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                       Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context) {
                                                return CategoryEditPage(
                                                  id: myList[index].id,
                                                  index: index,
                                                  name: myList[index].name,
                                                );
                                              })).then((value) => categories.getCategories(context,onProgress));
                                    },
                                  ),
                                )),
                            Container(
                              height: 30,
                              width: 0.5,
                              color: Colors.grey,
                            ),
                            Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.3),
                                        width: 0.1),
                                    borderRadius: BorderRadius.only(
                                        bottomRight:
                                        Radius.circular(5)),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                       showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Are you sure ?'),
                                              titleTextStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  color: aTextColor),
                                              titlePadding:
                                              EdgeInsets.only(
                                                  left: 35,
                                                  top: 25),
                                              content: Text(
                                                  'Once you delete, the item will gone permanently.'),
                                              contentTextStyle:
                                              TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight
                                                      .w400,
                                                  color:
                                                  aTextColor),
                                              contentPadding:
                                              EdgeInsets.only(
                                                  left: 35,
                                                  top: 10,
                                                  right: 40),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Container(
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        15,
                                                        vertical:
                                                        10),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .all(Radius
                                                            .circular(
                                                            5)),
                                                        border: Border.all(
                                                            color:
                                                            aTextColor,
                                                            width:
                                                            0.2)),
                                                    child: Text(
                                                      'CANCEL',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          color:
                                                          aTextColor),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context);
                                                  },
                                                ),
                                                TextButton(
                                                  child: Container(
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        15,
                                                        vertical:
                                                        10),
                                                    decoration:
                                                    BoxDecoration(
                                                      color: Colors
                                                          .redAccent
                                                          .withOpacity(
                                                          0.2),
                                                      borderRadius:
                                                      BorderRadius
                                                          .all(Radius
                                                          .circular(
                                                          5)),
                                                    ),
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          color:
                                                          aPriceTextColor),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    CustomHttpRequest.deleteCategoryItem(
                                                        context,
                                                        myList[
                                                        index]
                                                            .id)
                                                        .then((value) =>
                                                    value);
                                                    myList.removeAt(index);
                                                    categories.getCategories(context,onProgress);

                                                    Navigator.pop(
                                                        context);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          size: 15,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          'Delete',
                                          style: TextStyle(
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    right: 55,
                    top: 80,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          border: Border.all(
                              color: aTextColor, width: 0.5)),
                      child: Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://homechef.antapp.space/category/${myList[index].icon ?? ""}"),
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

}

