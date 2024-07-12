import 'package:mosharkat_ayat_app/features/surasList/model/ayah_model.dart';
import 'package:mosharkat_ayat_app/features/surasList/model/sura_model.dart';
import 'package:mosharkat_ayat_app/features/surasList/view_model/loading_suras.dart';
import 'package:riverpod/riverpod.dart';

final suraListProvider = FutureProvider<List<Sura>>((ref) async {
  return await loadSuras();
});

final ayatProvider = FutureProvider<List<List<Ayah>>>((ref) async {
  return await fetchAyahs();
});
