import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../homepage/myhome_page.dart';

class featureRequset extends StatefulWidget {
  const featureRequset({Key? key}) : super(key: key);

  @override
  State<featureRequset> createState() => _FeatureRequestScreenState();
}

class _FeatureRequestScreenState extends State<featureRequset> {

String? _selectedfaq;
String? _typefaq;




  final List<String> _categories = [
    'Too few features',
    'File open failed',
    'Slow responses',
    'Crashes & Bugs',
    'Others'
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset('assets/images/icons8-key-40.png',
                    width: 110,
                    height:100,
                  ),
                ),

              ],
            ),

             Text(
              'Tell us the problem you encountered',
              style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w400),
            ),

            const SizedBox(height: 10.0),


            _buildFaqQuestionDropdown(),

            const SizedBox(height: 10.0),


              TextField(

                onChanged: (value) {
                  setState(() {
                    _typefaq = value;
                  });
                },

              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 55,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Please tell us more details so that we can locate and solve your problem faster (at least 6 characters)',
                hintStyle:GoogleFonts.poppins(fontWeight: FontWeight.w400),
              ),
            ),

            const SizedBox(height: 10.0),

            ElevatedButton(
              onPressed:(){

                if(_selectedfaq != null && _typefaq != null)
                {

                  Get.snackbar('Very Good', 'Thank for your Answer',backgroundColor: Colors.black12);

                  Get.to(()=> const MyHomePage());

                }

                else

                  {

                    Get.snackbar('Select the FAQ Question..',''
                        'Enter your Answer..',backgroundColor: Colors.black12);

                  }



              } ,
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(350, 50)
              ),
              child: Text('Submit',style:GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 18)),


            ),

          ],
        ),
      ),
    );
  }

  Widget _buildFaqQuestionDropdown() {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      focusColor: Colors.grey,
      isExpanded: true,
      value: _selectedfaq,
      onChanged: (String? newValue) {
        setState(() {
          _selectedfaq = newValue;
        });
      },
      items:_categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Select Category',
        labelStyle: GoogleFonts.poppins(),
      ),
    );
  }

}
