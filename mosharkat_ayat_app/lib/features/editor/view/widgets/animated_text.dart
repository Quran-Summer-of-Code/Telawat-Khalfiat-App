// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/material.dart';

// class animatedWidget extends StatefulWidget {
//   final String ayah;
//   final Duration duration;
//   const animatedWidget({super.key, required this.ayah, required this.duration});

//   @override
//   State<animatedWidget> createState() => _animatedWidgetState();
// }

// class _animatedWidgetState extends State<animatedWidget> {
//   List<AnimatedText> _animatedTexts = [];
//   @override
//   void initState() {
//     int words = widget.ayah.split(" ").length;

//     int wordsPerSecond = (words / widget.duration.inSeconds).ceil() + 2;

//     for (int i = 0; i < words; i += wordsPerSecond) {
//       _animatedTexts.add(RotateAnimatedText(
//         widget.ayah
//             .split(" ")
//             .sublist(
//                 i, i + wordsPerSecond >= words ? words : i + wordsPerSecond)
//             .join(" "),
//         textStyle: const TextStyle(
//             fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.blue),
//       ));
//     }

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedTextKit(
//       animatedTexts: _animatedTexts,
//       totalRepeatCount: 1,
//       pause: const Duration(milliseconds: 250),
//     );
//   }
// }
