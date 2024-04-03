import 'package:flutter/material.dart';
import 'package:pdfviwer/test_page/browserpage.dart';
import 'package:share/share.dart';

import '../bottom/FeedbackPage.dart';
import '../bottom/SecurityQuestionPage.dart';
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


  int _selectedIndex = 0;
  String appBarTitle = 'Home';

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
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('John Doe'),
              accountEmail: Text('johndoe@example.com'),
              currentAccountPicture: CircleAvatar(
                child: FlutterLogo(),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.folder_copy_outlined, color: Colors.blue,),
              title: const Text('Browse PDF', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const browserpage()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.ios_share_rounded, color: Colors.blue,),
              title: const Text('Share App', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                final RenderBox box = context.findRenderObject() as RenderBox;
                Share.share('Check out this awesome PDF Viewer app!',
                    subject: 'PDF Viewer App',
                    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
              },
            ),


            ListTile(
              title: const Text('DarkMode',style: TextStyle(fontWeight: FontWeight.bold)),
              leading: const Icon(Icons.dark_mode,color: Colors.blue,),
              onTap: () {
                isDarkModelNotifier.value = !isDarkModelNotifier.value;
                setState(() {
                  },
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.security, color: Colors.blue,),
              title: const Text('Security Question', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecurityQuestionPage()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.feedback_outlined, color: Colors.blue,),
              title: const Text('Feedback', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FeedbackPage()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.devices_fold_outlined, color: Colors.blue),
              title: const Text(
                'Request a new feature',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              elevation: 5,
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset(
                                  'assets/images/your_image.png',
                                  width: 200,
                                  height: 200,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),

          ],
        ),
      ),



      ///Added bottomnavigattionbar//////////////////////////////////////////


      body: widgetList[_selectedIndex], // Use the selected widget for the body
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            label: 'Recent',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite', // Rename for clarity
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.apps_rounded),
            label: 'Favourite', // Rename for clarity
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
          appBarTitle = 'Home';
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


