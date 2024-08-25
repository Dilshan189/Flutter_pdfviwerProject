import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pdfviwer/bottom/SecurityQuestionPage.dart';
import 'package:pdfviwer/consts/consts.dart';
import 'package:pdfviwer/homepage/pdf_screen.dart';
import 'package:pdfviwer/homepage/search_bar.dart';
import 'package:pdfviwer/test_page/change_screen.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
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
        actions: [

          if (_selectedIndex == 0) ...[
          IconButton(
          onPressed: () {
          Get.to(() => const Searchbar());
      },

      icon: const Icon(Icons.search_rounded),

        ),

            IconButton(
              onPressed: () {
                Get.to(() => const ChangeScreen());
              },
              icon: const Icon(Icons.credit_card_rounded),
            ),

        ],


          if (_selectedIndex == 1) ...[
            IconButton(
              onPressed: () {
                Get.to(() => const Searchbar(),arguments: pdfFiles);
              },

              icon: const Icon(Icons.search_rounded),

            ),

            IconButton(
              onPressed: () {
                Get.to(() => const ChangeScreen());
              },
              icon: const Icon(Icons.credit_card_rounded),
            ),

          ],

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
              title: Text('PDF Reader',
                  style:GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 25)),
                  trailing: IconButton(onPressed:(){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: Lottie.asset(
                          'assets/icon/success.json',
                        ),
                      ),
                    );
                  },
                      icon: const Icon(Icons.star_border_purple500_outlined, size: 45,shadows: [Shadow(color: Colors.black87)])),
            ),

            const Divider(thickness: 1),

            ListTile(
                title:Text(
                  'Import PDF',
                  style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
                ),
                leading:const Image(image: AssetImage('assets/images/icons8-folder-26.png'),
                  width: 20,
                  height: 20,),
                onTap: () {
                  pickFiles(context);
                }
            ),

            ListTile(
              title:  Text(
                'FAQ',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
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
              title: Text(
                'Request a new feature',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
              ),
              leading: const Image(
                image: AssetImage('assets/images/icons8-copy-48.png'),
                width: 25,
                height: 25,
              ),
              onTap: () {
                Navigator.of(context).pop(); // First, close the Drawer
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return FeatureRequestBottomSheet(imagePath: _imagePath);
                  },
                );
              },
            ),



            const Divider(thickness: 1,),


             ListTile(
              title: Text('Settings',
                style:GoogleFonts.poppins(fontWeight: FontWeight.w500,color: Colors.grey) ,
              ),
            ),

            SwitchListTile(
              title: Text(
                  'DarkMode',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
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
                title:  Text(
                    'Keep screen on',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
                secondary: const Image(image: AssetImage('assets/images/icons8-google-mobile-30.png'),
                  width: 25,
                  height: 25,),
                value: isScreenKeptOff,
                onChanged: (val) {
                  setState(() {
                    isScreenKeptOff = val;
                    Navigator.of(context).pop();
                  });
                }
            ),




            SwitchListTile(
              title:Text('Security question',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
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
              title: Text('Browse page',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
              leading: const Image(
                image: AssetImage('assets/images/icons8-world-50.png'),
                width: 25,
                height: 25,
              ),
              onTap: () async {
                final Uri url = Uri.parse('https://www.google.com');
                if (await canLaunchUrl(url)) {
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),




            const Divider(thickness: 1,),

             ListTile(
              title: Text('About App',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: Colors.grey),
              ),
            ),


            ListTile(
              leading: const Image(image: AssetImage('assets/images/icons8-share-50.png'),
                width: 25,
                height: 25,),
              title:Text(
                  'Share App', style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
              onTap: () {
                final RenderBox box = context.findRenderObject() as RenderBox;
                Share.share(
                    'Hi , Im using PDF Reader. Its so easy and convenient to view & edit PDFs...',
                    subject: 'PDF Viewer App',
                    sharePositionOrigin: box.localToGlobal(Offset.zero) & box
                        .size);
                Navigator.of(context).pop();
              },
            ),




            ListTile(
              title:Text(
                  'Feedback', style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
              leading: const Image(image: AssetImage('assets/images/icons8-message-50.png'),
                width: 25,
                height: 25,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FeedbackPage()),

                );
              },
            ),



             ListTile(
              title: Text('Version:1.3.8L',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500,color: Colors.grey),
              ),
            ),

          ],
        ),
      ),


      /// Bottomnavigationbar added ////////////////////////////////////////////


      body: widgetList[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Image(image:AssetImage('assets/images/home.png'), width: 25, height: 25,) , label: 'All files',),
          BottomNavigationBarItem(icon: Image(image:AssetImage('assets/images/icons8-clock-32.png'), width: 25, height: 25) , label: 'Recent'),
          BottomNavigationBarItem(icon:Image(image:AssetImage('assets/images/icons8-favorite-folder-48.png'), width: 25, height: 25) ,label: 'Favourite'),
          BottomNavigationBarItem(icon: Image(image:AssetImage('assets/images/icons8-apps-32.png'),width: 25, height: 25,) ,label: 'Tools',),

        ],


        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        selectedLabelStyle:GoogleFonts.poppins(fontWeight: FontWeight.w500),
        unselectedLabelStyle:GoogleFonts.poppins(fontWeight: FontWeight.w500),
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
