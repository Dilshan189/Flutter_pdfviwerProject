import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdfviwer/consts/consts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../homepage/pdf_screen.dart';
import '../tools_page/images_list.dart';
import '../tools_page/selected_images.dart';

class actionbutton extends StatefulWidget {
  const actionbutton({super.key});

  @override
  State<actionbutton> createState() => _AllfloatingactionbuttonState();
}

class _AllfloatingactionbuttonState extends State<actionbutton> {

  List cateNames = [
    "Image PDF",
    "Import PDF",
  ];

  List<Color> cateColors = [
    const Color(0xFFEEDADA),
    const Color(0xFFEBCAEE),
  ];

  List<Icon> cateIcons = [
    const Icon(Icons.image_outlined, color: Colors.pink, size: 25),
    const Icon(Icons.folder_copy_outlined, color: Colors.cyan, size: 25),
  ];

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
  builder: (context) => PDFScreen(index: 0,
      path: path,
      pdfPath: path,
      pdfName: path.split('/').last),
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
  builder: (context) =>  const SelectedImages(),
  ),
  );
  }
  }
  }


  @override
  Widget build(BuildContext context) {

    return Container(
          decoration: const BoxDecoration(
            borderRadius:BorderRadius.only(bottomRight:Radius.zero,bottomLeft:Radius.zero ,topRight:Radius.zero ,topLeft:Radius.zero ) ,
        ),
        child: Padding(
        padding: const EdgeInsets.all(45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,

        children: [
          GridView.builder(
       itemCount: cateNames.length,
       shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 2,
       childAspectRatio: 1.0,
    ),

    itemBuilder: (context, index) {
       return GestureDetector(
          onTap: () async {

           switch (index) {

           case 0:
             await pickGalleryImage();
             break;


          default:
            pickFiles(context);
            break;

       }
    },
    child: Column(

       children: [

         Container(
           height: 65,
           width: 75,
           decoration: BoxDecoration(
             color: cateColors[index],
             shape: BoxShape.circle,
             boxShadow: const [BoxShadow(
               color: Colors.black12,
               blurRadius: 1,
               spreadRadius: 1,
               offset: Offset(2, 2),
             )
             ],
           ),
    child: Center(child: cateIcons[index],
    ),
         ),

    Center(
      child: Text(cateNames[index],
      style:GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 16),
    ),
    ),
       ],
    ),
       );
       },
          ),
        ],
        ),
        ),
    );
  }
}
