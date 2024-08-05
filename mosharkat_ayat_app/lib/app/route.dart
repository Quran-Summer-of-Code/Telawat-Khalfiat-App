import 'package:flutter/material.dart';
import 'package:mosharkat_ayat_app/features/editor/view/screens/Backgrounds_sheikhName_screen.dart';
import 'package:mosharkat_ayat_app/features/editor/view/screens/Editor_Screen.dart';
import 'package:mosharkat_ayat_app/features/surasList/view/surasListScreen.dart';
import 'package:mosharkat_ayat_app/features/surasList/view/sura_screen.dart';

class RouteClass {
  static const String home = '/';
  static const String sura = '/sura';
  static const String editor = '/editor';
  static const String backgoundAndSheikh = "/backgroundAndSheikh";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const SurasListScreen());

      case backgoundAndSheikh:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => ChoosingBackGroundAndSheikhScreen(
                  numberOfSura: data['numberOfSura'] ?? 0,
                  start: data['start'] ?? 0,
                  end: data['end'] ?? 0,
                ));

      case sura:
        int index = settings.arguments as int;

        return MaterialPageRoute(
            builder: (_) => SuraScreen(
                  numberofsura: index,
                ));
      default:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        // String background = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => Editor_Screen(
                  numberOfSura: data["numberOfSura"],
                  start: data["start"],
                  end: data["end"],
                  sheikh: data["sheikhName"],
                  background: data["background"],
                ));
    }
  }
}
