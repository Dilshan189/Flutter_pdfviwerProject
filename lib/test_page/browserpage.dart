import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../homepage/pdf_screen.dart';
import 'bottom_sheet.dart';

class BrowserPage extends StatefulWidget {
  const BrowserPage({super.key});

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> {

  late final int index;
  late final String path;

///RequestPermissions added this screen/////////////////////////////////////////

  List<File> pdfFiles = [];

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (await Permission.storage.isGranted) {
      getPdfFiles();
    }
  }

  void getPdfFiles() async {
    Directory? dir = await getExternalStorageDirectory();
    if (dir != null) {
      String? dirPath = dir.path;
      Directory pdfDirectory = Directory(dirPath);
      List<FileSystemEntity> files = pdfDirectory.listSync(recursive: true, followLinks: false);

      List<File> pdfFiles = files
          .where((file) => file.path.endsWith(".pdf"))
          .map((file) => File(file.path))
          .toList();

      setState(() {
        this.pdfFiles = pdfFiles;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          Divider(thickness: 2,),
          FileListItem(
            file: FileItem(
              name: "Sample PDF",
              date: "07/30/2024",
              size: "2.0 MB",
              path: "assets/files/Lecture 03.pdf",
            ),
          ),
          Divider(thickness: 2,),
          FileListItem(
            file: FileItem(
              name: "Sample PDF",
              date: "07/30/2024",
              size: "2.0 MB",
              path: "assets/files/Lecture 03.pdf",
            ),
          ),
          Divider(thickness: 2,),
          FileListItem(
            file: FileItem(
              name: "Sample PDF",
              date: "07/30/2024",
              size: "2.0 MB",
              path: "assets/files/Lecture 03.pdf",
            ),
          ),
          Divider(thickness: 2,),
          FileListItem(
            file: FileItem(
              name: "Sample PDF",
              date: "07/30/2024",
              size: "2.0 MB",
              path: "assets/files/pdf.pdf",
            ),
          ),
          Divider(thickness: 2,),
          FileListItem(
            file: FileItem(
              name: "Sample PDF",
              date: "07/30/2024",
              size: "2.0 MB",
              path: "assets/files/pdf.pdf",
            ),
          ),
          Divider(thickness: 2,),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class FileItem {
  final String name;
  final String date;
  final String size;
  final String path;

  const FileItem({
    required this.name,
    required this.date,
    required this.size,
    required this.path,
  });
}

class FileListItem extends StatelessWidget {
  final FileItem file;

  const FileListItem({Key? key, required this.file}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset('assets/images/pdf.png'),
      title: Text(file.name, overflow: TextOverflow.ellipsis),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(file.path),
          Text('${file.date}  ${file.size}'),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return BottomSheetContent(file: file);
            },
          );
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PDFScreen(index: 2, path: 'assets/files/Lecture 02.pdf'),
          ),
        );
      },
    );

  }
}
