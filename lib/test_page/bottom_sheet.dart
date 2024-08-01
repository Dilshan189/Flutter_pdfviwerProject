import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'browserpage.dart';

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
            const Divider(thickness: 1),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text(
                'Edit PDF',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Implement PDF editing
              },
            ),
            ListTile(
              leading: const Icon(Icons.text_fields, color: Colors.blue),
              title: const Text(
                'Rename',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Implement file renaming
              },
            ),
            ListTile(
              leading: const Icon(Icons.merge_type, color: Colors.blue),
              title: const Text(
                'Merge PDF',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Implement PDF merging
              },
            ),
            ListTile(
              leading: const Icon(Icons.call_split, color: Colors.blue),
              title: const Text(
                'Split PDF',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Implement PDF splitting
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.blue),
              title: const Text(
                'Set password',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Implement PDF password setting
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Colors.blue),
              title: const Text(
                'Share',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                final RenderBox box = context.findRenderObject() as RenderBox;
                Share.share(
                  'Check out this PDF file: ${file.name}',
                  subject: 'PDF Viewer App',
                  sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.blue),
              title: const Text(
                'Favorite',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Implement favorite functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.blue),
              title: const Text(
                'Delete',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Implement file deletion
              },
            ),
          ],
        ),
      ),
    );
  }
}
