import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'homepage/myhome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  changeScreen(){
    Future.delayed(const Duration(seconds: 3),(){
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
              alignment: Alignment.center,child: Image.asset('assets/images/icon.png',width:100,height: 150,),
            ),
            const SizedBox(height: 310,),

            const SizedBox(
              height: 2,
                width: 350,
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  backgroundColor: Colors.grey,
                  minHeight: 5,

                )
            ),

            const SizedBox(height: 10,),
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('PDF Reader',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,),)
                ],
              ),
            ),
            const SizedBox(height: 20,),
          ],
        ),

      ),

    );

  }
}

