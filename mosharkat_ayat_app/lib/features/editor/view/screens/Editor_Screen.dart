import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosharkat_ayat_app/features/editor/view/widgets/editor_widget.dart';
import 'package:mosharkat_ayat_app/features/surasList/model/ayah_model.dart';
import 'package:mosharkat_ayat_app/features/surasList/model/sura_model.dart';
import 'package:mosharkat_ayat_app/features/surasList/view_model/suras_provider.dart';

class Editor_Screen extends StatefulWidget {
  int numberOfSura, start, end;
  String sheikh, background;
  Editor_Screen(
      {super.key,
      required this.numberOfSura,
      required this.sheikh,
      required this.start,
      required this.background,
      required this.end});

  @override
  State<Editor_Screen> createState() => _Editor_ScreenState();
}

class _Editor_ScreenState extends State<Editor_Screen> {
  // final List<String> temp = [
  //   "https://cdn.islamic.network/quran/audio/128/ar.alafasy/32.mp3",
  //   "https://cdn.islamic.network/quran/audio/128/ar.alafasy/32.mp3",
  // ];

  @override
  Widget build(BuildContext context) {
    List<String> ayah = [];
    List<String> audio = [];
    return SafeArea(child: Consumer(builder: (context, ref, child) {
      final suraName = ref.watch(suraListProvider);
      final ayatAyncValue = ref.watch(ayatProvider);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 8, 90, 50),
          title: Center(
              child: suraName.when(
            data: (List<Sura> suras) {
              ayatAyncValue.when(
                data: (List<List<Ayah>> ayahs) {
                  for (int i = widget.start - 1; i < widget.end; i++) {
                    ayah.add(ayahs[widget.numberOfSura][i].ayah);
                    audio.add(
                        "https://cdn.islamic.network/quran/audio/128/ar.alafasy/${suras[widget.numberOfSura].firstAyah + i + 2}.mp3");
                    print(audio[i]);
                  }
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text('Error: $error'),
              );
              return Text(
                "مشاركة سورة ${suras[widget.numberOfSura].name} من الآية ${widget.start} الى الآية ${widget.end}",
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Uthman",
                ),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          )),
        ),
        body: Editor_Widget(
          gifUrl: widget.background,
          audioUrls: audio,
          ayah: ayah,
        ),
      );
    }));
  }
}
