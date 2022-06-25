import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_editor_flutter/ImagePage.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Map _history = {};

  void initState() {
    _loadHistory();
  }

  _loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List dates = [];
    print(prefs.containsKey('date'));
    if (prefs.containsKey('date')) {
      dates = prefs.getStringList('date')!;
      for (var date in dates) {
        _history[date] = json.decode(prefs.getString(date)!);
      }

      print(_history.keys);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: _history.length,
          itemBuilder: (BuildContext context, int index) {
            print(_history);
            String date = _history.keys.elementAt(index);

            return Card(
                child: ListTile(
              title: Text(
                date,
                style: TextStyle(fontSize: 20),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.play_circle_fill_outlined),
                tooltip: 'Show Images',
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => ImagePage(
                                title: date,
                                links: _history[date],
                              )));
                },
              ),
            ));
          }),
    );
  }
}
