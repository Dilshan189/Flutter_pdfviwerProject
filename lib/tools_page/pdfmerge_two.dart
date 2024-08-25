import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdfviwer/model/merge_pdf_model.dart';
import 'package:pdfviwer/test_page/test.dart';
import '../homepage/pdf_screen.dart';
import '../service/database_service_merge_pdf.dart';

class PDFmerge extends StatefulWidget {
  const PDFmerge({super.key});

  @override
  State<PDFmerge> createState() => _PDFmergeState();
}

class _PDFmergeState extends State<PDFmerge> {
  List<String> pdfFiles = [];
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Merge PDF',style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18),),

     leading: IconButton(
       onPressed: (){
         Navigator.pop(context);
       },

       icon:const Icon(Icons.arrow_back_ios_new_rounded),
     ),


      ),



      body: _MergePdf(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async{


          },
          label:Text('Save PDF',style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 20),
          ),
           backgroundColor: Colors.blue,
      ),
    );
  }


  Widget _MergePdf() {
    return FutureBuilder<List<MeargePDF>>(
      future: DatabaseService().getSavedMargePdf(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 2,),

              Text("No data found",
                style:GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400,),
              ),

            ],
          ));

        } else {

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              MeargePDF pdf = snapshot.data![index];

              return Card(

                shadowColor: Colors.grey,
                margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 15),
                shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side:const BorderSide(
                        style:BorderStyle.solid
                    )

                ),

                child: ListTile(


                  onTap: () async {
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
                      // overflow: TextOverflow.ellipsis,
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


                        const SizedBox(height: 4),

                        Row(
                            children:
                            [
                              const Icon(
                                Icons.folder_copy_outlined
                                ,size: 15,
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



                  leading:Image.asset("assets/images/icon.png",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ) ,




                  trailing: IconButton(
                    onPressed: (){
                      setState(() {
                        DatabaseService().deleteMearPDF(pdf.id as int);

                      });
                    },
                    icon:const  Icon(Icons.remove_circle_outline),
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
