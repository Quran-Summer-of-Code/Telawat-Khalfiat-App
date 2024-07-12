import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosharkat_ayat_app/features/surasList/model/ayah_model.dart';
import 'package:mosharkat_ayat_app/features/surasList/view/widgets/ayahItem.dart';
import 'package:mosharkat_ayat_app/features/surasList/view_model/suras_provider.dart';

class SuraScreen extends ConsumerWidget {
  final int numberofsura;
  const SuraScreen({super.key, required this.numberofsura});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ayatAyncValue = ref.watch(ayatProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 8, 90, 50),
          title: const Center(
            child: Text(
              'سور القرآن الكريم',
              style: TextStyle(
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
                    return Ayahitem(
                        ayah: ayah[index].ayah,
                        numberOfayah: index,
                        numberofsura:
                            numberofsura); // Your existing list item widget
                  },
                ),
            error: (error, stack) => Text('Error: $error'),
            loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
