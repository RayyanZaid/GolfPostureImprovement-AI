// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_editor_flutter/ResultPage.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'video_items.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool _isVideo1 = false;
  bool _isVideo2 = false;
  VideoPlayerController? _controller1;
  VideoPlayerController? _controller2;
  PickedFile? _video1File;
  PickedFile? _video2File;

  final ImagePicker _picker = ImagePicker();

  Future<void> _setVideoController(PickedFile file, isVideo1) async {
    if (file != null && mounted) {
      VideoPlayerController controller;
      print('play video ');
      if (kIsWeb) {
        controller = VideoPlayerController.network(file.path);
        print('network:' + file.path);
      } else {
        controller = VideoPlayerController.file(File(file.path));
        print('file:' + file.path);
      }
      setState(() {
        if (isVideo1) {
          _isVideo1 = true;
          _controller1 = controller;
        } else {
          _isVideo2 = true;
          _controller2 = controller;
        }
      });
    }
  }

  void _onVideo1ButtonPressed(ImageSource source) async {
    _video1File = await _picker.getVideo(
        source: source, maxDuration: const Duration(seconds: 10));
    await _setVideoController(_video1File!, true);
  }

  void _onVideo2ButtonPressed(ImageSource source) async {
    _video2File = await _picker.getVideo(
        source: source, maxDuration: const Duration(seconds: 10));
    await _setVideoController(_video2File!, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _controller1 != null && _controller2 != null
          ? Column(
              children: [
                Container(
                  height: 300,
                  child: VideoItems(
                    videoPlayerController: _controller1!,
                    autoplay: false,
                    looping: false,
                  ),
                ),
                Container(
                  height: 300,
                  child: VideoItems(
                    videoPlayerController: _controller2!,
                    autoplay: false,
                    looping: false,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ResultPage(
                                      title: 'Video Editor',
                                      video1File: _video1File!,
                                      video2File: _video2File!,
                                    )));
                      },
                      child: Text(
                        'Analyze Videos',
                        style: TextStyle(fontSize: 30),
                      )),
                )
              ],
            )
          : Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text(
                    'Video Editor',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        _isVideo1 = true;
                        _onVideo1ButtonPressed(ImageSource.gallery);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.upload_rounded,
                            size: 50.0,
                            semanticLabel: 'Upload Video1',
                          ),
                          Text('Upload Video'),
                        ],
                      ),
                    ),
                  ),
                  Text(_video1File != null ? _video1File!.path : ''),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        _isVideo2 = true;
                        _onVideo2ButtonPressed(ImageSource.gallery);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.upload_rounded,
                            size: 50.0,
                            semanticLabel: 'Upload Image',
                          ),
                          Text('Upload Video2'),
                        ],
                      ),
                    ),
                  ),
                  Text(_video2File != null ? _video2File!.path : ''),
                ])),
    );
  }
}
