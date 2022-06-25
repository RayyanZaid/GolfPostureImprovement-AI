import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  ImagePage({
    Key? key,
    required this.title,
    required this.links,
  }) : super(key: key);
  List links;
  final String title;

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: widget.links.length,
        itemBuilder: (BuildContext context, int index) {
            return ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                Text(
                  'Image ${index + 1}',
                  style: TextStyle(fontSize: 20),
                ),
                Image.network(widget.links[index][0]),
                Image.network(widget.links[index][1]),
              ],
            );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
          )),
    );
  }
}
