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
                  MaterialPageRoute(builder: (context) => const SecurityQuestionPage()),
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
              onTap: () => showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                   bool showSubmitButton = true;
                  return Container(
                    width: MediaQuery.of(context).size.width * 9.5,
                    height: MediaQuery.of(context).size.height * 20.0,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),

                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              Row(
                                children: [
                                  SizedBox(width: 10.0),
                                  Text('What Other features do you want?'
                                      ' \n Well prioritize adding the features you want'),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              Card(
                                child: TextButton.icon(
                                  onPressed: () => {
                                    ListTile(
                                      title: const Text('Request a new feature',style: TextStyle(fontWeight: FontWeight.bold)),
                                      leading: const Icon(Icons.file_copy_outlined,color: Colors.blue,),
                                      onTap: () => showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {



                                          return Container(
                                            width: MediaQuery.of(context).size.width * 9.5,
                                            height: MediaQuery.of(context).size.height * 20.0,
                                            padding: const EdgeInsets.all(20.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),

                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [

                                                  const Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [

                                                      Row(
                                                        children: [
                                                          SizedBox(width: 10.0),
                                                          Text('What Other features do you want?'
                                                              ' \n Well prioritize adding the features you want'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10.0),

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [

                                                      Card(
                                                        child: TextButton.icon(
                                                          onPressed: () => {
                                                            showSubmitButton = true,
                                                            setState(() {})
                                                          },
                                                          icon: const Icon(Icons.comment_bank_outlined),
                                                          label: const Text('Contents'),
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Colors.black,
                                                          ),
                                                        ),
                                                      ),

                                                      Card(
                                                        child: TextButton.icon(
                                                          onPressed: () => {},
                                                          icon: const Icon(Icons.picture_as_pdf_outlined),
                                                          label: const Text('PDF to Image'),
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Colors.black,
                                                          ),
                                                      ),
                                                    ),
                                                  ],),

                                                  const SizedBox(height: 10.0),

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [

                                                      Card(
                                                        child: TextButton.icon(
                                                          onPressed: () => {
                                                            showSubmitButton = true,
                                                            setState(() {})
                                                          },
                                                          icon: const Icon(Icons.document_scanner_outlined),
                                                          label: const Text('Scan to PDF'),
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Colors.black,

                                                          ),
                                                        ),
                                                      ),

                                                      Card(
                                                        child: TextButton.icon(
                                                          onPressed: () => {
                                                            showSubmitButton = true,
                                                            setState(() {})
                                                          },
                                                          icon: const Icon(Icons.cloud_done_outlined),
                                                          label: const Text('Cloud Sync'),
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Colors.black,
                                                          ),
                                                      ),
                                                      ),],
                                                  ),

                                                  const SizedBox(height: 10.0),

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [

                                                      Card(
                                                        child: TextButton.icon(
                                                          onPressed: () => {
                                                            showSubmitButton = true,
                                                            setState(() {})
                                                          },
                                                          icon: const Icon(Icons.create_new_folder_outlined),
                                                          label: const Text('Create Folders'),
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Colors.black,
                                                          ),
                                                          ),
                                                      ),


                                                      Card(
                                                        child: TextButton.icon(
                                                          onPressed: () => {
                                                            showSubmitButton = true,
                                                            setState(() {})
                                                          },
                                                          icon: const Icon(Icons.offline_bolt_outlined),
                                                          label: const Text('Others'),
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Colors.black,
                                                          ),
                                                          ),
                                                      ),
                                                    ],
                                                  ),


                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [

                                                      Card(
                                                        child: TextButton.icon(
                                                          onPressed: () => {
                                                            showSubmitButton = true,
                                                            setState(() {})
                                                          },
                                                          icon: const Icon(Icons.color_lens_outlined),
                                                          label: const Text('Page Color'),
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Colors.black,
                                                          ),
                                                          ),
                                                      ),


                                                      Card(
                                                        child: TextButton.icon(
                                                          onPressed: () => {
                                                            showSubmitButton = true,
                                                            setState(() {})
                                                          },
                                                          icon: const Icon(Icons.edit_note_sharp),
                                                          label: const Text('Co-editing'),
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Colors.black,
                                                          ),
                                                          ),
                                                      ),
                                                    ],
                                                  ),

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [

                                                      Card(
                                                        child: TextButton.icon(
                                                          onPressed: () => {
                                                            showSubmitButton = true,
                                                            setState(() {})
                                                          },
                                                          icon: const Icon(Icons.edit),
                                                          label: const Text('Signature'),
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Colors.black,),
                                                          ),
                                                      ),


                                                      Card(
                                                        child: TextButton.icon(
                                                          onPressed: () => {
                                                            showSubmitButton = true,
                                                            setState(() {})
                                                          },
                                                          icon: const Icon(Icons.ac_unit_rounded),
                                                          label: const Text('Adjust Pages'),
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Colors.black,),
                                                          ),
                                                      ),
                                                    ],
                                                  ),

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [

                                                      Card(
                                                        child: TextButton.icon(
                                                          onPressed: () => {
                                                            showSubmitButton = true,
                                                            setState(() {})
                                                          },
                                                          icon: const Icon(Icons.text_fields_outlined),
                                                          label: const Text('OCR'),
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Colors.black,),
                                                          ),
                                                      ),


                                                      Card(
                                                        child: TextButton.icon(
                                                          onPressed: () => {
                                                            showSubmitButton = true,
                                                            setState(() {})
                                                          },
                                                          icon: const Icon(Icons.recycling_outlined),
                                                          label: const Text('Recycle Bin'),
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Colors.black,),
                                                          ),
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(height: 10.0),
                                                  if(showSubmitButton)
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {

                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: Colors.blue,
                                                          minimumSize: const Size(350.0, 50.0),

                                                        ),
                                                        child:const Text('Submit'),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  },

                                  icon: const Icon(Icons.comment_bank_outlined),
                                  label: const Text('Contents'),
                                ),
                              ),

                              Card(
                                child: TextButton.icon(
                                  onPressed: () => {},
                                  icon: const Icon(Icons.picture_as_pdf_outlined),
                                  label: const Text('PDF to Image'),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              Card(
                                child: TextButton.icon(
                                  onPressed: () => {},
                                  icon: const Icon(Icons.document_scanner_outlined),
                                  label: const Text('Scan to PDF'),
                                ),
                              ),

                              Card(
                                child: TextButton.icon(
                                  onPressed: () => {},
                                  icon: const Icon(Icons.cloud_done_outlined),
                                  label: const Text('Cloud Sync'),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Card(
                                child: TextButton.icon(
                                  onPressed: () => {},
                                  icon: const Icon(Icons.create_new_folder_outlined),
                                  label: const Text('Create Folders'),
                                ),
                              ),


                              Card(
                                child: TextButton.icon(
                                  onPressed: () => {},
                                  icon: const Icon(Icons.offline_bolt_outlined),
                                  label: const Text('Others'),
                                ),
                              ),
                            ],
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Card(
                                child: TextButton.icon(
                                  onPressed: () => {},
                                  icon: const Icon(Icons.color_lens_outlined),
                                  label: const Text('Page Color'),
                                ),
                              ),


                              Card(
                                child: TextButton.icon(
                                  onPressed: () => {},
                                  icon: const Icon(Icons.edit_note_sharp),
                                  label: const Text('Co-editing'),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Card(
                                child: TextButton.icon(
                                  onPressed: () => {},
                                  icon: const Icon(Icons.edit),
                                  label: const Text('Signature'),
                                ),
                              ),


                              Card(
                                child: TextButton.icon(
                                  onPressed: () => {},
                                  icon: const Icon(Icons.ac_unit_rounded),
                                  label: const Text('Adjust Pages'),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Card(
                                child: TextButton.icon(
                                  onPressed: () => {},
                                  icon: const Icon(Icons.text_fields_outlined),
                                  label: const Text('OCR'),
                                ),
                              ),


                              Card(
                                child: TextButton.icon(
                                  onPressed: () => {},
                                  icon: const Icon(Icons.recycling_outlined),
                                  label: const Text('Recycle Bin'),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {

                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  minimumSize: const Size(350.0, 50.0),

                                ),
                                child:const Text('Submit'),
                              ),
                            ],
                          ),

                        ],
                      ),
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


