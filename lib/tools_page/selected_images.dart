import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;
import 'package:pdfviwer/consts/consts.dart';
import 'images_list.dart';

class SelectedImages extends StatefulWidget {
  const SelectedImages({super.key});

  @override
  State<SelectedImages> createState() => _SelectedImagesState();
}

class _SelectedImagesState extends State<SelectedImages> {
  ImagesList imagesList = ImagesList();
  late double progressValue = 0;
  late bool isExporting = false;
  late int convertedImage = 0;

  Future<String?> _showFileNameDialog() async {
    String? fileName;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter File Name',style: GoogleFonts.poppins(fontWeight: FontWeight.w500),),
          content: TextField(
            onChanged: (value) {
              fileName = value;
            },
            decoration:InputDecoration(
                hintText: "Enter file name",
                border: const OutlineInputBorder(
                    borderRadius:BorderRadius.all(Radius.circular(8))),
                hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(fileName);
              },
              child: Text('OK',style:GoogleFonts.poppins(fontWeight: FontWeight.w400)),
            ),
          ],
        );
      },
    );
    return fileName;
  }

  void convertImage() async {
    String? fileName = await _showFileNameDialog();

    if (fileName == null || fileName.isEmpty) {
      Get.snackbar('Error', 'File name cannot be empty.',backgroundColor: Colors.black12);
      return;
    }

    setState(() {
      isExporting = true;
    });

    final pathToSave = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOCUMENTS);

    final pdf = pw.Document();

    for (final imagePath in imagesList.imagePaths) {
      final imageBytes = await File(imagePath.path).readAsBytes();
      final image = img.decodeImage(imageBytes);

      if (image != null) {
        final pdfImage = pw.MemoryImage(imageBytes);
        pdf.addPage(
          pw.Page(build: (pw.Context context) {
            return pw.Center(child: pw.Image(pdfImage));
          }),
        );
      }

      setState(() {
        convertedImage++;
        progressValue = convertedImage / imagesList.imagePaths.length;
      });
    }

    final outputFile = File('$pathToSave/$fileName.pdf');
    await outputFile.writeAsBytes(await pdf.save());

    MediaScanner.loadMedia(path: outputFile.path);

    Get.snackbar('Thank you!', 'Image converted successfully!',backgroundColor: Colors.black12);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selected Images"),
        centerTitle: true,
      ),
      bottomNavigationBar: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: Colors.blue,
        textColor: Colors.white,
        padding: const EdgeInsets.all(10),
        onPressed: convertImage,
        child: const Text(
          'Convert',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: isExporting,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: LinearProgressIndicator(
                  minHeight: 25,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  value: progressValue,
                ),
              ),
            ),
            const Gap(10),
            Visibility(
              visible: !isExporting,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: imagesList.imagePaths.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Image(
                      image: FileImage(
                        File(imagesList.imagePaths[index].path),
                      ),
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
