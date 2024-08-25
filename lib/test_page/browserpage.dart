import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:pdf_thumbnail/pdf_thumbnail.dart';
import 'package:permission_handler/permission_handler.dart';

import '../floatingactionbutton/floationactionbutton.dart';
import 'bottom_sheet.dart';
import '../homepage/pdf_screen.dart';
import '../model/pdf_model.dart';
import '../service/database_service.dart';
import 'change_screen.dart';

class FileItem {
  final String name;
  final String path;
  final String size;
  final String modifiedDate;

  FileItem({required this.name, required this.path, required this.size, required this.modifiedDate});


}

class PDFListScreen extends StatefulWidget {
  const PDFListScreen({super.key});

  @override
  State<PDFListScreen> createState() => _PDFListScreenState();
}

class _PDFListScreenState extends State<PDFListScreen> {

  List<FileItem> pdfFiles = [];

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
            var fileStat = await element.stat();
            var modifiedDate = "${fileStat.modified.month}/${fileStat.modified.day}/${fileStat.modified.year}";
            var fileSize = fileStat.size;
            debugPrint("PDF File Name : ${element.path.split("/").last}");
            debugPrint("Modified Date: $modifiedDate");
            debugPrint("File Size: $fileSize bytes");
            setState(() {
              pdfFiles.add(FileItem(
                name: path.basename(element.path),
                path: element.path,
                size: '${(fileSize / 1024).toStringAsFixed(2)} KB',
                modifiedDate: modifiedDate,
              ));
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
      body: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),

        child: ListView.builder(
          itemCount: pdfFiles.length,
          itemBuilder: (context, index) {
            FileItem fileItem = pdfFiles[index];
            String filePath = fileItem.path;
            String fileName = fileItem.name;

            return Card(
              shadowColor: Colors.grey,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                  side:const BorderSide(
                      style:BorderStyle.solid
                  )
              ),
              child: ListTile(
                onTap: () async {
                  PDFModel pdfModel = PDFModel(
                      fileName: fileItem.name,
                      filePath: fileItem.path,
                      size: fileItem.size,
                      modifiedDate:fileItem.modifiedDate);


                  /// Check if the PDF already exists in the database
                  bool pdfExists = await DatabaseService().pdfExists(fileItem.path);



                  /// If the PDF doesn't exist, insert it into the database
                  if (!pdfExists) {
                    await DatabaseService().insertPdf(pdfModel);
                  }



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
                      fileItem.path,
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                    ),

                    Row(
                      children: [
                        Text(
                          fileItem.modifiedDate,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Text(
                          'Size: ${fileItem.size}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(
                          Icons.folder_copy_outlined,
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


                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheetContent(file: fileItem);
                      },
                    );
                  },
                ),
                onLongPress: () {
                  Get.to(() => const ChangeScreen());
                },
              ),
            );
          },
        ),
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
