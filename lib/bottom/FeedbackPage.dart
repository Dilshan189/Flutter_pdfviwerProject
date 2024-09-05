import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';


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
  bool _isSelected = false;
  bool _isSelected1 = false;
  bool _isSelected2 = false;
  bool _isSelected3 = false;
  bool _isSelected4 = false;
  final TextEditingController _feedbackController = TextEditingController();

  void _launchEmail(String feedbackText) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'dilshanrathnayaka089@gmail.com',
      query: 'subject=Feedback&body=${Uri.encodeComponent(feedbackText)}',
    );
    final url = params.toString();

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar('Error', 'Could not launch email client.');
    }
  }

  void _submitFeedback(BuildContext context) {
    String feedbackText = _feedbackController.text.trim();

    if (feedbackText.isEmpty) {
      Get.snackbar('Warning **', 'Please Enter your Feedback', backgroundColor: Colors.black12);
    } else {
      _launchEmail(feedbackText);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/icons8-activity-feed-50.png',
            width: 50,
            height: 50,
          ),
          const SizedBox(height: 25),
          Text(
            'Tell us the problem you encountered',
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _isSelected = !_isSelected;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: _isSelected ? Colors.blue : Colors.black12,
                  foregroundColor: _isSelected ? Colors.white : Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Too few features',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 18),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isSelected1 = !_isSelected1;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: _isSelected1 ? Colors.blue : Colors.black12,
                  foregroundColor: _isSelected1 ? Colors.white : Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'File open failed',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _isSelected2 = !_isSelected2;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: _isSelected2 ? Colors.blue : Colors.black12,
                  foregroundColor: _isSelected2 ? Colors.white : Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Slow responses',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 18),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isSelected3 = !_isSelected3;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: _isSelected3 ? Colors.blue : Colors.black12,
                  foregroundColor: _isSelected3 ? Colors.white : Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Crash & Bugs',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _isSelected4 = !_isSelected4;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: _isSelected4 ? Colors.blue : Colors.black12,
                  foregroundColor: _isSelected4 ? Colors.white : Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Others',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              controller: _feedbackController,
              decoration: InputDecoration(
                hintText:
                'Please tell us more details so that we can locate and solve your problem faster (at least 6 characters)',
                hintStyle: GoogleFonts.poppins(color: Colors.grey),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
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
                child: Text(
                  'Submit',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400, fontSize: 18),
                ),
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
