import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../homepage/myhome_page.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
        children:[

          Image.asset('assets/images/icons8-activity-feed-50.png',
          width: 50,
            height: 50,
          ),

           const SizedBox(height: 25),

           Text(
            'Tell us the problem you encountered',
             style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 25),


           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: (){},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black12,
                    foregroundColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Too few features',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                  ),
              ),

              const SizedBox(width: 18),

              TextButton(onPressed: (){},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black12,
                  foregroundColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('File open failed',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                ),
              ),

            ],
          ),

          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextButton(onPressed: (){},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black12,
                  foregroundColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Slow responses',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(width: 18),

              TextButton(onPressed: (){},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black12,
                  foregroundColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Crash & Bugs',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                ),
              ),

            ],
          ),

          const  SizedBox(height:15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(onPressed: (){},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black12,
                  foregroundColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Others',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: TextFormField(
              controller: _feedbackController,
              decoration:  InputDecoration(
                hintText: 'Enter your feedback...',
                hintStyle:GoogleFonts.poppins() ,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),

                prefixIcon: Padding(
                  padding:const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      onPressed: (){},
                    ),
                  ),
                )
              ),
              maxLines: 12,



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



