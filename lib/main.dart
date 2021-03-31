import 'package:flutter/material.dart';
import 'package:home_chef_admin/Constants/Constants.dart';
import 'package:home_chef_admin/Constants/MainPage.dart';
import 'package:home_chef_admin/Provider/categories_provider.dart';
import 'package:home_chef_admin/Provider/category_provider.dart';
import 'package:home_chef_admin/Provider/order_provider.dart';
import 'package:home_chef_admin/Provider/profile_provider.dart';
import 'package:home_chef_admin/Provider/totalOrder_provider.dart';
import 'package:home_chef_admin/Provider/totalUser_provider.dart';
import 'package:home_chef_admin/Screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: MyApp(),
    ),
  );
}
List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
  ChangeNotifierProvider<TotalUserProvider>(create: (_) => TotalUserProvider()),
  ChangeNotifierProvider<TotalOrderProvider>(create: (_) => TotalOrderProvider()),
  ChangeNotifierProvider<OrderProvider>(create: (_) => OrderProvider()),
  ChangeNotifierProvider<CategoriesProvider>(create: (_) => CategoriesProvider()),
  ChangeNotifierProvider<CategoryProvider>(create: (_) => CategoryProvider()),
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        primaryColor: aPrimaryColor,
      ),
      home: LoginPage(),
    );
  }
}
