import 'package:flutter/material.dart';
import 'package:pdfviwer/consts/consts.dart';
import '../consts/colors.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: lightGrey,
      title: Container(
        alignment: Alignment.center,
        height: 40,
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            suffixIcon: Icon(Icons.search, color: Colors.black26),
            // added search Button
            filled: true,
            fillColor: whiteColor,
            hintText: searchanything,
            hintStyle: TextStyle(color: textfieldGrey),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          ),
        ),
      ),
    ),
    );
  }
}