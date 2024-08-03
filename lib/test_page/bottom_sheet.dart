import 'package:flutter/material.dart';
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
            // Other ListTiles...
          ],
        ),
      ),
    );
  }
}
