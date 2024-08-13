import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;
import 'package:pdfviwer/service/database_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_fonts/google_fonts.dart';

import '../consts/consts.dart';

class ChangeScreen extends StatefulWidget {
  const ChangeScreen({super.key});

  @override
  State<ChangeScreen> createState() => _ChangeScreenState();
}

class _ChangeScreenState extends State<ChangeScreen> {
  List<String> pdfFiles = [];
  List<String> selectedFiles = [];
  int _selectedIndex = 0;

  get pdfWidgets => null;

  @override
  void initState() {
    super.initState();
    baseDirectory();
  }

  Future<void> baseDirectory() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;

    if (androidDeviceInfo.version.sdkInt < 30) {
      PermissionStatus permissionStatus = await Permission.storage.request();
      if (permissionStatus.isGranted) {
        var rootDirectory = await ExternalPath.getExternalStorageDirectories();
        await getFiles(rootDirectory.first);
      }
    } else {
      PermissionStatus permissionStatus = await Permission.manageExternalStorage.request();
      if (permissionStatus.isGranted) {
        var rootDirectory = await ExternalPath.getExternalStorageDirectories();
        await getFiles(rootDirectory.first);
      }
    }
  }

  Future<void> getFiles(String directoryPath) async {
    try {
      final rootDirectory = Directory(directoryPath);
      final directories = rootDirectory.list(recursive: false);

      await for (final element in directories) {
        if (element is File && element.path.endsWith('.pdf')) {
          debugPrint("PDF File Name : ${element.path.split("/").last}");
          setState(() {
            pdfFiles.add(element.path);
          });
        } else if (element is Directory) {
          await getFiles(element.path);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selected',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              bool? confirmDelete = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm Delete"),
                    content: const Text("Are you sure you want to delete this All PDF?"),
                    actions: [
                         TextButton(
                             onPressed: () => Navigator.of(context).pop(false),
                             child: const Text("Cancel"),
                           ),

                        TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("Delete"),
                          ),
                       ],
                    );
                  },
              );

               if (confirmDelete == true) {
                setState(() {
                  DatabaseService().deleteAllPDF();

               });

              ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('PDF deleted Successfully')),
          );
        }
      },
            icon: const Icon(Icons.apps_rounded),
          ),
        ],
      ),


      body: ListView.builder(
        itemCount: pdfFiles.length,
        itemBuilder: (context, index) {
          String filePath = pdfFiles[index];
          String fileName = path.basename(filePath);


          return Card(
            shadowColor: Colors.grey,
            margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
            shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),


            child: ListTile(
              title: Text(
                fileName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Text(
                filePath,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),


              leading:Image.asset("assets/images/icon.png",
                width: 40,
                height: 40,) ,


              trailing: const Icon(
                  Icons.check_box_outline_blank
                ),
              onTap: (){
                  //DatabaseService().deletePDF(pdf.id as int);
              },

            ),
          );
        },
      ),


      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon:Icon(Icons.ios_share,),label: 'share'),
          BottomNavigationBarItem(icon:Icon(Icons.delete_forever_outlined,),label: 'Delete'),
          BottomNavigationBarItem(icon: Icon(Icons.remove_circle_outline, ),label: 'Remove'),
        ],

        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        selectedLabelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w500),
        unselectedLabelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w500),
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: _onTapped,
        backgroundColor: Colors.white,

      ),
    );
  }

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(index){
        case 0:
          break;

        default:
          break;
      }
    });
  }
}
