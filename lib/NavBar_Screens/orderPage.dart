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
  bool _visibleSwitchCondition = false;
  int _visibleValue = 0;
  bool _availabilitySwitchCondition = false;
  int _availabilityValue = 0;

  Future<void> displayViewDetailsDialog(BuildContext context) async{
   showDialog(context: context, builder: (context){
     return Dialog(
       child: Container(
         height: MediaQuery.of(context).size.height *0.75,
         width: MediaQuery.of(context).size.height *0.9 ,
         child: SingleChildScrollView(

           child: Column(
             children: [
               Container(height: 50,
               alignment: Alignment.centerRight,
               padding: EdgeInsets.only(right: 10),
               child: InkWell(
                 onTap: (){
                   Navigator.pop(context);
                 },
                   child: Icon(Icons.close)),
               ),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                   children: [
                     CircleAvatar(
                       radius: 22,
                       backgroundImage: NetworkImage(
                           "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                     ),
                     SizedBox(width: 10,),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Mr.Mehedi',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                         Text('+8801677696277',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                       ],
                     ),
                     Spacer(),
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                       decoration: BoxDecoration(
                         color: aPriceTextColor.withOpacity(0.18),
                         borderRadius:
                         BorderRadius.all(Radius.circular(5)),
                       ),
                       child: Icon(Icons.delete_outline_outlined,color: aPriceTextColor,size: 18,),
                     ),
                   ],
                 ),

               ),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                 child: Column(
                   children: [
                     Row(
                       children: [
                         Text('Order ID',style: TextStyle(color: aTextColor.withOpacity(0.5),fontSize: 14,fontWeight: FontWeight.w500),),
                         Spacer(),
                         Text('#104',style: TextStyle(color: aTextColor,fontSize: 14,fontWeight: FontWeight.w500),),
                       ],
                     ),
                     SizedBox(height: 10,),
                     Row(
                       children: [
                         Text('Payment',style: TextStyle(color: aTextColor.withOpacity(0.5),fontSize: 14,fontWeight: FontWeight.w500),),
                         Spacer(),
                         Text('Cash on delivery',style: TextStyle(color: aTextColor,fontSize: 14,fontWeight: FontWeight.w500),),
                       ],
                     ),
                     SizedBox(height: 10,),
                     Row(
                       children: [
                         Text('Address',style: TextStyle(color: aTextColor.withOpacity(0.5),fontSize: 14,fontWeight: FontWeight.w500),),
                         Spacer(),
                         Text('98 Rd No 4 Dhaka',style: TextStyle(color: aTextColor,fontSize: 14,fontWeight: FontWeight.w500),),
                       ],
                     ),
                   ],
                 ),
               ),
               Divider(color: aTextColor.withOpacity(0.5),),
               Container(
                 height: 150,
                 child: RawScrollbar(
                   isAlwaysShown: true,
                   child: ListView.builder(
                     itemCount: 5,
                       itemBuilder: (context, index){
                     return ListTile(
                       title: Text('Beep Burger'),
                       subtitle: Text('x2'),
                       leading: CircleAvatar(
                         radius: 18,
                         backgroundImage: NetworkImage(
                             "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                       ),
                       trailing: Text('\$150',style: TextStyle(color: aPriceTextColor,fontSize: 16,fontWeight: FontWeight.w700),),
                     );
                   }),
                 ),
               ),
               Divider(color: aTextColor.withOpacity(0.5),),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                 child: Column(
                   children: [
                     Row(
                       children: [
                         Text('Discount',style: TextStyle(color: aTextColor.withOpacity(0.5),fontSize: 14,fontWeight: FontWeight.w500),),
                         Spacer(),
                         Text('- 40.00',style: TextStyle(color: aTextColor,fontSize: 14,fontWeight: FontWeight.w500),),
                       ],
                     ),
                     SizedBox(height: 10,),
                     Row(
                       children: [
                         Text('Delivery charge',style: TextStyle(color: aTextColor.withOpacity(0.5),fontSize: 14,fontWeight: FontWeight.w500),),
                         Spacer(),
                         Text('15.00',style: TextStyle(color: aTextColor,fontSize: 14,fontWeight: FontWeight.w500),),
                       ],
                     ),
                     SizedBox(height: 20,),
                     Row(
                       children: [
                         Text('Delivery charge',style: TextStyle(color: aTextColor,fontSize: 14,fontWeight: FontWeight.w500),),
                         Spacer(),
                         Text('500.00',style: TextStyle(color: aTextColor,fontSize: 20,fontWeight: FontWeight.w700),),
                       ],
                     ),
                     SizedBox(height: 20,)
                   ],
                 ),
               )
             ],
           ),
         ),
       ),
     );
   }) ;
  }

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
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: recentOrders.orderList.length ?? "",
                  itemBuilder: (context, index) {
                    return Card(
                      child: ExpansionTile(
                        trailing: Text(
                          '\$${recentOrders.orderList[index].price ?? ""}',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: aPriceTextColor),
                        ),
                        title: Text(
                          '${recentOrders.orderList[index].user.name ?? ""}',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: aTextColor),
                        ),
                        leading: Icon(Icons.access_time_rounded),
                        subtitle: Text(
                          '#${recentOrders.orderList[index].id ?? ""}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: aTextColor),
                        ),
                        children: [
                          Divider(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order Status',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: aTextColor.withOpacity(0.5),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 12,
                                              width: 12,
                                              decoration: BoxDecoration(
                                                color: aNavBarColor,
                                                border: Border.all(
                                                    color: aTextColor),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              child: Center(
                                                  child: Icon(
                                                Icons.check,
                                                size: 10,
                                                color: aNavBarColor,
                                              )),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Ongoing',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 12,
                                              width: 12,
                                              decoration: BoxDecoration(
                                                color: aNavBarColor,
                                                border: Border.all(
                                                    color: aTextColor),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              child: Center(
                                                  child: Icon(
                                                Icons.check,
                                                size: 10,
                                                color: aNavBarColor,
                                              )),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Delivered',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 12,
                                              width: 12,
                                              decoration: BoxDecoration(
                                                color: aTextColor,
                                                border: Border.all(
                                                    color: aTextColor),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              child: Center(
                                                  child: Icon(
                                                Icons.check,
                                                size: 10,
                                                color: aNavBarColor,
                                              )),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Complete',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Payment',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: aTextColor,
                                            ),
                                          ),
                                          Spacer(),
                                          Switch(
                                            value: _visibleSwitchCondition,
                                            onChanged: (value) {
                                              _visibleSwitchCondition == value
                                                  ? _visibleValue = 1
                                                  : _visibleValue = 0;
                                              print("$_visibleValue");
                                            },
                                            activeColor: aPrimaryColor,
                                            activeTrackColor: aTextColor,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Approval',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: aTextColor,
                                            ),
                                          ),
                                          Spacer(),
                                          Switch(
                                            value: _availabilitySwitchCondition,
                                            onChanged: (value) {
                                              _availabilitySwitchCondition ==
                                                      value
                                                  ? _availabilityValue = 1
                                                  : _availabilityValue = 0;
                                              print("$_availabilityValue");
                                            },
                                            activeColor: aPrimaryColor,
                                            activeTrackColor: aTextColor,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: (){
                                    int id =recentOrders.orderList[index].id;
                                    print(id);
                                    displayViewDetailsDialog(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(
                                          color: aTextColor, width: 0.1),
                                    ),
                                    child: Text(
                                      'View Details',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: aTextColor,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                  onTap: (){

                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                                    decoration: BoxDecoration(
                                      color: aPriceTextColor.withOpacity(0.18),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(
                                          color: aTextColor, width: 0.1),
                                    ),
                                    child: Icon(Icons.delete_outline_outlined,color: aPriceTextColor,size: 18,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
