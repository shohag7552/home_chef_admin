import 'package:flutter/material.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/NavBar_Screens/categoryPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_chef_admin/NavBar_Screens/homePage.dart';
import 'package:home_chef_admin/NavBar_Screens/orderPage.dart';
import 'package:home_chef_admin/NavBar_Screens/productPage.dart';
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedItem = 0;

  PageController _pageController = PageController();

  List<Widget> _page = [HomePage(), CategoryPage(), ProductPage(),OrderPage()];

  void _onPageChange(int index) {
    setState(() {
      return _selectedItem = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: aBackgroundColor,

      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChange,
          children: _page,
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          navigationIcon("assets/home.svg", 'Home', 0),
          navigationIcon("assets/category.svg", 'Categories', 1),
          navigationIcon("assets/products.svg", 'Products', 2),
          navigationIcon("assets/Orders.svg", 'Orders', 3),
        ],
      ),
    );
  }

  Widget navigationIcon(String icon, String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItem = index;
          _pageController.jumpToPage(_selectedItem);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: aNavBarColor,
          border: Border.all(color: aBlackCardColor,width: 0.003)
        ),
        height: 60,
        width: MediaQuery.of(context).size.width / 4,
        child: Column(
          children: [
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: index == _selectedItem ? aBlackCardColor : aNavBarColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: SvgPicture.asset(
                  icon,
                  color: index == _selectedItem ? aPrimaryColor  : aBlackCardColor,
                  height: 21,
                  width: 21,
                ),
              ),
            ),
            Text(
              name,
              style: TextStyle(
                  color: index == _selectedItem ? aBlackCardColor : aBlackCardColor,
                  fontSize: 13.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: index == _selectedItem ? FontWeight.w500 : FontWeight.w400
              ),
            ),
          ],
        ),
      ),
    );
  }
}
