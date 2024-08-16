import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class unlockmsg extends StatefulWidget {
  const unlockmsg({super.key});

  @override
  State<unlockmsg> createState() => _unlockmsgState();
}

class _unlockmsgState extends State<unlockmsg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pop();
          },
            style: IconButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.black26,

                shape: const CircleBorder(
                    side: BorderSide(
                        style: BorderStyle.solid
                    )
                )
            ),
            icon:const Icon(Icons.clear_rounded,size: 27,color: Colors.white,),
          ),
        ],
      ),

      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset('assets/icon/success.json',
                width: 260,
                height: 250,
              ),
            ),
            Text(
              'Unlocked Successfully!',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ) ,
    );;
  }
}
