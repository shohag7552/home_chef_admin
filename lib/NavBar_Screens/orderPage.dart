import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Provider/order_provider.dart';
import 'package:home_chef_admin/Provider/profile_provider.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool onProgress = false;
  @override
  void initState() {
    //Recent orders ...
    final recentOrders = Provider.of<OrderProvider>(context, listen: false);
    recentOrders.getRecentOrders(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<ProfileProvider>(context);
    final recentOrders = Provider.of<OrderProvider>(context);
    return Scaffold(
      backgroundColor: aBackgroundColor,
      appBar: AppBar(
        backgroundColor: aNavBarColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset("assets/menu.svg"),
        ),
        title: Text('Order List'),
        actions: [
          SizedBox(
            width: 5,
          ),
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
                "https://homechef.masudlearn.com/avatar/${profileData.profile.image ?? ""}"),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
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
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: aSearchFieldColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Search Orders',
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
              ],
            ),
          ),
          Expanded(
            flex: 12,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child:  ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: recentOrders.orderList.length ?? "",
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
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
                              '\$${recentOrders.orderList[index].price ?? ""}',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: aPriceTextColor),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
