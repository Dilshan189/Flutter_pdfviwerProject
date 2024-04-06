import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class featureRequset extends StatefulWidget {
  const featureRequset({Key? key}) : super(key: key);

  @override
  State<featureRequset> createState() => _FeatureRequestScreenState();
}

class _FeatureRequestScreenState extends State<featureRequset> {

  final String _imagePath = 'assets/images/image.png';
  int _selectedCategory = 0;
  final List<String> _categories = [
    'Too few features',
    'File open failed',
    'Slow responses',
    'Crashes & Bugs',
    'Others'
  ]; // List of category options


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SingleChildScrollView( // Ensures scrollable content if needed
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Center(
                  child: Image.asset(
                    _imagePath,
                    width: 80,
                    height:80,
                  ),
                ),

              ],
            ),

            const Text(
              'Tell us the problem you encountered',
              style: TextStyle(fontSize: 20.0 ,color: Colors.black),
            ),

            const SizedBox(height: 10.0),
            DropdownButtonFormField<String>(
              value: _categories[_selectedCategory],
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );

              }).toList(),
              onChanged: (String? newCategory) {
                setState(() {
                  _selectedCategory = _categories.indexOf(newCategory!);
                });

              },

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select Category',
              ),
            ),

            const SizedBox(height: 10.0),


            const TextField(
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 55,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Please tell us more details so that we can locate and solve your problem faster (at least 6 characters)',
              ),
            ),

            const SizedBox(height: 10.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 350.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Text(
                          'Submit',
                      style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),

          ],
        ),
      ),
    );
  }
}
