import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share/share.dart';
import '../const.dart';


class PDFScreen extends StatefulWidget {
  final int index;
  final String path;

  const PDFScreen({super.key, required this.index, required this.path});

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
        pdfController = PdfController(document: PdfDocument.openFile(widget.path.toString()));
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
        actions: [
          IconButton(onPressed: () {_rotateScreen();},
            icon: const Icon(Icons.autorenew_rounded, color: Colors.black38,),
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
          style: textStyle(font: poppins,),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          focusColor: Colors.black38,
        ),
      ),
      body: Center(
        child: pdfController != null ? PdfView(controller: pdfController) : const CircularProgressIndicator(),
      ),

      ///PDF Reader bottomnavigationbar added///////////////////////////////////

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavigationBarItem(Icons.pages_outlined, 'Page', 0),
            _buildBottomNavigationBarItem(Icons.view_array_outlined, 'View mode', 1),
            _buildBottomNavigationBarItem(Icons.edit_note, 'Edit', 2),
            _buildBottomNavigationBarItem(Icons.ios_share_outlined, 'Share', 3),
          ],
        ),
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

///Bottomnavigationbar//////////////////////////////////////////////////////////

  Widget _buildBottomNavigationBarItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: _selectedIndex == index ? Colors.cyan : Colors.black,
          ),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600,).copyWith(
            color: _selectedIndex == index ? Colors.cyan : Colors.black,
            ),
          ),
        ],
      ),
    );
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
