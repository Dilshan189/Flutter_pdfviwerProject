import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'homepage/myhome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  changeScreen(){
    Future.delayed(const Duration(seconds: 6),(){
      Get.to(()=>const MyHomePage ());
    });
  }

  @override
  void initState(){
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.center,
              child: Lottie.asset('assets/icon/Animation - 1722678542638.json',),
            ),
            const SizedBox(height: 100,),
            const SizedBox(
              height: 5,
              width: 10,
            ),
            const SizedBox(height: 5,),
             Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'PDF Reader',
                    style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 225, 28, 10)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
