import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pdfviwer/model/lockpdf_model.dart';
import '../homepage/search_bar.dart';
import '../service/database_service_lockpdf.dart';
import 'unlock_thankyoumsg.dart';

class UnlockPdf extends StatefulWidget {
  const UnlockPdf({super.key});

  @override
  State<UnlockPdf> createState() => _UnlockPdfState();
}

class _UnlockPdfState extends State<UnlockPdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select a file',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const Searchbar());
            },
            icon: const Icon(Icons.search_rounded),
          )
        ],
      ),
      body: _lockPDFList(),
    );
  }

  Widget _lockPDFList() {
    return FutureBuilder<List<LockpdfModel>>(
      future: DatabaseService().getSavedLockPdfList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/icon/Animation - 1722676878214.json',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 2),
                Text(
                  "No data found",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              LockpdfModel lockpdf = snapshot.data![index];

              return Card(
                shadowColor: Colors.grey,
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(style: BorderStyle.solid),
                ),

                child: ListTile(
                  onTap: () {
                    _showLockDialog(context, snapshot, lockpdf);
                  },

                  title: Text(
                    lockpdf.fileName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lockpdf.filePath,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Row(
                        children: [
                          const Icon(
                            Icons.folder_copy_outlined,
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'PDF',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  leading: Stack(
                    children: [
                      Image.asset(
                        "assets/images/icon.png",
                        width: 40,
                        height: 40,
                      ),
                      if (lockpdf.isLocked)
                        const Positioned(
                          top: 0,
                          right: 0,
                          child: Icon(
                            Icons.lock,
                            size: 15,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  void _showLockDialog(BuildContext context, AsyncSnapshot<List<LockpdfModel>> snapshot, LockpdfModel lockpdf) {
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Unlock Password",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              labelText: "Password",
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (passwordController.text == lockpdf.filePassword) {

                  setState(() {
                    DatabaseService().deleteLockPDF(lockpdf.id as int);
                  });

                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const unlockmsg(),
                    ),
                  );
                } else {
                  AnimatedSnackBar.material(
                    'Incorrect password , please try again',
                    type: AnimatedSnackBarType.error,
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                    desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
                    duration:const Duration(seconds: 5),
                    borderRadius: BorderRadius.circular(15),
                  ).show(context);
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
