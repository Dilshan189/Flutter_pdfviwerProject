import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf_manipulator/pdf_manipulator.dart';
import 'package:pdfx/pdfx.dart';
import 'package:pick_or_save/pick_or_save.dart';

import 'SplitepMearg.dart';

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
  late PdfControllerPinch pdfControllerPinch;
  bool isHorizontal = true; // To toggle between horizontal and vertical scroll

  final _pdfManipulatorPlugin = PdfManipulator();
  final _pickOrSavePlugin = PickOrSave();



  String? _pickedFilePathForSplit;
  List<String>? _splitPDFPaths;
  int pageCount = 2;
  int byteSize = 1000000;
  List<int> pageNumbers = [2, 5, 9];
  String pageRange = "1-3,5-8";



  Future<List<String>?> _splitPDF(PDFSplitterParams params) async {
    List<String>? result;
    try {
      result = await _pdfManipulatorPlugin.splitPDF(params: params);
    } on PlatformException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
    return result;
  }



  @override
  void initState() {
    super.initState();
    loadController();
  }

  Future<void> loadController() async {
    pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openFile(widget.pdfPath),
    );
    setState(() {});
  }

  // Function to show bottom sheet for slide options
  void _showSlideOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Slide Option',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        isHorizontal = true;
                      });
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text('Horizontal'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      isHorizontal ? Colors.blue : Colors.grey,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        isHorizontal = false;
                      });
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    icon: const Icon(Icons.swap_vert),
                    label: const Text('Vertical'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      !isHorizontal ? Colors.blue : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Selected',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        actions: [
          // Add icon button to open bottom sheet for slide options
          IconButton(
            icon: const Icon(Icons.view_day),
            onPressed: _showSlideOptions, // Open the bottom sheet
          ),
        ],
      ),
      body: pdfControllerPinch != null
          ? PdfViewPinch(
        controller: pdfControllerPinch,
        scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
        backgroundDecoration: const BoxDecoration(
          color: Colors.white,
        ),
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {

            showModalBottomSheet(
              context: context,
              builder: (context) =>const SplitepMearg());

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('CONTINUE'),
        ),
      ),
    );
  }
}
