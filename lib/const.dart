import 'package:flutter/material.dart';

const bgColor = Color(0xfff1f7fc);
const btnColor = Color(0xfff3a593);
const  bgdark = Color(0xff07d365);
const purpleColor = Color(0xff7975fd);
const  blueColor = Color(0xff09bff1);


const poppins = 'poppins';
const  poppinbold = 'poppins_bold';

TextStyle textStyle({color = Colors.black87,double? size = 16,font = poppinbold}){
  return  TextStyle(
    fontFamily: font,
    color: color,
    fontSize: size,
  );
}