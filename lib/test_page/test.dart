import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdfviwer/tools_page/addtext.dart';
import 'package:pdfviwer/tools_page/editpdf.dart';
import 'package:pdfviwer/tools_page/hardwea.dart';
import 'package:pdfviwer/tools_page/lockpdf.dart';
import 'package:pdfviwer/tools_page/marge.dart';
import 'package:pdfviwer/tools_page/splitpdf.dart';
import 'package:pdfviwer/tools_page/unlockpdf.dart';
import 'package:permission_handler/permission_handler.dart';
import '../homepage/pdf_screen.dart';
import '../tools_page/images_list.dart';
import '../tools_page/selected_images.dart';

class tools extends StatefulWidget {
  const tools({Key? key});

  @override
  _ToolsState createState() => _ToolsState();
}

List cateNames = [
  "Marge PDF",
  "Split PDF",
  "Image PDF",
  "Edit PDF",
  "Add Text",
  "Lock PDF",
  "Unlock PDF",
  "Browser PDF",
  "Print",
];

List<Color> cateColors = [
  const Color(0xFFFDFCCE),
  const Color(0xFFFFF4E0),
  const Color(0xFFFDD4D4),
  const Color(0xFFCEE9FA),
  const Color(0xFFECD1FD),
  const Color(0xFFFCD9D8),
  const Color(0xFFFCD4FF),
  const Color(0xFFF6E3CD),
  const Color(0xFFFDFDD2),
];

List<Icon> cateIcons = [
  const Icon(Icons.picture_as_pdf_outlined, color: Colors.red, size: 25),
  const Icon(Icons.call_split_outlined, color: Colors.green, size: 25),
  const Icon(Icons.image_outlined, color: Colors.pink, size: 25),
  const Icon(Icons.edit_note_sharp, color: Colors.purple, size: 25),
  const Icon(Icons.text_fields_outlined, color: Colors.blue, size: 25),
  const Icon(Icons.lock_outline, color: Colors.indigo, size: 25),
  const Icon(Icons.lock_open_outlined, color: Colors.deepPurple, size: 25),
  const Icon(Icons.folder_copy_outlined, color: Colors.red, size: 25),
  const Icon(Icons.print_outlined, color: Colors.brown, size: 25),
];

class _ToolsState extends State<tools> {

  ///File Picker Tools//////////////////////////////////////////////////////////

  List<PlatformFile>? selectedFiles;

  void pickFiles(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFiles = result.files;
      });

      var path = selectedFiles!.first.path;
      if (path != null) {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => PDFScreen(index: 0, path: path,pdfPath: path, pdfName: path.split('/').last),
          ),
        );
      }
    } else {

    }
  }

  ///Image Picker Tools ////////////////////////////////////////////////////////

  ImagesList imagesList = ImagesList();

  Future<PermissionStatus> storagePermissionStatus() async {
    PermissionStatus storagePermissionStatus = await Permission.manageExternalStorage.status;

    if (!storagePermissionStatus.isGranted) {
      await Permission.manageExternalStorage.request();
    }

    storagePermissionStatus = await Permission.manageExternalStorage.status;

    return storagePermissionStatus;
  }

  Future<void> pickGalleryImage() async {
    PermissionStatus status = await storagePermissionStatus();

    if (status.isGranted) {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();

      if (images.isNotEmpty) {
        imagesList.clearImagesList();
        imagesList.imagePaths.addAll(images);

        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SelectedImages(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white70,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
          children: [
            GridView.builder(
              itemCount: cateNames.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    switch (index) {
                      case 0:
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const marge()),
                        );
                        break;

                      case 1:
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const spiltpdf()),
                        );
                        break;

                      case 2:
                        await pickGalleryImage();
                        break;

                      case 3:
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const editpdf()),
                        );
                        break;

                      case 4:
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const addtext()),
                        );
                        break;

                      case 5:
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const lockpdf()),
                        );
                        break;

                      case 6:
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const unlockpdf()),
                        );
                        break;

                      case 7:
                        pickFiles(context);
                        break;

                      default:
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const hardwea()),
                        );
                        break;
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 65,
                        width: 70,
                        decoration: BoxDecoration(
                          color: cateColors[index],
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(2, 2),
                            )
                          ],
                        ),
                        child: Center(
                          child: cateIcons[index],
                        ),
                      ),
                      Center(
                        child: Text(
                          cateNames[index],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Card(
              elevation: 10,
              child: ListTile(
                leading: const Icon(Icons.hail, color: Colors.amber),
                title: const Text("Hi Friends How are you?", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Calibri')),
                subtitle: const Text("I'm fine", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Calibri')),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}


