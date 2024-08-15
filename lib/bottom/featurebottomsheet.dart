import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'requsetedthankyoubottom_sheet.dart';


class FeatureRequestBottomSheet extends StatefulWidget {
  final String imagePath;

  const FeatureRequestBottomSheet({required this.imagePath, Key? key}) : super(key: key);

  @override
  _FeatureRequestBottomSheetState createState() => _FeatureRequestBottomSheetState();
}

class _FeatureRequestBottomSheetState extends State<FeatureRequestBottomSheet> {
  bool _isSubmitButtonVisible = false;
  String _selectedCard = '';

  void _selectCard(String cardName) {
    setState(() {
      _selectedCard = cardName;
      _isSubmitButtonVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.98,
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              widget.imagePath,
              width: 100.0,
              height: 100.0,
            ),
            const SizedBox(height: 10.0),
            Text(
              'What other features do you want?',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(
              'We’ll prioritize adding the features you want',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 13),
            ),

            const SizedBox(height: 20.0),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          child: TextButton.icon(
                            onPressed: _selectedCard.isEmpty || _selectedCard == 'Scan to PDF'
                                ? () => _selectCard('Scan to PDF')
                                : null,
                            icon: const Icon(Icons.document_scanner_outlined,color: Colors.blue,),
                            label: Text('Scan to PDF', style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Card(
                          child: TextButton.icon(
                            onPressed: _selectedCard.isEmpty || _selectedCard == 'Cloud Sync'
                                ? () => _selectCard('Cloud Sync')
                                : null,
                            icon: const Icon(Icons.cloud_done_outlined,color: Colors.blue),
                            label: Text('Cloud Sync', style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      child: TextButton.icon(
                        onPressed: _selectedCard.isEmpty || _selectedCard == 'Create Folders'
                            ? () => _selectCard('Create Folders')
                            : null,
                        icon: const Icon(Icons.create_new_folder_outlined,color: Colors.blue),
                        label: Text('Create Folders', style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Card(
                      child: TextButton.icon(
                        onPressed: _selectedCard.isEmpty || _selectedCard == 'contents'
                            ? () => _selectCard('contents')
                            : null,
                        icon: const Icon(Icons.bookmark_add_outlined,color: Colors.blue),
                        label: Text('contents', style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      child: TextButton.icon(
                        onPressed: _selectedCard.isEmpty || _selectedCard == 'PDF to Images'
                            ? () => _selectCard('PDF to Images')
                            : null,
                        icon: const Icon(Icons.image_outlined,color: Colors.blue),
                        label: Text('PDF to Images', style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Card(
                      child: TextButton.icon(
                        onPressed: _selectedCard.isEmpty || _selectedCard == 'Others'
                            ? () => _selectCard('Others')
                            : null,
                        icon: const Icon(Icons.offline_bolt_outlined,color: Colors.blue),
                        label: Text('Others', style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                ),
              ],
            ),


            const SizedBox(height: 10),
            if (_isSubmitButtonVisible)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context){
                            return const Sheet();
                          });

                    },

                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(300, 50),
                    ),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
