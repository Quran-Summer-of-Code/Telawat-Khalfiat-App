import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mosharkat_ayat_app/features/surasList/model/sheikh_model.dart';

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
  double _brightness = 1.0;
  String _sheikhName = "ar.abdulbasitmurattal";
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
            height: 0.7.sh,
            child: Stack(
              children: [
                //caching the image
                //opacity: Opacity(0.5), or birhgtness: Brightness.dark
                Container(
                  width: 0.8.sw,
                  height: 0.6.sh,
                  color: Colors.black,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.matrix([
                      _brightness, 0, 0, 0, 0, // red channel
                      0, _brightness, 0, 0, 0, // green channel
                      0, 0, _brightness, 0, 0, // blue channel
                      0, 0, 0, 1, 0, // alpha channel
                    ]),
                    child: Image.asset(
                      "assets/backgrounds/${widget.gifUrl}",
                      fit: BoxFit.cover,
                    ),
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
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "قم باختيار صوت الشيخ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButton(
                    items: dropdownItems,
                    value: _sheikhName,
                    onChanged: (value) {
                      setState(() {
                        _sheikhName = value.toString();
                      });
                    }),
                const Text(
                  "سطوع الخلفية",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 0.8.sw,
                  child: Slider(
                    min: 0.0,
                    max: 2.0,
                    value: _brightness,
                    activeColor: const Color.fromARGB(255, 8, 90, 50),
                    onChanged: (value) {
                      setState(() {
                        _brightness = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
