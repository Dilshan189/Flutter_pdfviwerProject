import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf_thumbnail/pdf_thumbnail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;


import '../model/lockpdf_model.dart';
import '../searchbar/lockpdf_searchbar.dart';
import '../service/database_service_lockpdf.dart';
import 'pdflock_thankyou_screen.dart';

class LockPdf extends StatefulWidget {
  const LockPdf({super.key});

  @override
  State<LockPdf> createState() => _LockPdfState();
}

class _LockPdfState extends State<LockPdf> {
  List<String> pdfFiles = [];

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
      var rootDirectory = Directory(directoryPath);
      var directories = rootDirectory.list(recursive: false);
      await for (var element in directories) {
        if (element is File) {
          if (element.path.split(".").last == "pdf") {
            debugPrint("PDF File Name : ${element.path.split("/").last}");
            setState(() {
              pdfFiles.add(element.path);
            });
          }
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
        title: const Text(
          'Select a file',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const LockSearbar(),arguments: pdfFiles);
            },
            icon: const Icon(Icons.search_rounded),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: pdfFiles.length,
        itemBuilder: (context, index) {
          String filePath = pdfFiles[index];
          String fileName = path.basename(filePath);

          return Card(
            shadowColor: Colors.grey,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(style: BorderStyle.solid),
            ),
            child: ListTile(
              onTap: () {
                _showLockDialog(context, filePath, fileName);
              },
              title: Text(
                fileName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    filePath,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.folder_copy_outlined,
                        weight: 50,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'PDF',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),


              leading: SizedBox(
                width: 50,
                height: 188,
                child: PdfThumbnail.fromFile(
                  scrollToCurrentPage: false,
                  filePath,
                  currentPage: 0,
                  height: 56,
                  backgroundColor: Colors.transparent,


                ),
              ),

            ),
          );
        },
      ),
    );
  }

  void _showLockDialog(BuildContext context, String filePath, String fileName) {
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Set Password\n$fileName",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              labelText: "Password",
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () async {
                String filePassword = passwordController.text.trim();

                if (filePassword.isNotEmpty && RegExp(r'^\d+$').hasMatch(filePassword)) {
                  LockpdfModel lockpdfModel = LockpdfModel(
                    fileName: fileName,
                    filePath: filePath,
                    filePassword: filePassword,
                  );


                  DatabaseService().insertlockpdf(lockpdfModel);

                  Navigator.of(context).pop();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PdfLock(),
                    ),
                  );
                } else {
                  AnimatedSnackBar.material(
                    'Please enter a numeric value for the password',
                    type: AnimatedSnackBarType.error,
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                    desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
                    duration: const Duration(seconds: 5),
                    borderRadius: BorderRadius.circular(15),
                  ).show(context);
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

}
