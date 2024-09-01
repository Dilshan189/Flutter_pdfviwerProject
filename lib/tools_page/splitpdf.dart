import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf_thumbnail/pdf_thumbnail.dart';
import 'package:pdfviwer/searchbar/SpliteSearchbar.dart';
import 'package:pdfviwer/tools_page/splitepdf_image.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

import '../model/pdf_model.dart';

class Spiltpdf extends StatefulWidget {
  const Spiltpdf({super.key});

  @override
  State<Spiltpdf> createState() => _SpiltpdfState();
}

class _SpiltpdfState extends State<Spiltpdf> {
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
          style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const SpliteSearchbar(), arguments: pdfFiles);
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

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFScreenSp(
                  pdfPath:filePath,
                  pdfName:fileName ,
                  index: 0,
                  path: fileName,
                ),
              ),
            );
            setState(() {});

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
                          fontWeight: FontWeight.bold,
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
}

