import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf_manipulator/pdf_manipulator.dart';
import 'package:pick_or_save/pick_or_save.dart';

class BottomMerge extends StatefulWidget {
  const BottomMerge({super.key});

  @override
  State<BottomMerge> createState() => _BottomMergeState();
}

class _BottomMergeState extends State<BottomMerge> {
  final _pdfManipulatorPlugin = PdfManipulator();
  final _pickOrSavePlugin = PickOrSave();

  bool _isBusy = false;
  final bool _localOnly = false;
  List<bool> isSelected = [true, false];

  List<String>? _pickedFilesPathsForMerge;
  String? _mergedPDFsPath;

  Future<String?> _mergePDFs(PDFMergerParams params) async {
    String? result;
    try {
      result = await _pdfManipulatorPlugin.mergePDFs(params: params);
    } on PlatformException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  Future<List<String>?> _filePicker(FilePickerParams params) async {
    List<String>? result;
    try {
      setState(() {
        _isBusy = true;
      });

      result = await _pickOrSavePlugin.filePicker(params: params);
    } on PlatformException catch (e) {
      log('File Picker Error: ${e.message}');
    } catch (e) {
      log('Unexpected Error: ${e.toString()}');
    }


    if (!mounted) return result;
    setState(() {
      _isBusy = false;
    });
    return result;
  }


  Future<List<String>?> _fileSaver(FileSaverParams params) async {
    List<String>? result;
    try {
      setState(() {
        _isBusy = true;
      });
      result = await _pickOrSavePlugin.fileSaver(params: params);
    } on PlatformException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isBusy = false;
        });
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          ListTile(
            title: Text(
              "Merging multiple PDFs.",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Card(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.zero,
            elevation: 15,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: _isBusy
                        ? null
                        : () async {
                      final params = FilePickerParams(
                        localOnly: _localOnly,
                        enableMultipleSelection: true,
                        mimeTypesFilter: ["application/pdf"],
                        allowedExtensions: [".pdf"],
                      );

                      List<String>? result =
                      await _filePicker(params);

                      if (result != null && result.isNotEmpty) {
                        setState(() {
                          _pickedFilesPathsForMerge = result;
                        });
                      }

                      if (mounted) {
                        callSnackBar(
                            context: context,
                            text: result.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(300, 40),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "Pick multiple PDF files",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    ),
                  ),

                  const SizedBox(height: 5),


                  ElevatedButton(
                    onPressed: _pickedFilesPathsForMerge == null ||
                        _pickedFilesPathsForMerge!.length < 2
                        ? null
                        : () async {
                      final params = PDFMergerParams(
                        pdfsPaths: _pickedFilesPathsForMerge!,
                      );

                      String? result = await _mergePDFs(params);

                      if (result != null && result.isNotEmpty) {
                        setState(() {
                          _mergedPDFsPath = result;
                        });
                      }

                      if (mounted) {
                        callSnackBar(
                            context: context,
                            text: result.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(300, 40),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "Merge",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    ),
                  ),

                  const SizedBox(height: 5),


                  ElevatedButton(
                    onPressed: _mergedPDFsPath == null || _isBusy
                        ? null
                        : () async {
                      final params = FileSaverParams(
                        localOnly: _localOnly,
                        saveFiles: [
                          SaveFileInfo(
                              filePath: _mergedPDFsPath,
                              fileName: "Merged PDF.pdf"),
                        ],
                      );

                      List<String>? result =
                      await _fileSaver(params);

                      if (mounted) {
                        callSnackBar(
                            context: context,
                            text: result.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(300, 40),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "Save merged PDF",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    ),
                  ),

                  const SizedBox(height: 5),

                ],
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

void callSnackBar({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}
