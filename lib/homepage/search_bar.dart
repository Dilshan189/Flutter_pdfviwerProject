import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart' as path;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:pdf_thumbnail/pdf_thumbnail.dart';
import 'package:permission_handler/permission_handler.dart';
import '../homepage/pdf_screen.dart';
import '../test_page/bottom_sheet.dart';




class FileItem {
  final String name;
  final String path;
  final String size;
  final String modifiedDate;

  FileItem({required this.name, required this.path, required this.size, required this.modifiedDate});
}

class Searchbar extends StatefulWidget {
  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {

  List<FileItem> pdfFiles = [];
  List<FileItem>? pdfFilesSearch;
  final TextEditingController? _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

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
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          height: 40,
          child: TextFormField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              suffixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Search PDF',
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            ),
            onChanged: (value) {
              setState(() {
                if(value.isEmpty){
                  pdfFilesSearch = null;
                }
                else {
                  pdfFilesSearch = pdfFiles
                      .where((file) =>
                      file.name.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                }
              });
            },
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),
        child: _textEditingController!.text.isNotEmpty && pdfFilesSearch!.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/icon/Animation - 1722676878214.json',
                width: 150,
                height: 150,
              ),

              Text(
              'No data found',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ]
          ),
        )
            : ListView.builder(
          itemCount: _textEditingController.text.isNotEmpty
              ? pdfFilesSearch?.length ?? 0
              : pdfFiles.length,
          itemBuilder: (context, index) {
            FileItem fileItem = _textEditingController.text.isNotEmpty
                ? pdfFilesSearch![index]
                : pdfFiles[index];
            String filePath = fileItem.path;




            return Card(
              shadowColor: Colors.grey,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(style: BorderStyle.solid),
              ),
              child: ListTile(
                onTap: () async {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFScreen(
                        pdfPath: fileItem.path,
                        pdfName: fileItem.name,
                        index: 0,
                        path: fileItem.path,
                      ),
                    ),
                  );
                },

                title: Text(
                  fileItem.name,
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



                // trailing: IconButton(
                //   icon: const Icon(Icons.more_vert),
                //   onPressed: () {
                //     showModalBottomSheet(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return  BottomSheetContent(file: fileItem,);
                //       },
                //     );
                //   },
                // ),


              ),
            );
          },
        ),
      ),

    );
  }
}
