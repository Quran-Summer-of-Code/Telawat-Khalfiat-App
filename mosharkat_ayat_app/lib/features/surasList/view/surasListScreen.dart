import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosharkat_ayat_app/features/surasList/model/sura_model.dart';
import 'package:mosharkat_ayat_app/features/surasList/view/widgets/surasListItem.dart';
import 'package:mosharkat_ayat_app/features/surasList/view_model/suras_provider.dart';

class SurasListScreen extends ConsumerWidget {
  const SurasListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suraListAsyncValue = ref.watch(suraListProvider);

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
        body: suraListAsyncValue.when(
          data: (List<Sura> suras) => ListView.builder(
            itemCount: suras.length,
            itemBuilder: (context, index) {
              final sura = suras[index];

              return SurasListItem(
                  sura: sura, index: index); // Your existing list item widget
            },
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ),
    );
  }
}
