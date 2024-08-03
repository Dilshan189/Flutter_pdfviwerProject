import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path; // Import with alias
import 'package:pdfviwer/consts/consts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../homepage/search_bar.dart';


class marge extends StatefulWidget {
  const marge({super.key});

  @override
  State<marge> createState() => _margeState();
}

class _margeState extends State<marge> {

  List<String> pdfFiles = [];

  @override
  void initState() {
    super.initState();
    baseDirectory();
  }

  Future<void> baseDirectory() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;

    if (androidDeviceInfo.version.sdkInt < 30) {
      PermissionStatus permissionStatus = await Permission.storage.request();
      if (permissionStatus.isGranted) {
        var rootDirectory = await ExternalPath.getExternalStorageDirectories();
        await getFiles(rootDirectory.first);
      }
    } else {
      PermissionStatus permissionStatus = await Permission.manageExternalStorage.request();
      if (permissionStatus.isGranted) {
        var rootDirectory = await ExternalPath.getExternalStorageDirectories();
        await getFiles(rootDirectory.first);
      }
    }
  }

  Future<void> getFiles(String directoryPath) async {
    try {
      var rootDirectory = Directory(directoryPath);
      var directories = rootDirectory.list(recursive: false);
      await for (var element in directories) {
        if (element is File) {
          if (element.path.split(".").last == "pdf") {
            debugPrint("PDF File Name : ${element.path.split("/").last}");
            setState(() {
              pdfFiles.add(element.path);
            });
          }
        } else if (element is Directory) {
          await getFiles(element.path);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected',style: TextStyle(fontSize:20,color: Colors.black,fontWeight: FontWeight.w500),),
        actions: [IconButton(onPressed: (){
          Get.to(()=> const Searchbar());
        },
            icon: const  Icon(Icons.search_rounded))],

      ),
      body: ListView.builder(
        itemCount: pdfFiles.length,
        itemBuilder: (context, index) {
          String filePath = pdfFiles[index];
          String fileName = path.basename(filePath);
          return ListTile(
            onTap: () {

            },
            title: Text(fileName,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,),
            ),
            subtitle:  Text(
              pdfFiles[index],
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            leading: Image.asset(
              'assets/images/icon.png',
              width: 40,
              height: 40,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.check_box_outline_blank),
              onPressed: () {

              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
          backgroundColor: Colors.blue,
          icon: const Icon(Icons.picture_as_pdf_outlined,color: Colors.white,),
          label: const Text('Click',style: TextStyle(color: Colors.white),),
        
    ),
      
    );
      
  }
}
