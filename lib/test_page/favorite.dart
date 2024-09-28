import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf_thumbnail/pdf_thumbnail.dart';
import 'package:pdfviwer/model/pdf_favourite_model.dart';
import '../floatingactionbutton/floationactionbutton.dart';
import '../homepage/pdf_screen.dart';
import '../service/database_service_favourite.dart';




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
    return FutureBuilder<List<PDFModelFa>>(
      future: DatabaseService().getSavedPDFListfa(),
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
                style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400,),
                 ),
              ],
          ));

        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              PDFModelFa pdf = snapshot.data![index];
              var filePath = pdf.filePath;


              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                shape:  RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(5),
                  side:const BorderSide(
                    style:BorderStyle.solid
                  )


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
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  subtitle:
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children:

                      [
                        Text(pdf.filePath,
                          overflow: TextOverflow.ellipsis,
                        ),

                        Row(
                          children: [
                            Text(
                              pdf.modifiedDate,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Text(
                              'Size: ${pdf.size}',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        Row(
                            children:
                            [
                              const Icon(
                                Icons.folder,
                                size: 15,
                                weight: 50,
                              ),

                              const SizedBox(width: 5,),

                              Text('PDF',
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ]
                        ),
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


                  trailing:IconButton(
                    onPressed: (){

                        setState(() {
                          DatabaseService().deletePDFfa(pdf.id as int);
                        });


                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(' Delete Successful!'),
                          padding: EdgeInsets.all(15),
                          elevation: BorderSide.strokeAlignOutside,
                        )
                      );


                    },
                    icon: const Icon(Icons.delete_forever_outlined,color:Colors.blue),
                  ),
                ),
              );

            },
          );
        }
      },
    );
  }

}
