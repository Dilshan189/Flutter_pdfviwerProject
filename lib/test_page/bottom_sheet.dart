import 'dart:io'as io;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdfviwer/consts/consts.dart';
import 'package:pdfviwer/model/pdf_favourite_model.dart';
import 'package:pdfviwer/tools_page/lockpdf.dart';
import 'package:share/share.dart';
import 'package:path/path.dart' as path;
import 'browserpage.dart';
import '../service/database_service_favourite.dart';


class BottomSheetContent extends StatefulWidget {
  final FileItem file;


  const BottomSheetContent({super.key, required this.file});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            ListTile(
              leading: const Icon(
                Icons.edit_note_outlined,
                color: Colors.blue,
                weight: 55.3,
                shadows: [Shadow(color: Colors.black)],
              ),
              title: Text(
                'Edit Text',
                style:GoogleFonts.poppins(fontWeight: FontWeight.w400,),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),


            ListTile(
              leading: const Icon(
                Icons.text_fields_outlined,
                color: Colors.blue,
                weight: 55.3,
                shadows: [Shadow(color: Colors.black)],
              ),
              title:Text(
                'Rename',
                style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),


            ListTile(
              leading: const Icon(
                Icons.picture_as_pdf_outlined,
                color: Colors.blue,
                weight: 55.3,
                shadows: [Shadow(color: Colors.black)],
              ),
              title:  Text(
                'Edit PDF',
                style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),


            ListTile(
              leading: const Icon(
                Icons.lock_outline,
                color: Colors.blue,
                weight: 55.3,
                shadows: [Shadow(color: Colors.black)],
              ),
              title: Text(
                'Set password',
                style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.pop(context);

                Get.to(()=> const LockPdf());
              },
            ),

            const Divider(),


            ListTile(
              leading: const Icon(
                Icons.ios_share_outlined,
                color: Colors.blue,
                weight: 55.3,
                shadows: [Shadow(color: Colors.black)],
              ),
              title:  Text(
                'Share',
                style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
              ),
              onTap: () {

                final RenderBox box = context.findRenderObject() as RenderBox;
                Share.share(
                    'Hi , Im using PDF Reader. Its so easy and convenient to view & edit PDFs...',
                    subject: 'PDF Viewer App',
                    sharePositionOrigin: box.localToGlobal(Offset.zero) & box
                        .size);
                Navigator.pop(context);
              },
            ),


            ListTile(
              leading: const Icon(
                Icons.favorite_outline_outlined,
                color: Colors.blue,
                weight: 55.3,
                shadows: [Shadow(color: Colors.black)],
              ),
              title: Text(
                'Favorite',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
              ),

              onTap: () async
              {

                PDFModelFa pdfModelFa = PDFModelFa(
                    fileName:  widget.file.name,
                    filePath: widget.file.path,
                    size:  widget.file.size,
                    modifiedDate:  widget.file.modifiedDate);




                bool pdfExistsFa = await DatabaseService().pdfExistsFa(widget.file.path);

                if(!pdfExistsFa) {
                  DatabaseService().insertPdffa(pdfModelFa);
                }
                Get.snackbar('Successful', 'Favourite added successful!');

                Navigator.of(context).pop();


              },
            ),


            ListTile(
                leading: const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.blue,
                  weight: 55.3,
                  shadows: [Shadow(color: Colors.black)],
                ),
                title: Text(
                  'Delete',
                  style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
                ),

                onTap: () async {
                  bool? confirmDelete = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirm Delete",style: GoogleFonts.poppins(),),
                        content:  Text("Are you sure you want to delete this PDF?",style: GoogleFonts.poppins(),),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmDelete == true) {
                    setState(() {

                   // var pdfModelFa;
                   // DatabaseService().deletePDFfa(pdfModelFa.id as int);

                    });

                     Get.snackbar('Confirm','Delete Succesfull!');

                  }
                  Navigator.pop(context);
                }
            ),
          ],
        ),
      ),
    );

  }
}
