import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Provider/profile_provider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _visibleSwitchCondition = false;
  int _visibleValue = 0;
  bool _availabilitySwitchCondition = false;
  int _availabilityValue = 0;

  void visibleSwitch(bool value){
    if(_visibleSwitchCondition == false){
      setState(() {
        _visibleSwitchCondition = true;
        _visibleValue = 1;
      });
      print("visibleValue");
      print("$_visibleSwitchCondition");
      print("$_visibleValue");
    }else{
      setState(() {
        _visibleSwitchCondition = false;
        _visibleValue = 0;
      });
      print("visibleValue");
      print("$_visibleSwitchCondition");
      print("$_visibleValue");
    }
  }
  void availabilitySwitch(bool value){
    if(_availabilitySwitchCondition == false){
      setState(() {
        _availabilitySwitchCondition = true;
        _availabilityValue = 1;

      });
      print("availabilityValue");
      print("$_availabilitySwitchCondition");
      print("$_availabilityValue");
    }else{
      setState(() {
        _availabilitySwitchCondition = false;
        _availabilityValue = 0;
      });
      print("availabilityValue");
      print("$_availabilitySwitchCondition");
      print("$_availabilityValue");
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: aBackgroundColor,
      appBar: AppBar(
        backgroundColor: aNavBarColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset("assets/menu.svg"),
        ),
        title: Text('Product List'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1)),
              child: InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategory()));
                },
                child: Icon(Icons.add),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          CircleAvatar(
            radius: 22,
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
            child: Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: aSearchFieldColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
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
          SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 12,
            child: Container(
             // padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                spreadRadius: 5,
                                offset: Offset(-1, -1),
                                blurRadius: 20),
                            BoxShadow(
                                color: aBlackCardColor.withOpacity(0.8),
                                spreadRadius: -4,
                                offset: Offset(1, 1),
                                blurRadius: 7),
                          ],
                          color: aNavBarColor,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    ),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://homechef.masudlearn.com/category/icons/1691667780747339.jpg"))),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Burgers',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: aTextColor.withOpacity(0.5),
                                            ),
                                          ),
                                          Text(
                                            'BBQ Chicken Burger',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: aTextColor),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '\$${250.00}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: aPriceTextColor),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '\$${300.00}',
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: aTextColor
                                                        .withOpacity(0.5)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    color: aTextColor.withOpacity(0.3),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,

                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Visibility',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: aTextColor,
                                                ),
                                              ),
                                              Spacer(),
                                              Switch(
                                                  value: _visibleSwitchCondition,
                                                  onChanged: visibleSwitch,
                                                activeColor: aPrimaryColor,
                                                activeTrackColor: aTextColor,
                                                  ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Availability',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: aTextColor,
                                                ),
                                              ),
                                              Spacer(),
                                              Switch(
                                                value: _availabilitySwitchCondition,
                                                onChanged: availabilitySwitch,
                                                activeColor: aPrimaryColor,
                                                activeTrackColor: aTextColor,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
