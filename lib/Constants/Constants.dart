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

//Edit Category

const editPageTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);

List<BoxShadow> customShadow = [
  BoxShadow(
      color: Colors.white.withOpacity(0.5),
      spreadRadius: 5,
      offset: Offset(-5, -5),
      blurRadius: 20),
  BoxShadow(
      color: aBlackCardColor.withOpacity(0.5),
      spreadRadius: -4,
      offset: Offset(3, 3),
      blurRadius: 10),
];
