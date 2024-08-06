import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mosharkat_ayat_app/features/surasList/model/sheikh_model.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Editor_Widget extends StatefulWidget {
  final String gifUrl;
  final List<String> audioUrls;
  final List<String> ayah;
  final bool isAnimated;
  final Color backgourndColor;
  const Editor_Widget(
      {super.key,
      required this.gifUrl,
      required this.audioUrls,
      required this.ayah,
      required this.isAnimated,
      required this.backgourndColor});

  @override
  State<Editor_Widget> createState() => _Editor_WidgetState();
}

class _Editor_WidgetState extends State<Editor_Widget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentAudioIndex = 0;
  Duration duration = Duration(seconds: 36);
  double _brightness = 1.0;
  String _sheikhName = "ar.abdulbasitmurattal";
  int _option = 0;
  double _down = 0, _up = 0, _fontSize = 24;

  Color _currentColor = Colors.white;
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

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'قم باختيار لون الخط',
            textAlign: TextAlign.right,
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (Color color) {
                setState(() {
                  _currentColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('تم'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: 0.8.sw,
              height: 0.6.sh,
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
                        child: widget.isAnimated
                            ? Image.asset(
                                "assets/backgrounds/${widget.gifUrl}",
                                fit: BoxFit.cover,
                              )
                            : SizedBox(
                                width: 0.8.sw,
                                height: 0.6.sh,
                                child: Container(
                                  color: widget.backgourndColor,
                                ))),
                  ),
                  SizedBox(
                    width: 0.9.sw,
                    height: 0.9.sh,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("بِسْمِ ٱللّٰهِِ الرَّحْمٰنِ الرَّحِيْمِ",
                            style: TextStyle(
                                color: _currentColor,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 1.sw,
                          height: 0.5.sh + (-_down + _up),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(widget.ayah[_currentAudioIndex],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: _currentColor,
                                      fontFamily: "Newmet",
                                      fontSize: _fontSize,
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
          ),
          TextButton(
              onPressed: () {},
              child: const Text(
                "تحميل الصورة",
                style: TextStyle(color: Colors.green, fontSize: 24),
              )),
          Container(
              child: _option == 0
                  ? SizedBox(
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
                    )
                  : _option == 2
                      ? DropdownButton(
                          items: dropdownItems,
                          value: _sheikhName,
                          onChanged: (value) {
                            setState(() {
                              _sheikhName = value.toString();
                            });
                          })
                      : _option == 3
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _up += 10;
                                    });
                                  },
                                  icon: const Icon(Icons.arrow_upward),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _down += 10;
                                    });
                                  },
                                  icon: const Icon(Icons.arrow_downward),
                                ),
                              ],
                            )
                          : _option == 4
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _fontSize += 2;
                                        });
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                    Text(
                                      _fontSize.toString(),
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _fontSize -= 2;
                                        });
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                  ],
                                )
                              : const SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _option = 0;
                  });
                },
                icon: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.brightness_2_outlined,
                      size: 24.0,
                    ),
                    Text(
                      "سطوع الخلفية",
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  _showColorPicker();
                },
                icon: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.colorize,
                      size: 24.0,
                    ),
                    Text(
                      "لون الخط",
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _option = 3;
                  });
                },
                icon: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.format_align_center,
                      size: 24.0,
                    ),
                    Text(
                      "موضع الخط",
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _option = 4;
                  });
                },
                icon: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.wallet,
                      size: 24.0,
                    ),
                    Text(
                      'حجم الخط',
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _option = 2;
                  });
                },
                icon: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.audio_file,
                      size: 24.0,
                    ),
                    Text(
                      'صوت الشيخ',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
