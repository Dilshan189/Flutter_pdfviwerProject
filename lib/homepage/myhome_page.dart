import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdfviwer/bottom/SecurityQuestionPage.dart';
import 'package:pdfviwer/homepage/pdf_screen.dart';
import 'package:share/share.dart';
import '../bottom/FeedbackPage.dart';
import '../bottom/featureRequset.dart';
import '../notifier/notifiers.dart';
import '../test_page/browserpage.dart';
import '../test_page/favorite.dart';
import '../test_page/recent.dart';
import '../test_page/test.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  FilePickerResult? filePickerResult;
  final String _imagePath = 'assets/images/image.png';

  int _selectedIndex = 0;
  String appBarTitle = 'Home';
  bool isScreenKeptOn = false;
  bool showSubmitButton = false;
  bool isScreenKeptOff = false;


  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  List<String> pdfFiles = [];
  List<String> filteredPdfFiles = [];


  /// request icon button //////////////////////////////////////////////////////

  bool showScanToPdfIcon = false;
  bool showCloudSyncIcon = false;
  bool showCreateFoldersIcon = false;
  bool showOtherIcon = false;


  List<Widget> widgetList = [


    BrowserPage(),
    recent(),
    favorite(),
    tools(),


  ];

  @override
  void initState() {
    super.initState();
    filteredPdfFiles = pdfFiles;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Search PDF files...',
            hintStyle: TextStyle(color: Colors.black38,fontWeight: FontWeight.w500),
          ),
          style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
         // onChanged: _filterPdfFiles,
        )
            : Text(appBarTitle),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.clear : Icons.search),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  isSearching = false;
                  searchController.clear();
                  filteredPdfFiles = pdfFiles;
                } else {
                  isSearching = true;
                }
              });
            },
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
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),

            const Divider(thickness: 1),

            ListTile(
              title: const Text(
                'Browse PDF',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(Icons.folder_open, color: Colors.blue),
              onTap: () async {
                try {
                  filePickerResult = await FilePicker.platform.pickFiles(
                    allowedExtensions: ['pdf'],
                    type: FileType.custom,
                  );
                  if (filePickerResult != null) {
                    var path = filePickerResult!.files.single.path;
                    if (path != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFScreen(index: 0, path: path),
                        ),
                      );
                    }
                  }
                } catch (e) {
                  print('Error picking file: $e');
                }
              },
            ),

            ListTile(
              leading: const Icon(Icons.ios_share_rounded, color: Colors.blue,),
              title: const Text(
                  'Share App', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                final RenderBox box = context.findRenderObject() as RenderBox;
                Share.share(
                    'Hi , Im using PDF Reader. Its so easy and convenient to view & edit PDFs...',
                    subject: 'PDF Viewer App',
                    sharePositionOrigin: box.localToGlobal(Offset.zero) & box
                        .size);
              },
            ),


            SwitchListTile(
              title: const Text('Security question',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              secondary: const Icon(
                Icons.security_outlined, color: Colors.blue,),
              value: isScreenKeptOn,
              onChanged: (abl) {
                setState(() {
                  isScreenKeptOn = abl;
                  if (abl) {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const SecurityQuestionPage()));
                  }
                });
              },
            ),


            ListTile(
              title: const Text('Language Options',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: const Icon(Icons.language_outlined, color: Colors.blue,),
              onTap: () {

              },
            ),

            SwitchListTile(
              title: const Text(
                  'DarkMode', style: TextStyle(fontWeight: FontWeight.bold)),
              secondary: const Icon(
                  Icons.dark_mode_outlined, color: Colors.blue),
              value: isDarkModelNotifier.value,
              onChanged: (val) {
                isDarkModelNotifier.value = !isDarkModelNotifier.value;
                setState(() {});
              },
            ),


            ListTile(
              title: const Text(
                  'FAQ', style: TextStyle(fontWeight: FontWeight.bold)),
              leading: const Icon(
                Icons.question_answer_outlined, color: Colors.blue,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const featureRequset()),
                );
              },
            ),


            ListTile(
              title: const Text(
                  'Feedback', style: TextStyle(fontWeight: FontWeight.bold)),
              leading: const Icon(Icons.feedback_outlined, color: Colors.blue,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FeedbackPage()),
                );
              },
            ),

            ListTile(
              title: const Text('Request a new feature',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: const Icon(
                Icons.file_copy_outlined, color: Colors.blue,),
              onTap: () =>
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 9.5,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 20.0,
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
                              style: TextStyle(fontSize: 15.0,),
                            ),

                            const SizedBox(height: 20.0),

                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .end,
                                        children: [

                                          Card(
                                            child: TextButton.icon(
                                              onPressed: () =>
                                              {

                                                setState(() {})
                                              },
                                              icon: const Icon(Icons
                                                  .document_scanner_outlined),
                                              label: const Text('Scan to PDF'),
                                            ),
                                          ),

                                          Card(
                                            child: TextButton.icon(
                                              onPressed: () =>
                                              {
                                                showSubmitButton = true,
                                                setState(() {})
                                              },
                                              icon: const Icon(
                                                  Icons.cloud_done_outlined),
                                              label: const Text('Cloud Sync'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 5.0),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Card(
                                        child: TextButton.icon(
                                          onPressed: () =>
                                          {
                                            showSubmitButton = true,
                                            setState(() {})
                                          },
                                          icon: const Icon(
                                              Icons.create_new_folder_outlined),
                                          label: const Text('Create Folders'),
                                        ),
                                      ),


                                      Card(
                                        child: TextButton.icon(
                                          onPressed: () =>
                                          {
                                            showSubmitButton = true,
                                            setState(() {})
                                          },
                                          icon: const Icon(
                                              Icons.offline_bolt_outlined),
                                          label: const Text('Others'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {


                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    // Set text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0),
                                    ),
                                    minimumSize: const Size(
                                        350.0, 50.0),
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
                title: const Text('Keep screen on',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                value: isScreenKeptOff,
                onChanged: (val) {
                  setState(() {
                    isScreenKeptOff = val;
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


      ///Added bottomnavigationbar//////////////////////////////////////////


      body: widgetList[_selectedIndex],
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

    void filterPdfFiles(String query) {
      setState(() {
        filteredPdfFiles = pdfFiles
            .where((file) => file.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }
}
