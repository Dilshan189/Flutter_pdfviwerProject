import 'package:flutter/material.dart';
import '../service/database_service.dart';
import 'browserpage.dart';  // Ensure this import matches

class BottomSheetContent extends StatelessWidget {
  final FileItem file;

  const BottomSheetContent({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_note_outlined, color: Colors.blue,weight: 55.3,shadows: [Shadow(color: Colors.black)],),
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
              leading: const Icon(Icons.text_fields_outlined, color: Colors.blue,weight: 55.3,shadows: [Shadow(color: Colors.black)],),
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
              leading: const Icon(Icons.picture_as_pdf_outlined, color: Colors.blue,weight: 55.3,shadows: [Shadow(color: Colors.black)],),
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
              leading: const Icon(Icons.lock_outline, color: Colors.blue,weight: 55.3,shadows: [Shadow(color: Colors.black)],),
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
              leading: const Icon(Icons.ios_share_outlined, color: Colors.blue,weight: 55.3,shadows: [Shadow(color: Colors.black)],),
              title: const Text(
                'Share',
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
              leading: const Icon(Icons.favorite_outline_outlined, color: Colors.blue,weight: 55.3,shadows: [Shadow(color: Colors.black)],),
              title: const Text(
                'Favorite',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'apots_bold',
                ),
              ),
              onTap: () {



              },
            ),

            ListTile(
              leading: const Icon(Icons.delete_forever_outlined, color: Colors.blue,weight: 55.3,shadows: [Shadow(color: Colors.black)],),
              title: const Text(
                'Delete',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'apots_bold',
                ),
              ),
              onTap: () {


                Navigator.pop(context);
              },
            ),



          ],
        ),
      ),
    );
  }
}
