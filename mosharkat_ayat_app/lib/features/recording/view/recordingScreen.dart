import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class RecordingScreen extends StatefulWidget {
  String gifUrl;
  final List<String> audioUrls;
  final List<String> ayah;
  bool isAnimated;
  Color backgourndColor, currentColor;
  double brightness, down, up, fontSize;

  RecordingScreen(
      {super.key,
      required this.gifUrl,
      required this.audioUrls,
      required this.ayah,
      required this.isAnimated,
      required this.brightness,
      required this.down,
      required this.up,
      required this.fontSize,
      required this.currentColor,
      required this.backgourndColor});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentAudioIndex = 0;

  void _onAudioComplete() {
    if (_currentAudioIndex < widget.audioUrls.length - 1) {
      // Move to the next audio file
      setState(() {
        _currentAudioIndex++;
      });

      _playAudio(_currentAudioIndex);
    } else {
      Future<String> temp = FlutterScreenRecording.stopRecordScreen;
      temp.then((value) {
        transferVideoToGallery(value);
      });

      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();

    _playAudio(_currentAudioIndex);
    _audioPlayer.onPlayerComplete.listen((event) {
      _onAudioComplete();
    });

    init2();
  }

  void init2() async {
    FlutterScreenRecording.startRecordScreenAndAudio("test");
  }

  void _playAudio(int index) async {
    if (index < widget.audioUrls.length) {
      await _audioPlayer.play(UrlSource(widget.audioUrls[index]));
    }
  }

  Future<void> transferVideoToGallery(String path) async {
    // Get the path to the video in the cache folder

    // Check if the file exists
    if (await File(path).exists()) {
      // Save the video to the gallery
      await GallerySaver.saveVideo(path);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Container(
                width: 1.sw,
                height: 1.sh,
                color: Colors.black,
                child: ColorFiltered(
                    colorFilter: ColorFilter.matrix([
                      widget.brightness, 0, 0, 0, 0, // red channel
                      0, widget.brightness, 0, 0, 0, // green channel
                      0, 0, widget.brightness, 0, 0, // blue channel
                      0, 0, 0, 1, 0, // alpha channel
                    ]),
                    child: widget.isAnimated
                        ? Image.asset(
                            "assets/backgrounds/${widget.gifUrl}",
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: widget.backgourndColor,
                          )),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("2",
                          style: TextStyle(
                            color: widget.currentColor,
                            fontFamily: "KaalaTaala",
                            fontSize: 32.spMax,
                          )),
                    ),
                    SizedBox(
                      width: 1.sw,
                      height: 0.8.sh + (-widget.down + widget.up),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 0.8.sw,
                            margin: const EdgeInsets.all(8.0), // Add margin
                            child: Text(
                              widget.ayah[_currentAudioIndex],
                              textAlign: TextAlign.center,
                              //textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: widget.currentColor,
                                fontFamily: "Newmet",
                                fontSize:
                                    widget.ayah[_currentAudioIndex].length > 550
                                        ? 16
                                        : widget.ayah[_currentAudioIndex]
                                                    .length >
                                                250
                                            ? 18
                                            : widget.fontSize,
                                height: 2.5, // Adjust line spacing
                                fontWeight:
                                    widget.ayah[_currentAudioIndex].length > 550
                                        ? FontWeight.normal
                                        : FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
