import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Editor_Widget extends StatefulWidget {
  final String gifUrl;
  final List<String> audioUrls;
  final List<String> ayah;

  const Editor_Widget(
      {super.key,
      required this.gifUrl,
      required this.audioUrls,
      required this.ayah});

  @override
  State<Editor_Widget> createState() => _Editor_WidgetState();
}

class _Editor_WidgetState extends State<Editor_Widget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentAudioIndex = 0;
  Duration duration = Duration(seconds: 36);

  void _onAudioComplete() {
    if (_currentAudioIndex < widget.audioUrls.length - 1) {
      // Move to the next audio file
      setState(() {
        _currentAudioIndex++;
      });

      _playAudio(_currentAudioIndex);
    } else {
      setState(() {
        _currentAudioIndex = 0;
      });
      _playAudio(_currentAudioIndex);
    }
  }

  @override
  void initState() {
    super.initState();
    _playAudio(_currentAudioIndex);
    _audioPlayer.onPlayerComplete.listen((event) {
      _onAudioComplete();
    });
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            //margin: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
            width: 0.8.sw,
            height: 0.8.sh,
            child: Stack(
              children: [
                //caching the image
                //opacity: Opacity(0.5), or birhgtness: Brightness.dark
                Container(
                  color: Colors.black,
                  child: Image.asset(
                    "assets/backgrounds/${widget.gifUrl}",
                  ),
                ),
                SizedBox(
                  width: 0.9.sw,
                  height: 0.9.sh,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("بِسْمِ ٱللّٰهِِ الرَّحْمٰنِ الرَّحِيْمِ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      //TODO : Center the text
                      SizedBox(
                        width: 1.sw,
                        height: 0.6.sh,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.ayah[_currentAudioIndex],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Newmet",
                                    fontSize: 24,
                                    height: 2,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
