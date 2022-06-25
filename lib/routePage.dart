import 'uploadVideoImagePage.dart';


import 'historyPage.dart';
import 'package:flutter/material.dart';

class RoutePage extends StatefulWidget {
  RoutePage({Key? key}) : super(key: key);


  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget>? _widgetOptions;

  void initState() {
    _widgetOptions = [
      HistoryPage(title: "History"),
      UploadPage(title: "Upload Your Video"),

    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('BottomNavigationBar Sample'),
      // ),
      body: Center(
        child: _widgetOptions!.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_rounded),
            label: 'Upload',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 81, 208, 24),
        onTap: _onItemTapped,
      ),
    );
  }
}
