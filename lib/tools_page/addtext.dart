import 'package:flutter/material.dart';

class addtext extends StatelessWidget {
  const addtext({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a file ',style: TextStyle(fontSize:20,color: Colors.black,fontWeight: FontWeight.w500),),
        actions: [IconButton(onPressed: (){},
            icon: const  Icon(Icons.search_rounded))],
      ),
    );
  }
}
