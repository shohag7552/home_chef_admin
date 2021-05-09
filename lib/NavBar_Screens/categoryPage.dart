import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_chef_admin/Provider/categories_provider.dart';
import 'package:home_chef_admin/Provider/profile_provider.dart';
import 'package:home_chef_admin/Screens/Profile_screen.dart';
import 'package:home_chef_admin/Screens/addCategory_page.dart';
import 'package:home_chef_admin/Screens/editCategory_page.dart';
import 'package:home_chef_admin/Screens/searchCategory_screen.dart';
import 'package:home_chef_admin/Widgets/spin.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool onProgress = false;

  var _controller = ScrollController();
  bool _buttonVisiable = true;
  ScrollController _scrollController;

  /* Future<void> deleteAlertDialog(BuildContext context, int id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure ?'),
            titleTextStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: aTextColor),
            titlePadding: EdgeInsets.only(left: 35, top: 25),
            content: Text('Once you delete, the item will gone permanently.'),
            contentTextStyle: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, color: aTextColor),
            contentPadding: EdgeInsets.only(left: 35, top: 10, right: 40),
            actions: <Widget>[
              TextButton(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: aTextColor, width: 0.2)),
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
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                  child: Text('Delete',style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: aPriceTextColor),),
                ),
                onPressed: () async {
                  CustomHttpRequest.deleteCategoryItem(context, id)
                },
              ),
            ],
          );
        });
  }*/

  @override
  void initState() {
    //profile...
    final profileData = Provider.of<ProfileProvider>(context, listen: false);
    profileData.getProfileData(context,onProgress);

    //categories...
    final categoriesData =
        Provider.of<CategoriesProvider>(context, listen: false);
    categoriesData.getCategories(context,onProgress);

    //hide floating action button
    /*_controller.addListener(() {
      if(_controller.position.atEdge){
        if(_controller.position.pixels >0) {
          if (_buttonVisiable) {
            setState(() {
              _buttonVisiable = false;
            });
          }
        }
      }
      else{
        if(!_buttonVisiable){
          setState(() {
            _buttonVisiable = true;
          });
        }
      }
    });*/

    _scrollController = ScrollController();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<ProfileProvider>(context);
    final categories = Provider.of<CategoriesProvider>(context);

    return ModalProgressHUD(
      inAsyncCall: onProgress,
      opacity: 0.2,
      progressIndicator: Spin(),
      child: Scaffold(
        backgroundColor: aBackgroundColor,
        appBar: AppBar(
          backgroundColor: aNavBarColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/menu.svg"),
          ),
          title: Text('Categories'),
          actions: [
            /*Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddCategory())).then((value) => categories.getCategories(context,onProgress));
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ),*/
            SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ProfilePage();
                }));
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  "${profileData.profile != null ? profileData.profile.image != null ? "$profileImageUri/${profileData.profile.image }" : "https://yeureka.com/wp-content/uploads/2016/08/default.png" : ""}",),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        floatingActionButton: _buttonVisiable ? FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddCategory())).then((value) => categories.getCategories(context,onProgress));
        },
        backgroundColor: aBlackCardColor,
        child: Icon(
          Icons.add,
          size: 30,
          color: aPrimaryColor,
        ),
        ) : null,
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: aSearchFieldColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: TextButton(
                            onPressed: (){
                              showSearch(context: context, delegate: SearchHere(itemsList: categories.categoriesList )).then((value) => categories.getCategories(context,onProgress));

                            },
                            child: Row(
                              children: [
                                Text(
                                  'Search Categories',
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: SvgPicture.asset(
                                    'assets/search.svg',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  /* Expanded(
                    flex: 3,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 120,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),

                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey, width: 0.5),
                                  borderRadius: BorderRadius.circular(5.0)),
                              //margin: EdgeInsets.only(top: 20),
                              child: Center(
                                child: DropdownButtonFormField<String>(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    size: 20,
                                  ),
                                  decoration:
                                      InputDecoration.collapsed(hintText: ''),
                                  value: sortType,
                                  hint: Text(
                                    'Sort By',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      sortType = newValue;
                                    });
                                  },
                                  validator: (value) =>
                                      value == null ? 'field required' : null,
                                  items: _sortBy.map((String storageValue) {
                                    return DropdownMenuItem(
                                      value: storageValue,
                                      child: Text(
                                        "$storageValue ",
                                        style: TextStyle(
                                            color: aTextColor, fontSize: 14),
                                      ),
                                      onTap: () {},
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey, width: 0.5),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Icon(Icons.keyboard_arrow_down),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey, width: 0.5),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child:
                                  Center(child: Icon(Icons.keyboard_arrow_up)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
            Expanded(
              flex: 12,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  //height: 300,
                  child:categories.categoriesList.isNotEmpty? NotificationListener<UserScrollNotification>(
                    onNotification: (notification){
                      setState(() {
                        if(notification.direction == ScrollDirection.forward){
                          _buttonVisiable = true;
                        }
                        else if(notification.direction == ScrollDirection.reverse){
                          _buttonVisiable = false;
                        }
                      });
                      return true;
                    },
                    child: GridView.builder(
                      controller: _controller,
                        itemCount: categories.categoriesList.length,
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
                                                "https://homechef.antapp.space/category/${categories.categoriesList[index].image ?? ""}"),
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
                                          Expanded(

                                            child: Text(
                                              '${categories.categoriesList[index].name ?? ""}',
                                              style: TextStyle(
                                                  color: aTextColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
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
                                                    id: categories
                                                        .categoriesList[index].id,
                                                    index: index,
                                                    name: categories.categoriesList[index].name,
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
                                                                      categories
                                                                          .categoriesList[
                                                                              index]
                                                                          .id)
                                                                  .then((value) =>
                                                                      value);
                                                              setState(() {
                                                                categories
                                                                    .categoriesList
                                                                    .removeAt(
                                                                        index);
                                                              });
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
                                              "https://homechef.antapp.space/category/${categories.categoriesList[index].icon ?? ""}"),
                                        ),),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ):Center(child: CircularProgressIndicator(),)),
            )
          ],
        ),
      ),
    );
  }
}
