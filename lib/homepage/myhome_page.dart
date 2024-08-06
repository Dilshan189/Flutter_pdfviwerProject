import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:pdfviwer/bottom/SecurityQuestionPage.dart';
import 'package:pdfviwer/consts/consts.dart';
import 'package:pdfviwer/homepage/pdf_screen.dart';
import 'package:pdfviwer/homepage/search_bar.dart';
import 'package:share/share.dart';
import '../bottom/FeedbackPage.dart';
import '../bottom/featureRequset.dart';
import '../bottom/featurebottomsheet.dart';
import '../exite_dialog.dart';
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

  void _showImage() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Lottie.asset('assets/icon/Animation - 1722878584548.json'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close',
              style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  List<PlatformFile>? selectedFiles;
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

  /// File picker added ////////////////////////////////////////////////////////

  void pickFiles(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFiles = result.files;
      });

      var path = selectedFiles!.first.path;
      if (path != null) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => PDFScreen(index: 0, path: path, pdfPath:path, pdfName:path,),
        ),
        );
      }
    } else {

    }
  }


  List<Widget> widgetList = const[

    PDFListScreen(),
    Recent(),
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
    return WillPopScope(
        onWillPop: () async {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => exitDialog(context),
      );
      return false; // Prevent the default back navigation
    },

    child:Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: Colors.white54,
        actions: [
          IconButton(
            icon: const Image(image: AssetImage('assets/images/icons8-search-50.png',),
            width: 23,
            height: 23,),
            onPressed: () {
              Get.to(() => const Searchbar());
            },
          ),
          IconButton(
            icon: const Icon(Icons.credit_score_outlined),
            onPressed: () {},
          ),
        ],

        leading: Builder(
          builder: (context) => IconButton(onPressed: () {
            Scaffold.of(context).openDrawer();
          },
            icon: const Icon(Icons.sort),
          ),
        ),

      ),

      /// Added Drawer////////////////////////////////////////////////////////


      drawer: Drawer(
        child: ListView(
          children: <Widget>[

             ListTile(
              title: const Text('PDF Reader',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500,fontFamily: 'apots_bold')),
                  trailing: IconButton(onPressed:_showImage,
                      icon: const Icon(Icons.star_border_purple500_outlined, color: Colors.black,size: 45,shadows: [Shadow(color: Colors.black87)])),
            ),

            const Divider(thickness: 1),

            ListTile(
                title: const Text(
                  'Import PDF',
                  style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'apots_bold'),
                ),
                leading:const Image(image: AssetImage('assets/images/icons8-folder-26.png'),
                  width: 20,
                  height: 20,),
                onTap: () {
                  pickFiles(context);
                }
            ),

            ListTile(
              title: const Text(
                'FAQ', style: TextStyle(fontFamily: 'apots_bold',fontWeight: FontWeight.w500),
              ),
              leading: const Image(image: AssetImage('assets/images/icons8-question-48.png'),
                width: 25,
                height: 25,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const featureRequset()),
                );
              },
            ),

            ListTile(
              title: const Text('Request a new feature', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'apots_bold')),
              leading: const Image(image: AssetImage('assets/images/icons8-copy-48.png'),
                width: 25,
                height: 25,),
              onTap: () => showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return FeatureRequestBottomSheet(imagePath: _imagePath);
                },
              ),
            ),


            const Divider(thickness: 1,),


            const ListTile(
              title: Text('Settings',
                style: TextStyle(fontSize: 16.0,fontFamily: 'apots_bold'),
              ),
            ),

            SwitchListTile(
              title: const Text(
                  'DarkMode', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'apots_bold')),
              secondary: const Image(image: AssetImage('assets/images/icons8-dark-30.png'),
                width: 25,
                height: 25,
              ),
              value: isDarkModelNotifier.value,
              onChanged: (val) {
                isDarkModelNotifier.value = !isDarkModelNotifier.value;
                setState(() {});
              },
            ),



            SwitchListTile(
                title: const Text('Keep screen on',
                    style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'apots_bold')),
                secondary: const Image(image: AssetImage('assets/images/icons8-google-mobile-30.png'),
                  width: 25,
                  height: 25,),
                value: isScreenKeptOff,
                onChanged: (val) {
                  setState(() {
                    isScreenKeptOff = val;
                  });
                }
            ),




            SwitchListTile(
              title: const Text('Security question',
                  style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'apots_bold')),
              secondary: const Image(image: AssetImage('assets/images/icons8-question-48.png'),
                width: 25,
                height: 25,),
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
                  style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'apots_bold')),
              leading: const Image(image: AssetImage('assets/images/icons8-world-50.png'),
                width: 25,
                height: 25,),
              onTap: () {

              },
            ),

            const Divider(thickness: 1,),

            const ListTile(
              title: Text('About App',
                style: TextStyle(fontSize: 16.0,fontFamily: 'apots_bold'),
              ),
            ),


            ListTile(
              leading: const Image(image: AssetImage('assets/images/icons8-share-50.png'),
                width: 25,
                height: 25,),
              title: const Text(
                  'Share App', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'apots_bold')),
              onTap: () {
                final RenderBox box = context.findRenderObject() as RenderBox;
                Share.share(
                    'Hi , Im using PDF Reader. Its so easy and convenient to view & edit PDFs...',
                    subject: 'PDF Viewer App',
                    sharePositionOrigin: box.localToGlobal(Offset.zero) & box
                        .size);
              },
            ),




            ListTile(
              title: const Text(
                  'Feedback', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'apots_bold')),
              leading: const Image(image: AssetImage('assets/images/icons8-message-50.png'),
                width: 25,
                height: 25,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FeedbackPage()),
                );
              },
            ),



            const ListTile(
              title: Text('Version:1.3.8L',
                style: TextStyle(fontSize: 16.0,fontFamily: 'apots_bold'),
              ),
            ),

          ],
        ),
      ),


      /// Bottomnavigationbar added ////////////////////////////////////////////


      body: widgetList[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Image(image:AssetImage('assets/images/home.png'), width: 25, height: 25,) , label: 'All files'),
          BottomNavigationBarItem(icon: Image(image:AssetImage('assets/images/icons8-clock-32.png'), width: 25, height: 25) , label: 'Recent'),
          BottomNavigationBarItem(icon:Image(image:AssetImage('assets/images/icons8-favorite-folder-48.png'), width: 25, height: 25) ,label: 'Favourite'),
          BottomNavigationBarItem(icon: Image(image:AssetImage('assets/images/icons8-apps-32.png'),width: 25, height: 25,) ,label: 'Tools',),

        ],


        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(fontFamily: 'apots_bold'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'apots_bold'),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,

      ),
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
