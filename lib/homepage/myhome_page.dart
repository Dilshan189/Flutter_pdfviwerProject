import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:pdfviwer/consts/consts.dart';
import 'package:pdfviwer/homepage/pdf_screen.dart';
import 'package:pdfviwer/homepage/search_bar.dart';
import 'package:pdfviwer/service/database_service_sequrity_question.dart';
import 'package:pdfviwer/test_page/change_screen.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bottom/FeedbackPage.dart';
import '../bottom/featureRequset.dart';
import '../bottom/featurebottomsheet.dart';
import '../exite_dialog.dart';
import '../model/sequrity_question_model.dart';
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

  TextEditingController passwordController = TextEditingController();

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

  double rating = 0.0;





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
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 25)),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Rating;',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RatingBar.builder(
                              initialRating: rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (value) {
                                setState(() {
                                  rating = value;
                                });
                              },
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              const url = 'https://play.google.com/store/apps/details?id=com.example.app';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'OK',
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Image.asset('assets/images/icons8-hand-right-32.png'),
              ),
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
                      builder: (context) => const FeatureRequest()),
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

                  });
                }
            ),



            SwitchListTile(
              title: Text('Security question',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
              secondary: const Image(
                image: AssetImage('assets/images/icons8-question-48.png'),
                width: 25,
                height: 25,
              ),
              value: isScreenKeptOn,
              onChanged: (abl) {
                setState(() {
                  isScreenKeptOn = abl;

                  Navigator.of(context).pop();

                  if (abl) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String? selectedQuestion;


                        return AlertDialog(
                          title: Text(
                            'Set security Question',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Help you reset your password when you forget it',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(height: 10),

                              DropdownButtonFormField<String>(
                                decoration:  InputDecoration(
                                  hintText: 'Select question',
                                    hintStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,

                                    ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  border: InputBorder.none,
                                ),

                                items: <String>[
                                  'What is your pet\'s name?',
                                  'What is your favorite color?',
                                  'What is your birth Place?',
                                  'What is your lucky number?',
                                  'What\'s your favorite book?',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedQuestion = newValue;
                                  });
                                },
                                value: selectedQuestion,
                                borderRadius: BorderRadius.circular(10),
                              ),

                              const SizedBox(height: 10),

                              TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  hintText: 'Answer',
                                  hintStyle: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            const SizedBox(width: 3),
                            TextButton(
                              onPressed: () async {
                                String answer = passwordController.text.trim();

                                if (selectedQuestion != null && answer.isNotEmpty) {
                                  SecurityQuestionModel securityquestionModel = SecurityQuestionModel(
                                    textName: selectedQuestion ?? 'Default Question',
                                    textAnswer: answer,
                                  );

                                  await DatabaseServiceSequrityQuestion().insertSecurity(securityquestionModel);

                                  Navigator.of(context).pop();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Locked',
                                    textAlign: TextAlign.center,
                                    ),
                                    ),
                                  );

                                }
                                else{



                                }
                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                foregroundColor: Colors.white,
                                backgroundColor: const Color(0xFF4A00E0),
                              ),
                              child: Text(
                                'Ok',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }

                  else{
                    showDialog(
                          context: context,
                          builder: (BuildContext context) {
                          String? selectedQuestion;

                          return AlertDialog(
                            title: Text(
                                 'Security Question',
                                  style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                 ),
                              ),

                    content: Column(
                         mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             'To close this feature',
                              style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                               fontSize: 15,
                               color: Colors.grey,
                               ),
                           ),

                      const SizedBox(height: 5),

                            DropdownButtonFormField<String>(
                              decoration:  InputDecoration(
                                hintText: 'Select question',
                                hintStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,

                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                border: InputBorder.none,
                              ),

                              items: <String>[
                                'What is your pet\'s name?',
                                'What is your favorite color?',
                                'What is your birth Place?',
                                'What is your lucky number?',
                                'What\'s your favorite book?',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedQuestion = newValue;
                                });
                              },
                              value: selectedQuestion,
                              borderRadius: BorderRadius.circular(10),
                            ),


            const SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
              border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
              hintText: 'Answer',
              hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
               ),
             ),
            ),
                          ],
                    ),

            actions: [
            TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            ),
            ),
            child: Text(
            'Cancel',
            style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            ),
            ),
            ),

            const SizedBox(width: 3),

            TextButton(
             onPressed: () async {
              String answer = passwordController.text.trim();

            //  DatabaseServiceSequrityQuestion().getDataPdfList();

              if (selectedQuestion != null && answer.isNotEmpty) {
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Close',
                  textAlign: TextAlign.center),
                  ),
                );
              }
            },

            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
               ),
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF4A00E0),
            ),
            child: Text('Ok',
              style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              ),
             ),
            ),
            ],
                          );
                          },

                    );
                  }
                }
                );
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
