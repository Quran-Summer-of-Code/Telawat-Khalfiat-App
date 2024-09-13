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
              suraName,
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
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.center, // Center the text

                          decoration: BoxDecoration(
                            color: Colors.green
                                .shade100, // Set background color to black
                            // Add rounded corners
                          ),
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: Colors
                                  .green.shade700, // Set text color to white
                              fontSize: 20.0, // Set font size
                              fontWeight: FontWeight.bold, // Make text bold
                            ),
                          ),
                        ),
                        Ayahitem(
                            ayah: ayah[index].ayah,
                            numberOfayah: index + 1,
                            numberofsura: numberofsura),
                      ],
                    ); // Your existing list item widget
                  },
                ),
            error: (error, stack) => Text('Error: $error'),
            loading: () => const CircularProgressIndicator()),
      );
    }));
  }
}
