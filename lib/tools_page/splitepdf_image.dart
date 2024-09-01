import 'package:flutter/material.dart';
import 'package:pdfviwer/consts/consts.dart';
import 'package:pdfx/pdfx.dart';


class PDFScreenSp extends StatefulWidget {
  final String pdfPath;
  final String pdfName;
  final int index;
  final String path;


  const PDFScreenSp({
    super.key,
    required this.index,
    required this.path,
    required this.pdfPath,
    required this.pdfName,
  });

  @override
  State<PDFScreenSp> createState() => _PDFScreenSpState();
}

class _PDFScreenSpState extends State<PDFScreenSp> {
  late PdfController pdfController;

  @override
  void initState() {
    super.initState();
    loadController();
  }


  Future<void> loadController() async {
    switch (widget.index) {
      case 0:
        pdfController =
            PdfController(document: PdfDocument.openFile(widget.pdfPath));
        break;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:const Text('Selected'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),

      bottomNavigationBar: ElevatedButton(
        onPressed: (){},
        style:ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
            minimumSize: const Size(50, 50),
        ),
        child: const Text('CONTINUE'),
      ),
      body: Center(
        child: PdfView(controller: pdfController,
        backgroundDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        ),
      ),

    );
  }
}