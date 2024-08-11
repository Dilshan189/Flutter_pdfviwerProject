import 'package:flutter/material.dart';
import 'package:pdf_thumbnail/pdf_thumbnail.dart';
import 'package:pdfviwer/homepage/pdf_screen.dart';
import 'package:pdfviwer/model/pdf_model.dart';
import 'package:pdfviwer/service/database_service.dart';
import 'package:pdfviwer/test_page/browserpage.dart';

import '../floatingactionbutton/floationactionbutton.dart';
import 'bottom_sheet.dart';


class Recent extends StatefulWidget {
  const Recent({super.key});

  @override
  State<Recent> createState() => _RecentState();
}

class _RecentState extends State<Recent> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tasksList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const actionbutton();
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _tasksList() {
    return FutureBuilder<List<PDFModel>>(
      future: DatabaseService().getSavedPDFList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No data found"));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              PDFModel pdf = snapshot.data![index];


              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFScreen(
                        pdfPath:pdf.filePath,
                        pdfName:pdf.fileName ,
                        index: 0,
                        path: pdf.fileName,
                      ),
                    ),
                  );
                  setState(() {});
                },


                title: Text(pdf.fileName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                subtitle: Text(pdf.filePath),

                // leading: SizedBox(
                //   // color: Colors.white,
                //     height: 180,
                //     width: 50,
                //     child: PdfThumbnail.fromFile(
                //       scrollToCurrentPage: false,
                //        pdf.filePath,
                //         currentPage: 1,
                //         height: 56,
                //         backgroundColor: Colors.white,
                //     ),
                // ),

                leading:Image.asset("assets/images/icon.png",
                  width: 40,
                  height: 40,) ,


                 trailing:IconButton(
                   onPressed: (){
                     showModalBottomSheet(
                       context: context,
                       builder: (BuildContext context) {
                         return BottomSheetContent(file:FileItem(path:'',name: '',),
                         );
                       },
                     );
                   },
                   icon: const Icon(Icons.more_vert),
                 ),
              );
            },
          );
        }
      },
    );
  }

}
