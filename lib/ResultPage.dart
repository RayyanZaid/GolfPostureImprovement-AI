import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ResultPage extends StatefulWidget {
  ResultPage({
    Key? key,
    required this.title,
    required this.video1File,
    required this.video2File,
  }) : super(key: key);
  PickedFile video1File;
  PickedFile video2File;
  final String title;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List links = [];

  @override
  void initState() {
    super.initState();
    uploadFileToServer();
  }

  Future<void> _saveImages(links) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dates = [];
    dates = prefs.getStringList('date') ?? [];

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd hh:mm a');
    String formattedDate = formatter.format(now);
    dates.add(formattedDate);
    prefs.setStringList('date', dates);
    prefs.setString(formattedDate, json.encode(links));
  }

  void uploadFileToServer() async {
    // This url is for local server. Then this url'll change to the public url
    var url = 'http://10.0.2.2:5000';
    Map<String, String> headers = {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=1000"
    };

    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse('$url/analize'));
    request.headers.addAll(headers);
    request.files.add(
      await http.MultipartFile.fromPath(
        'video1',
        widget.video1File.path,
        contentType: MediaType('application', 'mp4'),
      ),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'video2',
        widget.video2File.path,
        contentType: MediaType('application', 'mp4'),
      ),
    );

    request.send().then((r) async {
      print(r.statusCode);

      if (r.statusCode == 200) {
        // print((json.decode(await r.stream.transform(utf8.decoder).join())).runtimeType);
        var result = json.decode(await r.stream.transform(utf8.decoder).join());
        _saveImages(result);
        setState(() {
          links = result;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: links != null
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: links.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: [
                      Text(
                        'Image ${index + 1}',
                        style: TextStyle(fontSize: 20),
                      ),
                      Image.network(links[index][0]),
                      Image.network(links[index][1]),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ))
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Analyzing videos'),
                )
              ],
            )),
    );
  }
}
