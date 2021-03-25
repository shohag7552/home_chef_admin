import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_chef_admin/Model/orders_model.dart';
import 'package:home_chef_admin/Model/totalOrder.dart';
import 'package:home_chef_admin/Model/totalUser.dart';
import 'package:home_chef_admin/Screens/login_page.dart';
import 'package:home_chef_admin/Widgets/spin.dart';
import 'package:home_chef_admin/server/http_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String token;

  /*List<Orders> orderList = [];
  Orders orders;*/
  /*Future<dynamic> getOrders() async{
    final data = await CustomHttpRequest.getOrders();
    print("value are $data");
    orders = Orders.fromJson(data);
    print(orders);
    */ /*for (var entries in data) {
      Orders orderModel = Orders(
          id: entries["id"],
          price: entries["price"],
          user: entries["user"]
        // orderStatus: entries["order_status"]
      );*/ /*
    if (mounted) {
      setState(() {
        orderList.add(orders);
      });
    }
  }*/

  String total;
  TotalUser totalUser;
  Future<dynamic> getAllUsers() async{
    final data = await CustomHttpRequest.getTotalUser();
    print("Total users : $data");
    if (mounted) {
      totalUser = TotalUser.fromJson(data);

      setState(() {
        //total = totalUser != null ? totalUser.totalUser.toString() : "";
      });
    }
  }

  TotalOrder total_order;
  Future<dynamic> getAllOrders() async{
    final data = await CustomHttpRequest.getTotalOrder();
    print("Total users : $data");
    if (mounted) {
      total_order = TotalOrder.fromJson(data);

      setState(() {
        //total = totalUser != null ? totalUser.totalUser.toString() : "";
      });
    }
  }

  Future<void> displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure want to LogOut ?'),
            actions: <Widget>[
              TextButton(
                // color: Colors.black,
                // textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('OK'),
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.remove('token');
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
    getAllUsers();
    getAllOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: aBackgroundColor,
      appBar: AppBar(
        backgroundColor: aNavBarColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            displayTextInputDialog(context);
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
          CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(
                'https://thrivingmarriages-eszuskq0bptlfh8awbb.stackpathdns.com/wp-content/uploads/2020/10/dangerous-person.jpg'),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: aBlackCardColor,
        child: Icon(
          Icons.add,
          size: 30,
          color: aPrimaryColor,
        ),
      ),
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
                            'Welcome User !',
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
                                      Text(
                                        totalUser != null ? totalUser.totalUser.toString() : "",
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
                                      Text(
                                        total_order != null ? total_order.totalOrder.toString() : "",
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
                        height: MediaQuery.of(context).size.width * 0.9,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        //color: Colors.green,
                        child: FutureBuilder(
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
                        )
                        /*ListView.builder(
                        itemCount: orderList.length,
                        itemBuilder: (context,index){

                          return
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Row(
                              children: [
                                Icon(Icons.access_time_rounded,color: Colors.orangeAccent,size: 15,),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${orders.user.name}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                    Text('#${orders.id}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),

                                  ],
                                ),
                                Spacer(),
                                Text('\$${orders.price}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: aPriceTextColor),)
                              ],
                            ),
                          );
                        }),*/
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
}
