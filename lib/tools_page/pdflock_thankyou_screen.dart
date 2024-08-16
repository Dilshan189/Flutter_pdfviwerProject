import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class PdfLock extends StatefulWidget {
  const PdfLock({super.key});

  @override
  State<PdfLock> createState() => _PdfLockState();
}

class _PdfLockState extends State<PdfLock> {
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
              'Locked Successfully!',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ) ,
    );
  }
}
