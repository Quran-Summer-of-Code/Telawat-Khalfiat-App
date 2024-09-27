import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mosharkat_ayat_app/features/surasList/model/ayah_model.dart';
import 'package:mosharkat_ayat_app/features/surasList/view/widgets/ayahItem.dart';
import 'package:mosharkat_ayat_app/features/surasList/view/widgets/creation_button.dart';
import 'package:mosharkat_ayat_app/features/surasList/view_model/suras_provider.dart';

class SuraScreen extends ConsumerWidget {
  final int numberofsura;
  final String suraName;
  const SuraScreen(
      {super.key, required this.numberofsura, required this.suraName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(child: Consumer(builder: (context, ref, child) {
      final ayatAyncValue = ref.watch(ayatProvider);
      return Scaffold(
        floatingActionButton: ayatAyncValue.when(
          data: (List<List<Ayah>> ayahs) => CreationButton(
              numberOfAyahs: ayahs[numberofsura].length,
              numberofsura: numberofsura),
          error: (error, stack) => const SizedBox(),
          loading: () => const CircularProgressIndicator(),
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 8, 90, 50),
          title: Center(
            child: Text(
              "سورة $suraName",
              style: const TextStyle(
                color: Colors.white,
                fontFamily: "Uthman",
              ),
            ),
          ),
        ),
        body: ayatAyncValue.when(
            data: (List<List<Ayah>> ayahs) => ListView.builder(
                  itemCount: ayahs[numberofsura].length,
                  itemBuilder: (context, index) {
                    final ayah = ayahs[numberofsura];
                    return index == 0 && numberofsura != 8
                        ? Column(
                            children: [
                              const Text("2",
                                  style: TextStyle(
                                      fontFamily: "KaalaTaala",
                                      fontSize: 40,
                                      color: Color.fromARGB(255, 8, 90, 50))),
                              Ayahitem(
                                  ayah: ayah[index].ayah,
                                  numberOfayah: index + 1,
                                  numberofsura: numberofsura),
                            ],
                          )
                        : Ayahitem(
                            ayah: ayah[index].ayah,
                            numberOfayah: index + 1,
                            numberofsura:
                                numberofsura); // Your existing list item widget
                  },
                ),
            error: (error, stack) => Text('Error: $error'),
            loading: () => const CircularProgressIndicator()),
      );
    }));
  }
}
