import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//home page
const Color aNavBarColor = Color(0xFFFFFFFF);
const Color aPrimaryColor = Color(0xFFFEC61C);
const Color aSearchFieldColor = Color(0xFFF4F4F4);
const Color aBackgroundColor = Color(0xFFF4F4F4);
const Color aBlackCardColor = Color(0xFF1A1A1A);
const Color aTextColor = Color(0xFF1A1A1A);
const Color aPriceTextColor = Color(0xFFA53034);

//profile picture url
 const String profileImageUri = "https://homechef.antapp.space/avatar";

//Edit Category

const editPageTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);

//Popup menue

class Constants{
  static const String Edit = 'Edit';
  static const String Delete = 'Delete';

  static const List<String> choices = <String>[
    Edit,
    Delete
  ];
}
class AdminConstants{
  static const String Edit = 'Edit';
  static const String Delete = 'Delete';

  static const List<String> choices = <String>[
    Edit,
    Delete
  ];
}
