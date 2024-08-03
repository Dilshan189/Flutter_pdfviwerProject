import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

import '../homepage/search_bar.dart';

class spiltpdf extends StatefulWidget {
  const spiltpdf({super.key});

  @override
  State<spiltpdf> createState() => _spiltpdfState();
}

class _spiltpdfState extends State<spiltpdf> {
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
        title: const Text('Select a file ',style: TextStyle(fontSize:20,color: Colors.black,fontWeight: FontWeight.w500),),
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
          );
        },
      ),
    );
  }
}
