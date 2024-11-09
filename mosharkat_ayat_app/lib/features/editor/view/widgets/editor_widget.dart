import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mosharkat_ayat_app/app/route.dart';
import 'package:mosharkat_ayat_app/features/editor/model/audioBitrate.dart';
import 'package:mosharkat_ayat_app/features/editor/model/backgrounds.dart';
import 'package:mosharkat_ayat_app/features/surasList/model/sheikh_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../view_model/providers.dart';

class Editor_Widget extends ConsumerStatefulWidget {
  List<String> ayah;
  int start, end, numberOfSura, indexOfAyah;
  Editor_Widget(
      {super.key,
      required this.ayah,
      required this.start,
      required this.end,
      required this.numberOfSura,
      required this.indexOfAyah});

  @override
  Editor_WidgetState createState() => Editor_WidgetState();
}

class Editor_WidgetState extends ConsumerState<Editor_Widget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentAudioIndex = 0;
  Duration duration = const Duration(seconds: 36);
  late double _brightness;
  late String _sheikhName;
  late List<String> audioUrls = [];
  late String gifUrl;
  late bool isAnimated;
  late Color backgourndColor;
  int _option = 0;
  double _down = 0, _up = 0, _fontSize = 24;
  bool _isPlaying = false;
  Color _currentColor = Colors.white;

  void _onAudioComplete() {
    if (_currentAudioIndex < audioUrls.length - 1) {
      // Move to the next audio file
      setState(() {
        _currentAudioIndex++;
      });

      _playAudio(_currentAudioIndex);
    } else {
      setState(() {
        _currentAudioIndex = 0;
        _isPlaying = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _sheikhName = ref.read(sheikhNameProvider);
    gifUrl = ref.read(gifUrlProvider);
    isAnimated = ref.read(isAnimatedProvider);
    _brightness = ref.read(brightnessProvider);
    backgourndColor = ref.read(backgourndColorProvider);
    int? bitRateTemp = bitRate[_sheikhName.toString()];
    audioUrls.clear();
    for (int i = widget.start - 1; i < widget.end; i++) {
      audioUrls.add(
          "https://cdn.islamic.network/quran/audio/$bitRateTemp/${_sheikhName.toString()}/${widget.indexOfAyah + i + 2}.mp3");
    }
    _playAudio(_currentAudioIndex);
    _audioPlayer.onPlayerComplete.listen((event) {
      _onAudioComplete();
    });
  }

  void _playAudio(int index) async {
    if (index < audioUrls.length && _isPlaying) {
      await _audioPlayer.play(UrlSource(audioUrls[index]));
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
                              ref
                                  .read(gifUrlProvider.notifier)
                                  .update((state) => backgrounds[index]);
                              ref
                                  .read(isAnimatedProvider.notifier)
                                  .update((state) => true);
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
                              ref
                                  .read(backgourndColorProvider.notifier)
                                  .update((state) => staticBackgrounds[index]);

                              ref
                                  .read(isAnimatedProvider.notifier)
                                  .update((state) => false);
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
    _sheikhName = ref.watch(sheikhNameProvider);
    gifUrl = ref.watch(gifUrlProvider);
    isAnimated = ref.watch(isAnimatedProvider);
    _brightness = ref.watch(brightnessProvider);
    backgourndColor = ref.watch(backgourndColorProvider);
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
                      child: isAnimated
                          ? Image.asset(
                              "assets/backgrounds/$gifUrl",
                              fit: BoxFit.cover,
                            )
                          : SizedBox(
                              width: 0.8.sw,
                              height: 0.6.sh,
                              child: Container(
                                color: backgourndColor,
                              ))),
                ),
                SizedBox(
                  height: 0.9.sh,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.numberOfSura != 8
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text("2",
                                  style: TextStyle(
                                    color: _currentColor,
                                    fontFamily: "KaalaTaala",
                                    fontSize: 32.spMax,
                                  )),
                            )
                          : const SizedBox(),
                      SizedBox(
                        width: 1.sw,
                        height: 0.5.sh + (_down - _up),
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
                                  color: _currentColor,
                                  fontFamily: "Newmet",
                                  fontSize: widget
                                              .ayah[_currentAudioIndex].length >
                                          550
                                      ? 12.5
                                      : widget.ayah[_currentAudioIndex].length >
                                              250
                                          ? 18
                                          : _fontSize,
                                  height: 2.5, // Adjust line spacing
                                  fontWeight:
                                      widget.ayah[_currentAudioIndex].length >
                                              550
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(181, 8, 90, 50),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (_audioPlayer.state == PlayerState.playing) {
                          _audioPlayer.pause();
                          _isPlaying = false;
                        } else {
                          _isPlaying = true;
                          _playAudio(_currentAudioIndex);
                          _audioPlayer.resume();
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
                  color: const Color.fromARGB(181, 8, 90, 50),
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
                  color: const Color.fromARGB(181, 8, 90, 50),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, RouteClass.recording,
                          arguments: {
                            "gifUrl": gifUrl,
                            "audioUrls": audioUrls,
                            "ayah": widget.ayah,
                            "isAnimated": isAnimated,
                            "backgourndColor": backgourndColor,
                            "brightness": _brightness,
                            "down": _down,
                            "up": _up,
                            "fontSize": _fontSize,
                            "currentColor": _currentColor
                          });
                    },
                    icon: Icon(
                      Icons.screen_lock_landscape,
                      color: Colors.white,
                      size: 20.spMax,
                    )),
              )
            ],
          ),
          SizedBox(
            width: 0.60.sw,
            child: const Divider(
              color: Color.fromARGB(255, 8, 90, 50),
              thickness: 1,
            ),
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
                            ref.read(brightnessProvider.notifier).update(
                                  (state) => value,
                                );
                          });
                        },
                      ),
                    )
                  : _option == 2
                      ? DropdownButton(
                          items: dropdownItems,
                          value: _sheikhName,
                          onChanged: (value) {
                            int? bitRateTemp = bitRate[value.toString()];
                            audioUrls.clear();
                            for (int i = widget.start - 1;
                                i < widget.end;
                                i++) {
                              audioUrls.add(
                                  "https://cdn.islamic.network/quran/audio/$bitRateTemp/${value.toString()}/${widget.indexOfAyah + i + 2}.mp3");
                            }
                            _playAudio(0);
                            setState(() {
                              _currentAudioIndex = 0;
                              ref.read(sheikhNameProvider.notifier).update(
                                    (state) => value.toString(),
                                  );
                            });
                          })
                      : _option == 3
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_up < 50) {
                                        _up += 10;
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.arrow_upward),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_down < 50) {
                                        _down += 10;
                                      }
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
                                          if (_fontSize < 42) {
                                            _fontSize += 2;
                                          }
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
                                          if (_fontSize > 12) {
                                            _fontSize -= 2;
                                          }
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
                                            style: TextButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 24.0),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 8, 90, 50),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              shadowColor:
                                                  Colors.black.withOpacity(0.2),
                                              elevation: 5,
                                            ),
                                            child: Text(
                                              "خلفية متحركة",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Uthman",
                                                fontSize: 65.sp,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _showBottomSheet(false);
                                            },
                                            style: TextButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 24.0),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 8, 90, 50),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              shadowColor:
                                                  Colors.black.withOpacity(0.2),
                                              elevation: 5,
                                            ),
                                            child: Text(
                                              "خلفية ثابتة",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Uthman",
                                                fontSize: 70.sp,
                                              ),
                                            ),
                                          ),
                                        ])
                                  : const SizedBox()),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.arrow_forward_ios,
                      size: 16.0, color: Colors.grey),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_option == 0) {
                        _option = -1;
                      } else {
                        _option = 0;
                      }
                    });
                  },
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.brightness_2_outlined,
                        size: 24.0,
                        color: (_option == 0) ? Colors.green : Colors.black,
                      ),
                      Text("سطوع الخلفية",
                          style: TextStyle(
                              color: (_option == 0)
                                  ? Colors.green
                                  : Colors.black)),
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
                      if (_option == 3) {
                        _option = -1;
                      } else {
                        _option = 3;
                      }
                    });
                  },
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.format_align_center,
                        size: 24.0,
                        color: (_option == 3) ? Colors.green : Colors.black,
                      ),
                      Text("موضع الخط",
                          style: TextStyle(
                              color: (_option == 3)
                                  ? Colors.green
                                  : Colors.black)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //_showBackGroundPicker();
                    setState(() {
                      if (_option == 5) {
                        _option = -1;
                      } else {
                        _option = 5;
                      }
                    });
                  },
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image,
                        size: 24.0,
                        color: (_option == 5) ? Colors.green : Colors.black,
                      ),
                      Text('تغير الخلفية',
                          style: TextStyle(
                              color: (_option == 5)
                                  ? Colors.green
                                  : Colors.black)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_option == 2) {
                        _option = -1;
                      } else {
                        _option = 2;
                      }
                    });
                  },
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.audio_file,
                        size: 24.0,
                        color: (_option == 2) ? Colors.green : Colors.black,
                      ),
                      Text('صوت الشيخ',
                          style: TextStyle(
                              color: (_option == 2)
                                  ? Colors.green
                                  : Colors.black)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_option == 4) {
                        _option = -1;
                      } else {
                        _option = 4;
                      }
                    });
                  },
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.wallet,
                        size: 24.0,
                        color: (_option == 4) ? Colors.green : Colors.black,
                      ),
                      Text('حجم الخط',
                          style: TextStyle(
                              color: (_option == 4)
                                  ? Colors.green
                                  : Colors.black)),
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
