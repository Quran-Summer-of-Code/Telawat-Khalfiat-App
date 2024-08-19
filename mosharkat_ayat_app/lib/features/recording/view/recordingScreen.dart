import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      FlutterScreenRecording.stopRecordScreen;
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _playAudio(_currentAudioIndex);
    _audioPlayer.onPlayerComplete.listen((event) {
      _onAudioComplete();
    });
    FlutterScreenRecording.startRecordScreenAndAudio('مشاركة');
  }

  void _playAudio(int index) async {
    if (index < widget.audioUrls.length) {
      await _audioPlayer.play(UrlSource(widget.audioUrls[index]));
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
              //caching the image
              //opacity: Opacity(0.5), or birhgtness: Brightness.dark
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
                    Text("2",
                        style: TextStyle(
                          color: widget.currentColor,
                          fontFamily: "KaalaTaala",
                          fontSize: 32.spMax,
                        )),
                    SizedBox(
                      width: 1.sw,
                      height: 0.8.sh + (-widget.down + widget.up),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.ayah[_currentAudioIndex],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: widget.currentColor,
                                  fontFamily: "Newmet",
                                  fontSize: widget.fontSize,
                                  fontWeight: FontWeight.bold)),
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
