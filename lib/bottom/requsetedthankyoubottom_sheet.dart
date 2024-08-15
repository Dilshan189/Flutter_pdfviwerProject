import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sheet extends StatefulWidget {
  const Sheet({super.key});

  @override
  State<Sheet> createState() => _SheetState();
}

class _SheetState extends State<Sheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
      
            children: [
             const SizedBox(height: 80,),
              Image.asset('assets/images/icons8-chat-message-94.png')
            ],
          ),
           const SizedBox(height:15),
      
           Text('Thank you for your support!',style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 19),),
      
          const SizedBox(height:15),
      
          Text(
            textAlign: TextAlign.center,
            'We will do our best to bring a better user experience',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize:16,
              color: Colors.grey,
            ),
          ),
      
          const SizedBox(height:25),
      
          ElevatedButton(onPressed: (){
      
            Navigator.of(context).pop();
          },
      
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                  minimumSize:const Size(350, 55),
              ),
              child: Text('Submit',style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 16),))
        ],
      ),
    );
  }
}
