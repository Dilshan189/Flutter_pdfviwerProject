import 'package:flutter/material.dart';

class favorite extends StatelessWidget {
  const favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/paper_2.png',
          width: 500,
          height: 300,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add,color:Colors.white),
      ),
    );
  }
}
