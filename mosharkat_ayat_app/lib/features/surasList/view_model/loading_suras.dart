import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mosharkat_ayat_app/features/surasList/model/sura_model.dart';

import '../model/ayah_model.dart';

Future<List<Sura>> loadSuras() async {
  final String response =
      await rootBundle.loadString('assets/jsonFiles/SurasList.json');
  final data = json.decode(response) as List;
  return data.map((sura) => Sura.fromJson(sura)).toList();
}

Future<List<List<Ayah>>> fetchAyahs() async {
  final String response =
      await rootBundle.loadString('assets/jsonFiles/Suras.json');

  final data = json.decode(response) as List;

  List<List<Ayah>> suras = data.map((sura) {
    return (sura as List).map((ayahJson) {
      return Ayah.fromJson(ayahJson);
    }).toList();
  }).toList();

  return suras;
}
