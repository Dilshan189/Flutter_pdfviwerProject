import 'package:flutter/material.dart';
import 'package:pdfviwer/test_page/browserpage.dart';
import 'package:share/share.dart';

import '../bottom/FeedbackPage.dart';
import '../bottom/featureRequset.dart';
import '../notifier/notifiers.dart';
import '../test_page/favorite.dart';
import '../test_page/recent.dart';
import '../test_page/test.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _imagePath = 'assets/images/image.png';

  int _selectedIndex = 0;
  String appBarTitle = 'Home';
  bool isScreenKeptOn = false;
  bool showSubmitButton = false;

  List<Widget> widgetList = const [

    browserpage(),
    recent(),
    favorite(),
    tools(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),


        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),


          IconButton(
            icon: const Icon(Icons.credit_score_outlined),
            onPressed: () {},
          ),
        ],
      ),



      /// Added Drawer////////////////////////////////////////////////////////


      drawer: Drawer(
        child: ListView(
          children: <Widget>[

            const ListTile(
              title: Text('PDF Reader',
               style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),
               ),
            ),

            const Divider(thickness: 1),

            ListTile(
              title: const Text('Browse PDF',style: TextStyle(fontWeight: FontWeight.bold)),
              leading: const Icon(Icons.folder_open,color: Colors.blue,),
              onTap: () {

              },
            ),


            ListTile(
              leading: const Icon(Icons.ios_share_rounded, color: Colors.blue,),
              title: const Text('Share App', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                final RenderBox box = context.findRenderObject() as RenderBox;
                Share.share('Hi , Im using PDF Reader. Its so easy and convenient to view & edit PDFs...',
                    subject: 'PDF Viewer App',
                    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
              },
            ),



        GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/securityQuestionPage');
        },
          child: SwitchListTile(
                title: const Text('Security question',style: TextStyle(fontWeight: FontWeight.bold)),
                secondary: const Icon(Icons.security_outlined,color: Colors.blue,),
                value: isScreenKeptOn,
                onChanged: (abl) {
                  setState(() {
                    isScreenKeptOn = abl;
                  });
                },
              ),
            ),



            ListTile(
              title: const Text('Language Options',style: TextStyle(fontWeight: FontWeight.bold)),
              leading: const Icon(Icons.language_outlined,color: Colors.blue,),
              onTap: () {

              },
            ),

            SwitchListTile(
              title: const Text('DarkMode', style: TextStyle(fontWeight: FontWeight.bold)),
              secondary: const Icon(Icons.dark_mode_outlined, color: Colors.blue),
              value: isDarkModelNotifier.value,
              onChanged: (val) {
                isDarkModelNotifier.value = !isDarkModelNotifier.value;
                setState(() {});
              },
            ),


            ListTile(
              title: const Text('FAQ',style: TextStyle(fontWeight: FontWeight.bold)),
              leading: const Icon(Icons.question_answer_outlined,color: Colors.blue,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const featureRequset()),
                );
              },
            ),


            ListTile(
              title: const Text('Feedback',style: TextStyle(fontWeight: FontWeight.bold)),
              leading: const Icon(Icons.feedback_outlined,color: Colors.blue,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FeedbackPage()),
                );
              },
            ),

            ListTile(
              title: const Text('Request a new feature',style: TextStyle(fontWeight: FontWeight.bold)),
              leading: const Icon(Icons.file_copy_outlined,color: Colors.blue,),
              onTap: () =>  showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 9.5,
                    height: MediaQuery.of(context).size.height * 20.0,
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          _imagePath,
                          width: 100.0,
                          height: 100.0,
                        ),

                        const SizedBox(height: 10.0),

                        const Text(
                          'What other features do you want?',
                          style: TextStyle(fontSize: 22.0,),
                        ),

                        const SizedBox(height: 16.0),

                        const Text(
                          'Well prioritize adding the features you want',
                          style: TextStyle(fontSize: 15.0, ),
                        ),

                        const SizedBox(height: 20.0),



                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {


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
                },
              ),
            ),


            const Divider(thickness: 1),

            const ListTile(
              title: Text('Settings',
                style: TextStyle(fontSize: 16.0),
              ),
            ),



            SwitchListTile(
              title: const Text('Keep screen on',style: TextStyle(fontWeight: FontWeight.bold)),
                value: isScreenKeptOn,
                onChanged: (val) {
                setState(() {
                  isScreenKeptOn = val;
                });
              }
            ),

            const ListTile(
              title: Text('Version:1.3.8L',
                style: TextStyle(fontSize: 16.0),
              ),
            ),

          ],
        ),
      ),



      ///Added bottomnavigattionbar//////////////////////////////////////////


      body: widgetList[_selectedIndex], // Use the selected widget for the body
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.file_open_outlined),
            label: 'All files',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later_outlined),
            label: 'Recent',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favourite', // Rename for clarity
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.apps_rounded),
            label: 'Tools', // Rename for clarity
          ),

        ],


        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          appBarTitle = 'All files';
          break;
        case 1:
          appBarTitle = 'Recent';
          break;
        case 2:
          appBarTitle = 'Favourite';
          break;
        case 3:
          appBarTitle = 'Tools';
          break;
      }
    });
  }
}


