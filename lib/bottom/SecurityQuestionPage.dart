import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../homepage/myhome_page.dart';

class SecurityQuestionPage extends StatefulWidget {
  const SecurityQuestionPage({Key? key}) : super(key: key);

  @override
  _SecurityQuestionPageState createState() => _SecurityQuestionPageState();
}

class _SecurityQuestionPageState extends State<SecurityQuestionPage> {
  String? _selectedSecurityQuestion;
  String? _selectedAnswer;

  final List<String> _securityQuestions = [
    'What is your favorite color?',
    'What is your lucky number?',
    'Where is your birthplace?',
    'What is your favorite book?',
    'What is your pet\'s name?',
    'What is your Name?',
    'How Old Are you?',
    'What are you doing Now?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security Questions',style:GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),

          child: Card(
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [

                  const SizedBox(height: 50),

                   Text('Answer the security Questions',style:GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 20)),

                  const SizedBox(height: 30),

                  _buildSecurityQuestionDropdown(),


                  const SizedBox(height: 30),

                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _selectedAnswer = value;
                      });

                    },

                    decoration: InputDecoration(
                      labelText: 'Enter your answer',
                      labelStyle:GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      border: const OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 50),

                  const Icon( Icons.mood_outlined  ,size: 50,weight: 500.04,color: Colors.blue,),

                  const SizedBox(height: 50),


                  ElevatedButton(
                    onPressed: ()
                    {
                      if (_selectedSecurityQuestion != null && _selectedAnswer != null)
                      {

                        Get.snackbar('Very Good', 'Thank for your Answer',backgroundColor: Colors.black12);

                        Get.to(()=> const MyHomePage());
                      }

                      else

                      {
                        Get.snackbar('Select the security Question..',''
                            'Enter your Answer..',backgroundColor: Colors.black12);
                      }
                    },
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
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityQuestionDropdown() {
    return DropdownButton<String>(
      dropdownColor: Colors.white,
      focusColor: Colors.grey,
      isExpanded: true,
      value: _selectedSecurityQuestion,
      onChanged: (String? newValue) {
        setState(() {
          _selectedSecurityQuestion = newValue;
        });
      },
      items: _securityQuestions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
            hint: Text('Select the Question',style: GoogleFonts.poppins(fontWeight: FontWeight.w400),),
    );
  }
}
