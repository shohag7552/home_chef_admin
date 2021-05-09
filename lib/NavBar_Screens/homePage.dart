import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_chef_admin/Provider/order_provider.dart';
import 'package:home_chef_admin/Provider/profile_provider.dart';
import 'package:home_chef_admin/Provider/totalOrder_provider.dart';
import 'package:home_chef_admin/Provider/totalUser_provider.dart';
import 'package:home_chef_admin/Screens/Profile_screen.dart';
import 'package:home_chef_admin/Screens/addCategory_page.dart';
import 'package:home_chef_admin/Screens/addProduct_screen.dart';
import 'package:home_chef_admin/Widgets/spin.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String token;
  bool onProgress = false;

  ScrollController _scrollController;
  bool showFav = true;


  checkProfileData(){

  }


  @override
  void initState() {
    //Profile data...
    final profileData = Provider.of<ProfileProvider>(context, listen: false);
    print('profile code : ${profileData.profile.hashCode}');
    profileData.getProfileData(context,onProgress);


    //total user....
    final totalUsers = Provider.of<TotalUserProvider>(context, listen: false);
    totalUsers.getTotalUser(context,onProgress);

    //total order...
    final totalOrders = Provider.of<TotalOrderProvider>(context, listen: false);
    totalOrders.getTotalUser(context);

    //Recent orders ...
    final recentOrders = Provider.of<OrderProvider>(context, listen: false);
    recentOrders.getRecentOrders(context);

    _scrollController = ScrollController();

    super.initState();
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<ProfileProvider>(context);
    final totalUsers = Provider.of<TotalUserProvider>(context);
    final totalOrders = Provider.of<TotalOrderProvider>(context);
    final recentOrders = Provider.of<OrderProvider>(context);
    return Scaffold(
      backgroundColor: aBackgroundColor,
      appBar: AppBar(
        backgroundColor: aNavBarColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {

          },
          icon: SvgPicture.asset("assets/menu.svg"),
        ),
        centerTitle: true,
        title: Container(
          height: 70,
          width: 80,
          child: Image.asset('assets/logo.png'),
        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ProfilePage();
              }));
            },
            child: CircleAvatar(
              radius: 20,
              backgroundImage:  NetworkImage(
                "${profileData.profile !=null ? profileData.profile.image != null ? "$profileImageUri/${profileData.profile.image }" : "https://yeureka.com/wp-content/uploads/2016/08/default.png" : ""}",)

            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      floatingActionButton: showFav ? FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return bottomSheet(context);
              });
        },
        backgroundColor: aBlackCardColor,
        child: Icon(
          Icons.add,
          size: 30,
          color: aPrimaryColor,
        ),
      ) : null,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    color: aNavBarColor,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome ${profileData.profile !=null ? profileData.profile.name : 'Admin'} !',
                            style: TextStyle(
                              color: aTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 55,
                    right: 10,
                    left: 10,
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: ModalProgressHUD(
                                inAsyncCall: onProgress,
                                opacity: 0.2,
                                progressIndicator: Spin(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/Users.svg'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Users',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: aNavBarColor),
                                        ),
                                        totalUsers.totalUser == null ? CircularProgressIndicator() : Text(
                                          '${totalUsers.totalUser.totalUser ?? ""}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: aNavBarColor),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/Orders.svg'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Orders',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: aNavBarColor),
                                      ),
                                      totalOrders.totalOrder == null ? CircularProgressIndicator() :Text(
                                        "${totalOrders.totalOrder.totalOrder ?? "" }",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: aNavBarColor),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      child: Row(
                        children: [
                          Text('Recent Orders'),
                          Spacer(),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      height: MediaQuery.of(context).size.width * 1,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      //color: Colors.green,
                      child:
                          /*FutureBuilder(
                          future: CustomHttpRequest.getOrder(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Orders>> snapshot) {
                            if (snapshot.hasData) {
                              List<Orders> orders = snapshot.data;
                              return ListView(
                                children: orders.map((Orders order) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_rounded,
                                          color: Colors.orangeAccent,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${order.user.name}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              '#${order.id}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Text(
                                          '\$${order.price}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: aPriceTextColor),
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            } else {
                              return Center(child: Spin());
                            }
                          },
                        )*/
                     recentOrders.orderList.isNotEmpty ? NotificationListener<UserScrollNotification>(
                       onNotification: (notification){
                         setState(() {
                           if(notification.direction == ScrollDirection.forward){
                             showFav = true;
                           }
                           else if(notification.direction == ScrollDirection.reverse){
                             showFav = false;
                           }
                         });
                         return true;
                       },
                       child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: recentOrders.orderList.length ?? "",
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Row(
                                  children: [
                                    Icon(
                                     recentOrders.orderList[index].payment.paymentStatus.toString() == '1'?
                                      Icons.check_circle_outlined:Icons.access_time_rounded,
                                      color: recentOrders.orderList[index].payment.paymentStatus.toString() == '1'? Colors.green :aPrimaryColor,
                                      size: 15,
                                    ),
                               /* recentOrders.orderList[index].orderStatus
                                    .orderStatusCategory.name ==
                                    'Complete'
                                    ? Icons.check_circle_outlined
                                    : Icons.access_time_rounded,
                                color: recentOrders.orderList[index].orderStatus
                                    .orderStatusCategory.name ==
                                    'Complete'
                                    ? Colors.green
                                    : aPrimaryColor,
                              ),*/
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${recentOrders.orderList[index].user.name ?? ""}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          '#${recentOrders.orderList[index].id ?? ""}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      '\৳ ${recentOrders.orderList[index].price ?? ""}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: aPriceTextColor),
                                    )
                                  ],
                                ),
                              );
                            }),
                     ): Center(child: CircularProgressIndicator()),
                    )
                  ],
                ),

                /* child: */
              )
            ],
          ),
        ),
      ),
    );
  }

  Container bottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 2,
          ),
          SizedBox(
            height: 2,
            width: 30,
            child: Container(
              decoration: BoxDecoration(color: Colors.grey),
            ),
          ),
          SizedBox(height: 5),
          Container(
            //height: MediaQuery.of(context).size.height * 0.20,
            child: Row(
              children: [
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddCategory()),
                    ).then(
                      (value) => Navigator.pop(context),
                    );
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: aPrimaryColor,
                          ),
                          child: Center(
                            child: Container(
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset(
                                'assets/AddCategory.svg',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Add Category',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                )),
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddProductPage()),
                    ).then(
                          (value) => Navigator.pop(context),
                    );
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: aPrimaryColor,
                          ),
                          child: Center(
                            child: Container(
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset(
                                'assets/AddProducts.svg',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Add Products',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
