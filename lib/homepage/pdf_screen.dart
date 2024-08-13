import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdfviwer/consts/consts.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share/share.dart';
import '../const.dart';

class PDFScreen extends StatefulWidget {
  final String pdfPath;
  final String pdfName;
  final int index;
  final String path;

  const PDFScreen({
    super.key,
    required this.index,
    required this.path,
    required this.pdfPath,
    required this.pdfName,
  });

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  late PdfController pdfController;
  int _selectedIndex = 0;
  String fileName = '';

  ///PDF Reader Portrait added//////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();
    loadController();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    pdfController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Future<void> loadController() async {
    switch (widget.index) {
      case 0:
      case 1:
        pdfController = PdfController(document: PdfDocument.openFile(widget.pdfPath));
        break;
      default:
        pdfController = PdfController(document: PdfDocument.openAsset('assets/files/pdf.pdf'));
        break;
    }

    setState(() {
      fileName = widget.path.split('/').last;
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _rotateScreen,
            icon: const Icon(Icons.autorenew_rounded,color: Colors.black,),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.center,
            child: Text(
              pdfController.pagesCount == null ? ' ' : "Pages: ${pdfController.pagesCount}",
              style: textStyle(font: poppins),
            ),
          ),
        ],
        title: Text(
          fileName.isEmpty ? "Filename" : fileName,
          style: textStyle(font: poppins),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.black,
        ),
      ),
      body: Center(
        child: PdfView(controller: pdfController),
      ),


      bottomNavigationBar: BottomNavigationBar(
        items:const [
          BottomNavigationBarItem(icon: Icon(Icons.pages_outlined),label: 'Pages'),
          BottomNavigationBarItem(icon: Icon(Icons.edit_note_outlined),label: 'Edit'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined),label: 'View mode'),
          BottomNavigationBarItem(icon: Icon(Icons.ios_share),label: 'Share'),
        ],

        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w500),
        unselectedLabelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w500),
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,


      ),
    );
  }

  ///Added roisterer Screen connect portrait ///////////////////////////////////

  void _rotateScreen() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          final RenderBox box = context.findRenderObject() as RenderBox;
          Share.share(
            'Check out this PDF file: $fileName',
            subject: 'PDF Viewer App',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
          );
          break;
      }
    });
  }
}
