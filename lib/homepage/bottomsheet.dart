import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class  bottomsheet extends StatefulWidget {
  const  bottomsheet({super.key});

  @override
  State<bottomsheet> createState() => _bottomsheetState();
}

class _bottomsheetState extends State<bottomsheet> {
  bool isSwitched = false;
  bool _isSelected = false;
  bool _isSelected1 = false;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        const SizedBox(height: 15,),

          ListTile(
            title: Text('View mode',
              style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
                fontSize: 25,
            ),
            ),
          ),
          const SizedBox(height: 15),

          Row(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              IconButton(onPressed: (){
                setState(() {
                  _isSelected = !_isSelected;
                });
              },
                  style: IconButton.styleFrom(
                    foregroundColor: _isSelected ? Colors.black : Colors.white,
                    backgroundColor: _isSelected ? Colors.black12 : Colors.blue,
                  ),
                  iconSize: 55,
                  icon: const Icon(Icons.swap_horiz)),

              const SizedBox(width: 88,),

              IconButton(onPressed: (){
                setState(() {
                  _isSelected1 = !_isSelected1;
                });
              },
                  style: IconButton.styleFrom(
                      foregroundColor: _isSelected1 ? Colors.white : Colors.black,
                      backgroundColor: _isSelected1 ? Colors.blue : Colors.black12,
                  ),
                  iconSize: 55,
                  icon: const Icon(Icons.swap_vert)),
            ],
          ),

         const SizedBox(height:15),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text('Horizontal',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
              ),

             const SizedBox(width: 78,),

              Text('Vertical',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),

            ],
          ),

          const SizedBox(height: 45,),

           Row(
            children: [
              const SizedBox(width: 25,),
              const Icon(Icons.wrap_text,
              color: Colors.blue,
                size: 28,
              ),

              const SizedBox(width: 20,),

              Text('Reflow',style:GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              )),

              const SizedBox(width: 190,),

              Switch(value: isSwitched,
                  onChanged: (value) => setState(() {

                  }),
              ),
            ],
          ),

          const SizedBox(height: 20,),

          Row(
            children: [
              const SizedBox(width: 25,),
              const Icon(Icons.pages_outlined,
                color: Colors.blue,
                size: 28,
              ),

              const SizedBox(width: 20,),

              Text('Page by page',style:GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              )),

              const SizedBox(width: 106,),

              Switch(value: isSwitched,
                onChanged: (value) => setState(() {

                }),
              ),
            ],
          ),

          const SizedBox(height: 20,),

          Row(
            children: [
              const SizedBox(width: 25,),
              const Icon(Icons.color_lens_outlined,
                color: Colors.blue,
                size: 28,
              ),

              const SizedBox(width: 20,),

              Text('Color inversion',style:GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              )),


              const SizedBox(width: 94,),

              Switch(value: isSwitched,
                onChanged: (value) => setState(() {

                }),
              ),
            ],
          ),


          const SizedBox(height: 45,),

        ],
      ),
    );
  }
}
