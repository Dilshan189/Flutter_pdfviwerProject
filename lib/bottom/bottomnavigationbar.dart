import 'package:flutter/material.dart';
import 'package:pdfviwer/test_page/test.dart';

import '../test_page/browserpage.dart';
import '../test_page/favorite.dart';
import '../test_page/recent.dart';




class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;
  String appBarTitle = 'All files';

  List<Widget> widgetList = const [

    browserpage(),
    recent(),
    favorite(),
    tools(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.file_open_outlined),
            label: 'All files',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later_outlined),
            label: 'Recent',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorite',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.apps_rounded),
            label: 'Tools',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          appBarTitle = 'All files';
          break;
        case 1:
          appBarTitle = 'Recent';
          break;
        case 2:
          appBarTitle = 'Favorite';
          break;
        case 3:
          appBarTitle = 'Tools';
          break;
      }
    },);
  }
}

