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
  bool isScreenKeptOn = false;

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




            SwitchListTile(
              title: const Text('Security question',style: TextStyle(fontWeight: FontWeight.bold)),
              secondary: const Icon(Icons.security_outlined,color: Colors.blue,),
              value: isScreenKeptOn,
              onChanged: (abl) {
                setState(() {
                  isScreenKeptOn = abl;
                });
              },
            ),



            ListTile(
              title: const Text('Language Options',style: TextStyle(fontWeight: FontWeight.bold)),
              leading: const Icon(Icons.language_outlined,color: Colors.blue,),
              onTap: () {

              },
            ),

            SwitchListTile(
              title: const Text('DarkMode', style: TextStyle(fontWeight: FontWeight.bold)),
              secondary: const Icon(Icons.dark_mode, color: Colors.blue),
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

              },
            ),


            ListTile(
              title: const Text('Feedback',style: TextStyle(fontWeight: FontWeight.bold)),
              leading: const Icon(Icons.feedback_outlined,color: Colors.blue,),
              onTap: () {

              },
            ),


            ListTile(
              title: const Text('Request a new feature',style: TextStyle(fontWeight: FontWeight.bold)),
              leading: const Icon(Icons.file_copy_outlined,color: Colors.blue,),
              onTap: () {

              },
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


