import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../floatingactionbutton/floationactionbutton.dart';
import '../homepage/pdf_screen.dart';
import '../model/pdf_favourite_model.dart';
import '../service/database_service_favourite.dart';
import 'bottom_sheet.dart';
import 'browserpage.dart';



class favorite extends StatefulWidget {
  const favorite({super.key});

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PDFfavouriteList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const actionbutton();
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add,color:Colors.white),
      ),
    );
  }
  Widget _PDFfavouriteList() {
    return FutureBuilder<List<PdfFavouriteModel>>(
      future: DatabaseServiceFavourite().fagetSavedPDFList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/icon/Animation - 1722676878214.json',
                width: 150,
                height: 150,
                ),
                const SizedBox(height: 2,),
                 Text("No data found",
                style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400,color:Colors.black54),
                 ),
              ],
          ));

        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              PdfFavouriteModel pdf = snapshot.data![index];


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
                        return BottomSheetContent(file:FileItem(path:'',name: '', size: '', modifiedDate: '',),
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
