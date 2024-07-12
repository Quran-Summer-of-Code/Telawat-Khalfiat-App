import 'package:flutter/material.dart';
import 'package:mosharkat_ayat_app/features/editor/view/widgets/editor_widget.dart';

class Editor_Screen extends StatelessWidget {
  Editor_Screen({super.key});
  final List<String> temp = [
    "https://cdn.islamic.network/quran/audio/128/ar.alafasy/32.mp3",
    "https://cdn.islamic.network/quran/audio/128/ar.alafasy/32.mp3",
  ];
  final List<String> ayah = [
    "وَبَشِّرِ ٱلَّذِینَ ءَامَنُوا۟ وَعَمِلُوا۟ ٱلصَّـٰلِحَـٰتِ أَنَّ لَهُمۡ جَنَّـٰتࣲ تَجۡرِی مِن تَحۡتِهَا ٱلۡأَنۡهَـٰرُۖ كُلَّمَا رُزِقُوا۟ مِنۡهَا مِن ثَمَرَةࣲ رِّزۡقࣰا قَالُوا۟ هَـٰذَا ٱلَّذِی رُزِقۡنَا مِن قَبۡلُۖ وَأُتُوا۟ بِهِۦ مُتَشَـٰبِهࣰاۖ وَلَهُمۡ فِیهَاۤ أَزۡوَ ٰ⁠جࣱ مُّطَهَّرَةࣱۖ وَهُمۡ فِیهَا خَـٰلِدُونَ",
    "وَبَشِّرِ ٱلَّذِینَ ءَامَنُوا۟ وَعَمِلُوا۟ ٱلصَّـٰلِحَـٰتِ أَنَّ لَهُمۡ جَنَّـٰتࣲ تَجۡرِی مِن تَحۡتِهَا ٱلۡأَنۡهَـٰرُۖ كُلَّمَا رُزِقُوا۟ مِنۡهَا مِن ثَمَرَةࣲ رِّزۡقࣰا قَالُوا۟ هَـٰذَا ٱلَّذِی رُزِقۡنَا مِن قَبۡلُۖ وَأُتُوا۟ بِهِۦ مُتَشَـٰبِهࣰاۖ وَلَهُمۡ فِیهَاۤ أَزۡوَ ٰ⁠جࣱ مُّطَهَّرَةࣱۖ وَهُمۡ فِیهَا خَـٰلِدُونَ",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Mosharkat Ayat App'),
        // ),
        body: Editor_Widget(
            gifUrl: "assets/backgrounds/water2.gif",
            audioUrls: temp,
            ayah: ayah));
  }
}
