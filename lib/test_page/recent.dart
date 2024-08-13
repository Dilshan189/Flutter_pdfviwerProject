import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdfviwer/homepage/pdf_screen.dart';
import 'package:pdfviwer/model/pdf_model.dart';
import 'package:pdfviwer/service/database_service.dart';
import 'package:pdfviwer/test_page/browserpage.dart';
import 'package:pdfviwer/test_page/recent_delete.dart';

import '../floatingactionbutton/floationactionbutton.dart';
import 'bottom_sheet.dart';
import 'change_screen.dart';


class Recent extends StatefulWidget {
  const Recent({super.key});

  @override
  State<Recent> createState() => _RecentState();
}

class _RecentState extends State<Recent> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PDFtasksList(),
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

  Widget _PDFtasksList() {
    return FutureBuilder<List<PDFModel>>(
      future: DatabaseService().getSavedPDFList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/paper_2.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 2,),

               Text("No data found",
                style:GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400,color:Colors.black54),
              ),

            ],
          ));

        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              PDFModel pdf = snapshot.data![index];

              return Card(

                shadowColor: Colors.grey,
                margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),

              ),
                child: ListTile(
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
                           return BottomSheetContent(file:FileItem(path:'filePath',name: 'fileName',),
                           );
                         },
                       );
                     },
                     icon: const Icon(Icons.more_vert),
                   ),
                  onLongPress: (){
                     Get.to(()=>const RecentDelete());
                  },
                ),
              );
            },
          );
        }
      },
    );
  }

}
