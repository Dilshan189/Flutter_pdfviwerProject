import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'featurebottomsheet.dart';

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

  final String _imagePath = 'assets/images/image.png';

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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeatureRequestBottomSheet(
                    imagePath: _imagePath,
                  ),
                ),
              );
            },
            icon: Image.asset(
              'assets/images/icons8-copy-48.png',
              width: 45,
              height: 35,
            ),
          ),
        ],
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
                      color: Colors.blue,
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

                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(onPressed:(){},
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.white70,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                  child: const Text('YES'),
                              ),

                              const SizedBox(width: 25),

                              TextButton(onPressed: (){},
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.white70,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('NO'),
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
                    color: Colors.blue,
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: (){

                          },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white70,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('YES'),
                          ),

                          const SizedBox(width: 25),

                          TextButton(onPressed: (){},
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white70,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('NO'),
                          ),

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
                    color: Colors.blue,
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
                      child: Text(
                        'If your files are opening slowly, try clearing the app cache or freeing up device storage space. Ensure that the files are not corrupted.',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
                    color: Colors.blue,
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
                      child: Text(
                        'If your files are opening slowly, try clearing the app cache or freeing up device storage space. Ensure that the files are not corrupted.',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
                    color: Colors.blue,
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
                        child: Text(
                          'If your files are opening slowly, try clearing the app cache or freeing up device storage space. Ensure that the files are not corrupted.',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
                    color: Colors.blue,
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
                      child: Text(
                        'If your files are opening slowly, try clearing the app cache or freeing up device storage space. Ensure that the files are not corrupted.',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
                    color: Colors.blue,
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
                      child: Text(
                        'If your files are opening slowly, try clearing the app cache or freeing up device storage space. Ensure that the files are not corrupted.',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
                    color: Colors.blue,
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
                      child: Text(
                        'If your files are opening slowly, try clearing the app cache or freeing up device storage space. Ensure that the files are not corrupted.',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
                    color: Colors.blue,
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
                      child: Text(
                        'If your files are opening slowly, try clearing the app cache or freeing up device storage space. Ensure that the files are not corrupted.',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
                    color: Colors.blue,
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
                      child: Text(
                        'If your files are opening slowly, try clearing the app cache or freeing up device storage space. Ensure that the files are not corrupted.',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ),
                ],
              ),
            ),
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
            onPressed: () {},
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
