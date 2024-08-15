import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdfviwer/consts/consts.dart';
import 'package:pdfviwer/model/pdf_model.dart';
import 'package:pdfviwer/service/database_service.dart';


class RecentDelete extends StatefulWidget {
  const RecentDelete({super.key});

  @override
  State<RecentDelete> createState() => _RecentDeleteState();
}

class _RecentDeleteState extends State<RecentDelete> {
  int _selectedIndex = 0;
  List<String> selectedFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selected',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
        ),
        actions: [

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.apps_rounded),
          ),
        ],
      ),

      body: _PDFtasksList(),

      bottomNavigationBar: BottomNavigationBar(
        items: const [

          BottomNavigationBarItem(icon: Icon(Icons.ios_share), label: 'Share'),
          BottomNavigationBarItem(icon: Icon(Icons.delete_forever_outlined), label: 'Delete'),
          BottomNavigationBarItem(icon: Icon(Icons.remove_circle_outline), label: 'Remove'),

        ],


        currentIndex: _selectedIndex,
        selectedLabelStyle:
        GoogleFonts.poppins(fontWeight: FontWeight.w500),
        unselectedLabelStyle:
        GoogleFonts.poppins(fontWeight: FontWeight.w500),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: _onTapped,

      ),
    );
  }


  Widget _PDFtasksList() {
    return FutureBuilder<List<PDFModel>>(
      future: DatabaseService().getSavedPDFList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center();
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              PDFModel pdf = snapshot.data![index];


              return Card(
                shadowColor: Colors.grey,
                margin:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListTile(
                  title: Text(
                    pdf.fileName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),


                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children:[
                      Text(pdf.filePath,
                        overflow: TextOverflow.ellipsis,
                    ),
                      Text('PDF',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.grey),
                      ),
                ]
                ),







                  leading: Image.asset(
                    "assets/images/icon.png",
                    width: 40,
                    height: 40,
                  ),

                  trailing:const Icon(Icons.check_box_outline_blank
                  ),
                  onTap: () {

                  },

                ),
              );
            },
          );
        }
      },
    );
  }


  void _onTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;



      default:
        break;
    }
  }

}
