import 'package:flutter/material.dart';
import 'package:pdfviwer/homepage/pdf_screen.dart';
import 'package:pdfviwer/model/task.dart';
import 'package:pdfviwer/service/database_service.dart';

class Recent extends StatefulWidget {
  const Recent({super.key});

  @override
  State<Recent> createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  final DatabaseService _databaseService = DatabaseService.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tasksList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _tasksList() {
    return FutureBuilder<List<PDF>>(
      future: _databaseService.getTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No data found"));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              PDF pdf = snapshot.data![index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFScreen(
                        pdfPath:pdf.content,
                        pdfName:pdf.content ,
                        index: 0,
                        path: pdf.content,
                      ),
                    ),
                  );
                  setState(() {});
                },
                title: Text(pdf.content,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                leading: Image.asset(
                  'assets/icon.png',
                  width: 40,
                  height: 40,
                ),
                trailing: Checkbox(
                  value: pdf.status == 1,
                  onChanged: (value) {
                    _databaseService.updateTaskStatus(pdf.id, value! ? 1 : 0);
                    setState(() {});
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
