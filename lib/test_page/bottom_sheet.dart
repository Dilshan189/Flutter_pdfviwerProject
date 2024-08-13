import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdfviwer/service/database_service.dart';
import 'package:share/share.dart';
import 'package:path/path.dart' as path;
import 'browserpage.dart';


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
              title: const Text(
                'Edit Text',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'apots_bold',
                ),
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
              title: const Text(
                'Rename',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'apots_bold',
                ),
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
              title: const Text(
                'Edit PDF',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'apots_bold',
                ),
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
              title: const Text(
                'Set password',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'apots_bold',
                ),
              ),
              onTap: () {

                Navigator.pop(context);
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
              title: const Text(
                'Share',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'apots_bold',
                ),
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
              title: const Text(
                'Favorite',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'apots_bold',
                ),
              ),

              onTap: () async
              {
                //  String? filePath =  widget.file.filePath;
                //  String fileName = path.basename(filePath!);
                //
                //
                //  PdfFavouriteModel pdfFavouriteModel= PdfFavouriteModel(fileName: fileName, filePath: filePath);
                //
                // await DatabaseServiceFavourite().fainsertPdf(pdfFavouriteModel);
                Navigator.pop(context);
              },
            ),


            ListTile(
                leading: const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.blue,
                  weight: 55.3,
                  shadows: [Shadow(color: Colors.black)],
                ),
                title: const Text(
                  'Delete',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'apots_bold',
                  ),
                ),

                onTap: () async {
                  bool? confirmDelete = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Delete"),
                        content: const Text("Are you sure you want to delete this PDF?"),
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

                   // DatabaseService().deletePDF(pdf.id as int);
                    setState(() {

                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('PDF deleted Successfully')),
                    );
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}
