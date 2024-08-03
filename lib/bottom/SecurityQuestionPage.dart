import 'package:flutter/material.dart';

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
        title: const Text('Security Questions',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Answer the security questions:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),),
                  const SizedBox(height: 40),
                  _buildSecurityQuestionDropdown(),
                  const SizedBox(height: 30),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _selectedAnswer = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter your answer',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedSecurityQuestion != null && _selectedAnswer != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Row(
                              children: [
                                Text('Thank for your Answer!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                Icon(Icons.gpp_good, size: 40, color: Colors.yellow), // Adjust size and color as needed
                              ],
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      }
                      else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Row(
                              children: [
                                Text('Please select a security \n question and enter an answer',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                Icon(Icons.error_outline, size: 40, color: Colors.yellow), // Adjust size and color as needed
                              ],
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text('OK'),
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
      hint: const Text('Select a security question',style: TextStyle(fontWeight: FontWeight.bold),),
    );
  }
}
