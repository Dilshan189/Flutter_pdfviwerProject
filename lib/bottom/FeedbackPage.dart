import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../homepage/myhome_page.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback',style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
      ),
      body: const FeedbackForm(),
    );
  }
}

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final TextEditingController _feedbackController = TextEditingController();

  void _submitFeedback(BuildContext context) {
    String feedbackText = _feedbackController.text.trim();

    if(feedbackText.isEmpty)
    {


      Get.snackbar('Warning ** ','Please Enter your Feedback',backgroundColor: Colors.black12);


    }
    else{

       Get.snackbar('Very Good', 'Thank for your Feedback ',backgroundColor: Colors.black12);

      Future.delayed(const Duration(seconds: 0), () {

        Get.to(()=>const MyHomePage());

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

           Text(
            'How satisfied are you with the app?',
             style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w400),
          ),

          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.sentiment_very_dissatisfied, size: 40, color: Colors.pink),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: Lottie.asset(
                        width: 150,
                        height: 150,
                        'assets/icon/Animation - 1723713721850.json',
                      ),
                    ),
                  );
                },
              ),

              IconButton(
                icon: const Icon(Icons.sentiment_dissatisfied, size: 40,color: Colors.red,),
                onPressed: () {

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: Lottie.asset(
                        width: 170,
                        height: 170,
                        'assets/icon/Animation - 1722878584548.json',
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.sentiment_neutral, size: 40,color: Colors.green,),
                onPressed: () {

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: Lottie.asset(
                        'assets/icon/Animation - 1722878584548.json',
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.sentiment_satisfied, size: 40,color: Colors.blue,),
                onPressed: () {

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: Lottie.asset(
                        'assets/icon/Animation - 1722878584548.json',
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.sentiment_very_satisfied, size: 40,color: Colors.purple,),
                onPressed: () {

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: Lottie.asset(
                        'assets/icon/Animation - 1722878584548.json',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _feedbackController,
              decoration: const InputDecoration(
                hintText: 'Enter your feedback...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
          ),
          const SizedBox(height: 20),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              _submitFeedback(context);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              minimumSize: const Size(350.0, 50.0),
            ),
            child: Text('Submit',style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 18),),
          ),
        ],
      ),

        ],
      ),
    );
  }


  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}



