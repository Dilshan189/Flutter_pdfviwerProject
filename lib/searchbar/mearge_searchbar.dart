import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;
import 'package:pdf_thumbnail/pdf_thumbnail.dart';

class MeargeSearchbar extends StatefulWidget {
  @override
  _MeargeSearchbarState createState() => _MeargeSearchbarState();
}

class _MeargeSearchbarState extends State<MeargeSearchbar> {
  List<String> pdfFiles = [];
  List<String>? searchResults;
  final FocusNode _textFocusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pdfFiles = List<String>.from(Get.arguments ?? []);
    debugPrint('PDF Files: $pdfFiles');
    searchResults = pdfFiles;
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Container(
              alignment: Alignment.center,
              height: 40,
              child: TextFormField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    suffixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search PDF',
                    contentPadding: EdgeInsets.all(8)),
                onChanged: (value) {
                  setState(() {
                    searchResults = pdfFiles
                        .where((element) =>
                        element.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                    if (_textEditingController.text.isNotEmpty &&
                        searchResults!.isEmpty) {
                      debugPrint('No results found');
                    }
                  });
                },
              ),
            )),

        body: _textEditingController.text.isNotEmpty && searchResults!.isEmpty
            ? const Center(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search_off,
                    size: 160,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'No results found,\nPlease try a different keyword',
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        )
            : ListView.builder(
            itemCount: searchResults!.length,
            itemBuilder: (ctx, index) {
              String filePath = searchResults![index];



              return Card(
                margin:const  EdgeInsets.symmetric(vertical: 4,horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side:const BorderSide(
                    style: BorderStyle.solid,
                  )

                ),



                child: ListTile(
                  title: Text(
                    path.basename(filePath),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  subtitle: Column(

                    children:[ Text(
                      filePath,
                        overflow: TextOverflow.ellipsis,
                    ),

                       Row(
                        children: [
                          const Icon(Icons.folder_copy_outlined,
                          size: 15,
                            weight: 50,
                          ),

                          const SizedBox(width: 5),

                          Text('PDF',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              color: Colors.grey,

                            ),
                          ),

                        ],
                      )

                  ]
                  ),


                  leading: SizedBox(
                    width: 50,
                    height: 188,
                    child: PdfThumbnail.fromFile(
                      scrollToCurrentPage: false,
                      filePath,
                      currentPage: 0,
                      height: 56,
                      backgroundColor: Colors.transparent,
                    ),
                  ),


                  trailing: IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.check_box_outline_blank),
                  ),

                ),
              );
            }
            ),
    );
  }
}
