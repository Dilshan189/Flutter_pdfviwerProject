import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pw;

import 'package:permission_handler/permission_handler.dart';

import '../consts/consts.dart';
import '../homepage/search_bar.dart';

class Marge extends StatefulWidget {
  const Marge({super.key});

  @override
  State<Marge> createState() => _MargeState();
}

class _MargeState extends State<Marge> {
  List<String> pdfFiles = [];
  List<String> selectedFiles = [];

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

///merge PDF file added/////////////////////////////////////////////////////////

  Future<void> mergePdfs(List<String> pdfPaths) async {
    final pdf = pw.Document();
    for (final filePath in pdfPaths) {
      final file = File(filePath);
      final pdfBytes = await file.readAsBytes();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text('PDF Page from: ${path.basename(filePath)}'),
            );
          },
        ),
      );
    }

    final outputDirectory = await getExternalStorageDirectory();
    final outputPath = '${outputDirectory!.path}/merged_output.pdf';
    final outputFile = File(outputPath);
    await outputFile.writeAsBytes(await pdf.save());

    Get.snackbar('****', 'merge to pdf converted :$outputPath');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Selected',
          style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const Searchbar());
            },
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: pdfFiles.length,
        itemBuilder: (context, index) {
          String filePath = pdfFiles[index];
          String fileName = path.basename(filePath);
          final isSelected = selectedFiles.contains(filePath);

          return ListTile(
            onTap: () {
              setState(() {
                if (isSelected) {
                  selectedFiles.remove(filePath);
                } else {
                  selectedFiles.add(filePath);
                }
              });
            },
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
              icon: Icon(
                isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                color: isSelected ? Colors.blue : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  if (isSelected) {
                    selectedFiles.remove(filePath);
                  } else {
                    selectedFiles.add(filePath);
                  }
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()async {
          if (selectedFiles.isNotEmpty) {
            await mergePdfs(selectedFiles);
          } else {
            Get.snackbar('Error', 'No PDF files selected');
          }
        },
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.picture_as_pdf_outlined, color: Colors.white),
        label: const Text('Merge PDF', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
