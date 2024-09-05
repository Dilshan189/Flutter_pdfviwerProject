import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdfviwer/consts/consts.dart';
import 'FeedbackPage.dart';


class FeatureRequest extends StatefulWidget {
  const FeatureRequest({super.key});

  @override
  State<FeatureRequest> createState() => _FeatureRequestState();
}

class _FeatureRequestState extends State<FeatureRequest> {


  bool _isExpanded1 = false;
  bool _isExpanded2 = false;
  bool _isExpanded3 = false;
  bool _isExpanded4 = false;
  bool _isExpanded5 = false;
  bool _isExpanded6 = false;
  bool _isExpanded7 = false;
  bool _isExpanded8 = false;
  bool _isExpanded9 = false;
  bool _isExpanded10 = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQ',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 20),
                Text(
                  'About App',
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'My files open slowly',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    leading: const Icon(
                      Icons.watch_later_outlined,
                      size: 30,
                      color: Color(0xFF4A00E0),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        _isExpanded1
                            ? Icons.arrow_drop_up_outlined
                            : Icons.arrow_drop_down_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _isExpanded1 = !_isExpanded1;
                        });
                      },
                    ),
                  ),
                  if (_isExpanded1)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children:[
                          Text(
                          'This may be caused by the large file size.To ensure the best reading experience, We need some time to load and parse. \n \n'
                              'We appreciate your understanding and will continue to improve. \n \n'
                          'Was it helpful?',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                          ),
                        ),

                          const SizedBox(height: 5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(onPressed: (){

                                Get.snackbar("Thank you!", "Your FeedBack...");

                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('YES')),

                              const SizedBox(width: 25),

                              ElevatedButton(onPressed: (){
                                Get.to(()=>const FeedbackPage());
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('NO'),
                              ),
                            ],
                          ),

                      ],
                      ),
                    ),
                ],
              ),
            ),

            Card(
              elevation: 4,
              child: Column(
                children: [
                  ListTile(
                  title: Text('Why do we need permissions',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      )),
                  leading: const Icon(
                    Icons.key_outlined,
                    size: 30,
                    color: Color(0xFF4A00E0),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      _isExpanded2
                          ? Icons.arrow_drop_up_outlined
                          : Icons.arrow_drop_down_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded2 = !_isExpanded2;
                      });
                    },
                  ),
                ),
                  if (_isExpanded2)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children: [
                          Text(
                          'We require "All Files Access" permission to read files on your device,so you can manage,browse,and edit them in our app. \n \n'
                              'if not granted you can still browser and edite files through in sidebar of the homepage. \n \n'
                          'Reset assured, the permission will only be used foe file reading and will not be used for any other purpose. \n\n'

                          'Was it helpful?'
                          ,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                          const SizedBox(height: 5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(onPressed: (){
                                Get.snackbar("Thank you!", "Your FeedBack...");
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('YES')),

                              const SizedBox(width: 25),

                              ElevatedButton(onPressed: (){
                                Get.to(()=>const FeedbackPage());
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('NO')),

                            ],
                          ),
                      ],
                      ),
                    ),
             ]
             ),
            ),


            Card(
              elevation: 4,
              child: Column(
                children:[
                  ListTile(
                  title: Text('How to set PDF Reader as my default file reader?',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      )),
                  leading: const Icon(
                    Icons.file_open_outlined,
                    size: 30,
                    color: Color(0xFF4A00E0),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      _isExpanded3
                          ? Icons.arrow_drop_up_outlined
                          : Icons.arrow_drop_down_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded3 = !_isExpanded3;
                      });
                    },
                  ),
            ),
                  if (_isExpanded3)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children:[
                          Text(
                          'First, tap any PDF file on your device or in other apps.Then,in the "Open with" pop-up, choose our app icon,and tap "Always" to set PDF Reader as your default file reader. \n \n'
                              'was it helpful?',
                          style:GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                          const SizedBox(height: 5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(onPressed: (){
                                Get.snackbar("Thank you!", "Your FeedBack...");
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('YES')),

                              const SizedBox(width: 25),

                              ElevatedButton(onPressed: (){
                                Get.to(()=>const FeedbackPage());
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('NO')),

                            ],
                          ),
                      ],
                      ),

                    ),


                 ]
              ),
            ),


            const SizedBox(height: 25),

            Row(
              children: [
                const SizedBox(width: 20),
                Text(
                  'File Management',
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 5,
              child: Column(
                children: [ListTile(
                  title: Text('What if I forgot my password?',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      )),
                  leading: const Icon(
                    Icons.lock_outline,
                    size: 30,
                    color: Color(0xFF4A00E0),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      _isExpanded4
                          ? Icons.arrow_drop_up_outlined
                          : Icons.arrow_drop_down_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded4 = !_isExpanded4;
                      });
                    },
                  ),
                ),
                  if (_isExpanded4)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children: [
                           Text(
                          'First,please enable "Security question" in the sidebar of the homepage.\n \n'
                              'Afterward,you can reset your password anytime using the security question. \n \n'
                              'NOTE:We highly value your privacy and cannot reset password for files encrypted outside our app. \n \n'
                              'Was it helpful?',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                        ),
                          const SizedBox(height: 5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(onPressed: (){
                                Get.snackbar("Thank you!", "Your FeedBack...");
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('YES')),

                              const SizedBox(width: 25),

                              ElevatedButton(onPressed: (){
                                Get.to(()=>const FeedbackPage());
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('NO')),

                            ],
                          ),
                      ],
                      ),
                    ),
               ]
              ),
            ),


            Card(
              elevation: 5,
              child: Column(
                children:
                  [
                    ListTile(
                  title: Text('Why can’t I open the file?',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      )),
                  leading: const Icon(
                    Icons.folder_special_outlined,
                    size: 30,
                    color: Color(0xFF4A00E0),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      _isExpanded5
                          ? Icons.arrow_drop_up_outlined
                          : Icons.arrow_drop_down_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded5 = !_isExpanded5;
                      });
                    },
                  ),
                ),
                    if (_isExpanded5)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          children:[
                            Text(
                           'Please check that your current app version is up-to-date.if not,please update and try again. \n \n'
                               'if you still cannot open the file.please tap "Feedback" in the sidebar of the homepage to send us the problematic file,and we will assist you as soon as possible. \n \n'
                               'Was it helpful?',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                          ),

                            const SizedBox(height: 5),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(onPressed: (){
                                  Get.snackbar("Thank you!", "Your FeedBack...");
                                },
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        minimumSize: const Size(150, 40)
                                    ),
                                    child:const Text('YES')),

                                const SizedBox(width: 25),

                                ElevatedButton(onPressed: (){
                                  Get.to(()=>const FeedbackPage());
                                },
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        minimumSize: const Size(150, 40)
                                    ),
                                    child:const Text('NO')),

                              ],
                            ),
                        ],
                        ),
                      ),
                ]
              ),
            ),


            Card(
              elevation: 5,
              child: Column(
                children: [
                  ListTile(
                  title: Text('Cannot find my files',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      )),
                  leading: const Icon(
                    Icons.search_rounded,
                    size: 30,
                    color: Color(0xFF4A00E0),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      _isExpanded6
                          ? Icons.arrow_drop_up_outlined
                          : Icons.arrow_drop_down_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded6 = !_isExpanded6;
                      });
                    },
                  ),
                ),
                  if (_isExpanded6)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children:[
                          Text(
                          'You can tap "import PDF"in the sidebar of the homepage to search for your files. \n \n '
                              'Was it helpful?',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,

                            ),
                        ),
                          const SizedBox(height: 5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(onPressed: (){
                                Get.snackbar("Thank you!", "Your FeedBack...");
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('YES')),

                              const SizedBox(width: 25),

                              ElevatedButton(onPressed: (){
                                Get.to(()=>const FeedbackPage());
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('NO')),

                            ],
                          ),
                      ],
                      ),
                    ),
                  ]
              ),
            ),

            Card(
              elevation: 5,
              child: Column(
                children: [
                  ListTile(
                  title: Text('How to search for text in files?',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      )),
                  leading: const Icon(
                    Icons.content_paste_search,
                    size: 30,
                    color: Color(0xFF4A00E0),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      _isExpanded7
                          ? Icons.arrow_drop_up_outlined
                          : Icons.arrow_drop_down_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded7 = !_isExpanded7;
                      });
                    },
                  ),
                ),
                  if (_isExpanded7)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children: [
                          Text(
                          'When viewing files,You can tap the "Search" icon  on the top bar to search for text. \n \n'
                              'Please note that this features only works on pages containing recognizable text. \n \n'
                              'Was it helpful?',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(onPressed: (){
                                Get.snackbar("Thank you!", "Your FeedBack...");
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('YES')),

                              const SizedBox(width: 25),

                              ElevatedButton(onPressed: (){
                                Get.to(()=>const FeedbackPage());
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('NO')),

                            ],
                          ),
                      ],
                      ),
                    ),
               ],
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                const SizedBox(width: 20),
                Text(
                  'File Viewing and Editing',
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 5,
              child: Column(
                children: [
                  ListTile(
                  title: Text('Why can’t I edit text in PDF?',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      )),
                  leading: const Icon(
                    Icons.edit_note_outlined,
                    size: 30,
                    color: Color(0xFF4A00E0),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      _isExpanded8
                          ? Icons.arrow_drop_up_outlined
                          : Icons.arrow_drop_down_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded8 = !_isExpanded8;
                      });
                    },
                  ),
                ),
                  if (_isExpanded8)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children: [
                          Text(
                          'Currently do not support editing text in PDFs but you can make them. \n \n'
                              'After marking,please tap "Done" in the upper-right corner.Then,tap"Save" in the "Save changes?" popup that appears on exit to save successfully. \n \n'
                            'Note that some make features may be unavailable for pages with unrecognizable text.we will continue to optimize this features in the future \n \n'
                              'Was it helpful?',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(onPressed: (){
                                Get.snackbar("Thank you!", "Your FeedBack...");
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('YES')),

                              const SizedBox(width: 25),

                              ElevatedButton(onPressed: (){
                                Get.to(()=>const FeedbackPage());
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('NO')),

                            ],
                          ),
                      ],
                      ),
                    ),
                ],
              ),
            ),


            Card(
              elevation: 5,
              child: Column(
                children:[
                  ListTile(
                  title: Text('My file cannot display normally',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      )),
                  leading: const Icon(
                    Icons.file_open_outlined,
                    size: 30,
                    color: Color(0xFF4A00E0),
                  ),
                    trailing: IconButton(
                      icon: Icon(
                        _isExpanded9
                            ? Icons.arrow_drop_up_outlined
                            : Icons.arrow_drop_down_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _isExpanded9 = !_isExpanded9;
                        });
                      },
                    ),
                ),
                  if (_isExpanded9)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children: [
                          Text(
                          '1.Please check in the files is damaged.\n'
                              '2.if the file appears blurry,iy may be due to excessive enlargement.Please try zooming out. \n \n'
                              'if the issue persists,please tap "Feedback" in the sidebar of the homepage to send us the problematic file,and we will assist you as soon as possible \n \n'
                              'Was it helpful?',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(onPressed: (){},
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('YES')),

                              const SizedBox(width: 25),

                              ElevatedButton(onPressed: (){
                                Get.to(()=>const FeedbackPage());
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('NO')),

                            ],
                          ),
                      ],
                      ),
                    ),
               ],
              ),
            ),


            Card(
              elevation: 5,
              child: Column(
                children: [
                  ListTile(
                  title: Text('How to enable "Reflow" mode?',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      )),
                  leading: const Icon(
                    Icons.wrap_text,
                    size: 30,
                    color: Color(0xFF4A00E0),
                  ),
                    trailing: IconButton(
                      icon: Icon(
                        _isExpanded10
                            ? Icons.arrow_drop_up_outlined
                            : Icons.arrow_drop_down_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _isExpanded10 = !_isExpanded10;
                        });
                      },
                    ),
                ),
                  if (_isExpanded10)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children:[
                          Text(
                          'Open the file and tap "View mode" in the bottom bar.From there,you can toggle "Reflow" mode on or off. \n \n'
                              'Currently, this feature is only available on Android 10 and above device.We will continue to optimize it and support more system in the future stay tuned. \n \n'
                              'Was it helpful?',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(onPressed: (){
                                Get.snackbar("Thank you!", "Your FeedBack...");
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('YES')),

                              const SizedBox(width: 25),

                              ElevatedButton(onPressed: (){
                                Get.to(()=>const FeedbackPage());
                              },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(150, 40)
                                  ),
                                  child:const Text('NO')),

                            ],
                          ),
                      ],
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 60,)
          ],

        ),
      ),


      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF4A00E0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                minimumSize: const Size(380, 65)),
            onPressed: () {
              Get.to(()=>const FeedbackPage());
            },
            child: Row(
              children: [
                const Icon(Icons.feedback_outlined),
                const SizedBox(width: 15),
                Text(
                  'Feedback or suggestion',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
