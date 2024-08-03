import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'consts/consts.dart';
import 'our_button.dart';

Widget exitDialog(contex){

  return Dialog(
    child: Column(
      mainAxisSize:MainAxisSize.min ,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        "Are you sure to exit?".text.size(15).color(darkFontGrey).make(),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(color: redColor,onPress: (){
              SystemNavigator.pop();
            } ,textColor: whiteColor,title: "Yes"),
            ourButton(color: redColor,onPress: (){
              Navigator.pop(contex);
            } ,textColor: whiteColor,title: "No"),
          ],
        ),
      ],
    )   .box
        .color(lightGrey).padding(const EdgeInsets.all(12))
        .roundedSM.make(),
  );
}

