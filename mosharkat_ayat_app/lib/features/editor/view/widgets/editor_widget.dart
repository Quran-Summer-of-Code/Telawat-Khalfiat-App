import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mosharkat_ayat_app/app/route.dart';
import 'package:mosharkat_ayat_app/features/editor/model/backgrounds.dart';
import 'package:mosharkat_ayat_app/features/surasList/model/sheikh_model.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Editor_Widget extends StatefulWidget {
  String gifUrl;
  final List<String> audioUrls;
  final List<String> ayah;
  bool isAnimated;
  Color backgourndColor;
  Editor_Widget(
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
  Duration duration = const Duration(seconds: 36);
  double _brightness = 0.8;
  String _sheikhName = "ar.abdulbasitmurattal";
  int _option = 0;
  double _down = 0, _up = 0, _fontSize = 24;
  bool _isPlaying = true;
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
            child: BlockPicker(
              pickerColor: _currentColor,
              availableColors: fontColors,
              onColorChanged: (Color color) {
                setState(() {
                  _currentColor = color;
                });
              },
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

  void _showBottomSheet(bool isAnimated) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5, // Initial height of the bottom sheet
          minChildSize: 0.5, // Minimum height of the bottom sheet
          maxChildSize: 1.0, // Maximum height of the bottom sheet
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                controller: scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns in the grid
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: isAnimated
                    ? backgrounds.length
                    : staticBackgrounds.length, // Number of items in the grid
                itemBuilder: (BuildContext context, int index) {
                  return isAnimated
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.gifUrl = backgrounds[index];
                              widget.isAnimated = true;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(137, 0, 0, 0),
                                width: 2,
                              ),
                            ),
                            child: Image.asset(
                                "assets/backgrounds/${backgrounds[index]}",
                                fit: BoxFit.cover),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.backgourndColor = staticBackgrounds[index];
                              widget.isAnimated = false;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: staticBackgrounds[index],
                              border: Border.all(
                                color: const Color.fromARGB(137, 0, 0, 0),
                                width: 2,
                              ),
                            ),
                          ),
                        );
                },
              ),
            );
          },
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
          SizedBox(
            width: 1.sw,
            height: 0.6.sh,
            child: Stack(
              children: [
                //caching the image
                //opacity: Opacity(0.5), or birhgtness: Brightness.dark
                Container(
                  width: 1.sw,
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
                  height: 0.9.sh,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("2",
                          style: TextStyle(
                            color: _currentColor,
                            fontFamily: "KaalaTaala",
                            fontSize: 32.spMax,
                          )),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(137, 0, 0, 0),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (_audioPlayer.state == PlayerState.playing) {
                          _audioPlayer.pause();
                          _isPlaying = false;
                        } else {
                          _audioPlayer.resume();
                          _isPlaying = true;
                        }
                      });
                    },
                    icon: _isPlaying
                        ? Icon(
                            Icons.pause,
                            color: Colors.white,
                            size: 20.spMax,
                          )
                        : Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 20.spMax,
                          )),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(137, 0, 0, 0),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                    onPressed: () {
                      _playAudio(0);
                      setState(() {
                        _currentAudioIndex = 0;
                      });
                    },
                    icon: Icon(
                      Icons.restore,
                      color: Colors.white,
                      size: 20.spMax,
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(137, 0, 0, 0),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, RouteClass.recording,
                          arguments: {
                            "gifUrl": widget.gifUrl,
                            "audioUrls": widget.audioUrls,
                            "ayah": widget.ayah,
                            "isAnimated": widget.isAnimated,
                            "backgourndColor": widget.backgourndColor,
                            "brightness": _brightness,
                            "down": _down,
                            "up": _up,
                            "fontSize": _fontSize,
                            "currentColor": _currentColor
                          });
                    },
                    icon: Icon(
                      Icons.download,
                      color: Colors.white,
                      size: 20.spMax,
                    )),
              )
            ],
          ),
          Container(
              child: _option == 0
                  ? SizedBox(
                      width: 0.8.sw,
                      child: Slider(
                        min: 0.0,
                        max: 1.6,
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
                              : _option == 5
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                          TextButton(
                                              onPressed: () {
                                                _showBottomSheet(true);
                                              },
                                              child: Text(
                                                "خلفية متحركة",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Uthman",
                                                    fontSize: 75.sp),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                _showBottomSheet(false);
                                              },
                                              child: Text(
                                                "خلفية  ثابتة",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Uthman",
                                                    fontSize: 75.sp),
                                              )),
                                        ])
                                  : const SizedBox()),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_option == 0)
                        _option = -1;
                      else
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
                IconButton(
                  onPressed: () {
                    //_showBackGroundPicker();
                    setState(() {
                      _option = 5;
                    });
                  },
                  icon: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image,
                        size: 24.0,
                      ),
                      Text('تغير الخلفية'),
                    ],
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
