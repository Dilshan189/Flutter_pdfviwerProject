import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:pdfviwer/model/pdf_model.dart';
import 'package:pdfviwer/service/database_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../floatingactionbutton/floationactionbutton.dart';
import 'bottom_sheet.dart';
import '../homepage/pdf_screen.dart';

class FileItem {
  final String name;
  final String path;

  FileItem({required this.name, required this.path, });





}

class PDFListScreen extends StatefulWidget {
  const PDFListScreen({super.key});

  @override
  State<PDFListScreen> createState() => _PDFListScreenState();
}

class _PDFListScreenState extends State<PDFListScreen> {
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
      body: ListView.builder(
        itemCount: pdfFiles.length,
        itemBuilder: (context, index) {
          String filePath = pdfFiles[index];
          String fileName = path.basename(filePath);
          return ListTile(
            onTap: () async
            {

              String filePath = pdfFiles[index];
              String fileName = path.basename(filePath);

              PDFModel pdfModel = PDFModel(fileName: fileName, filePath: filePath);

              DatabaseService().insertPdf(pdfModel);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFScreen(
                    pdfPath: filePath,
                    pdfName: fileName,
                    index: 0,
                    path: filePath,
                  ),
                ),
              );
            },
            title: Text(fileName,
            style: const TextStyle(
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,),
            ),
            subtitle:  Text(
              pdfFiles[index],
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),


          // leading: SizedBox(
          //   width: 50,
          //   height: 180,
          //   child: PdfThumbnail.fromFile(
          //     scrollToCurrentPage: false,
          //     filePath,
          //     currentPage: 0,
          //     height: 56,
          //     backgroundColor: Colors.white,
          //   ),
          // ),

            leading:Image.asset("assets/images/icon.png",
            width: 40,
            height: 40,) ,

            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return BottomSheetContent(file: FileItem(name: fileName, path: filePath,));
                  },
                );
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const actionbutton();
            },
          );

        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
