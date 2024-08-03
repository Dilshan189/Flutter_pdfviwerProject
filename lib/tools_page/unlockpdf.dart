import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../homepage/search_bar.dart';

class unlockpdf extends StatelessWidget {
  const unlockpdf({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a file ',style: TextStyle(fontSize:20,color: Colors.black,fontWeight: FontWeight.w500),),
        actions: [IconButton(onPressed: (){
          Get.to(()=> const Searchbar());
        },
            icon: const  Icon(Icons.search_rounded))],
      ),
    );
  }
}
