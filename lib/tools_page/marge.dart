import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;
import 'package:pdf_thumbnail/pdf_thumbnail.dart';
import 'package:pdfviwer/model/merge_pdf_model.dart';
import 'package:pdfviwer/service/database_service_merge_pdf.dart';
import 'package:pdfviwer/tools_page/pdfmerge_two.dart';
import 'package:permission_handler/permission_handler.dart';
import '../consts/consts.dart';
import '../searchbar/mearge_searchbar.dart';

class Marge extends StatefulWidget {
  const Marge({super.key});

  @override
  State<Marge> createState() => _MargeState();
}

class _MargeState extends State<Marge> {
  List<String> pdfFiles = [];
  List<String> selectedFiles = [];
  bool firstIconClicked = false;
  bool secondIconClicked = false;
  bool mergeButtonVisible = false;



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
        title: const Text(
          'Selected',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => MeargeSearchbar(),arguments: pdfFiles);
            },
            icon:const Icon(Icons.search_rounded),
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: pdfFiles.length,
        itemBuilder: (context, index) {
          String filePath = pdfFiles[index];
          String fileName = path.basename(filePath);
          final isSelected = selectedFiles.contains(filePath);

          return Card(
            shadowColor: Colors.grey,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side:const BorderSide(
                style: BorderStyle.solid,
              ),
            ),
            child: ListTile(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedFiles.remove(filePath);
                    if (selectedFiles.isEmpty) {
                      mergeButtonVisible = false;
                      firstIconClicked = false;
                      secondIconClicked = false;
                    }


                  }
                  else
                  {
                    selectedFiles.add(filePath);
                    if (!firstIconClicked) {
                      firstIconClicked = true;
                    }
                    else if (!secondIconClicked) {
                      secondIconClicked = true;
                    }

                    if (firstIconClicked && secondIconClicked) {
                      mergeButtonVisible = true;
                    }
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

              trailing: IconButton(
                icon: Icon(
                  isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                  color: isSelected ? Colors.blue : Colors.black,
                ),

                onPressed: () {
                  setState(() {
                    if (isSelected)
                    {
                      selectedFiles.remove(filePath);
                      if (selectedFiles.isEmpty)
                      {
                        mergeButtonVisible = false;
                        firstIconClicked = false;
                        secondIconClicked = false;
                      }

                    }
                    else
                    {
                      selectedFiles.add(filePath);
                      if (!firstIconClicked)
                      {
                        firstIconClicked = true;
                      }
                      else if (!secondIconClicked)
                      {
                        secondIconClicked = true;
                      }
                      if (firstIconClicked && secondIconClicked)

                      {
                        mergeButtonVisible = true;
                      }
                    }
                  });
                },
              ),
            ),
          );
        },
      ),

      floatingActionButton: mergeButtonVisible
          ? FloatingActionButton.extended(
        onPressed: () async {
          if (selectedFiles.length ==2) {

            String combinedFileName ='${path.basenameWithoutExtension(selectedFiles[0])}_${path.basenameWithoutExtension(selectedFiles[1])}.pdf';
            String combinedFilePath =
            path.join(path.dirname(selectedFiles[0]), combinedFileName);


            MeargePDF meargePDF = MeargePDF(
              fileName: combinedFileName,
              filePath: combinedFilePath,
            );


            await DatabaseService().insertMargePdf(meargePDF);


            Get.to(() => const PDFmerge(), arguments: selectedFiles);



          }
          else

          {

            Get.snackbar('Error', 'Please select two PDF files to merge.',
                snackPosition: SnackPosition.TOP);
          }

        },
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.picture_as_pdf_outlined, color: Colors.white),
        label: Text(
          'Merge PDF',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
          : null,
    );
  }
}
