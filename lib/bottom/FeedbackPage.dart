import 'package:flutter/material.dart';
import '../homepage/myhome_page.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
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

    if(feedbackText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Text('Please Enter Your FeedBacks',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
              Icon(Icons.security, size: 50, color: Colors.yellow),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Text('Thank For You FeedBack',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
              Icon(Icons.error_outline, size: 50, color: Colors.yellow),
            ],
          ),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        // Navigate to the PDF viewer page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          const Text(
            'How satisfied are you with the app?',
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.sentiment_very_dissatisfied, size: 40,color: Colors.yellow,),
                onPressed: () {

                },
              ),
              IconButton(
                icon: const Icon(Icons.sentiment_dissatisfied, size: 40,color: Colors.red,),
                onPressed: () {

                },
              ),
              IconButton(
                icon: const Icon(Icons.sentiment_neutral, size: 40,color: Colors.green,),
                onPressed: () {

                },
              ),
              IconButton(
                icon: const Icon(Icons.sentiment_satisfied, size: 40,color: Colors.blue,),
                onPressed: () {

                },
              ),
              IconButton(
                icon: const Icon(Icons.sentiment_very_satisfied, size: 40,color: Colors.purple,),
                onPressed: () {
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
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
              backgroundColor: Colors.blue, // Set text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Adjust corner radius
              ),
              minimumSize: const Size(350.0, 50.0), // Set button size
            ),
            child: const Text('Submit'),
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



