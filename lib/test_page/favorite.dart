import 'package:flutter/material.dart';

import '../floatingactionbutton/floationactionbutton.dart';

class favorite extends StatefulWidget {
  const favorite({super.key});

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/paper_2.png',
          width: 500,
          height: 300,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const actionbutton();
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add,color:Colors.white),
      ),
    );
  }
}
