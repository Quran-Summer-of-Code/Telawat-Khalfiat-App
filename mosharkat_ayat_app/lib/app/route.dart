import 'package:flutter/material.dart';
import 'package:mosharkat_ayat_app/features/editor/view/screens/Editor_Screen.dart';
import 'package:mosharkat_ayat_app/features/surasList/view/surasListScreen.dart';
import 'package:mosharkat_ayat_app/features/surasList/view/sura_screen.dart';

class RouteClass {
  static const String home = '/';
  static const String sura = '/sura';
  static const String editor = '/editor';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        //return MaterialPageRoute(builder: (_) => const SurasListScreen());
        return MaterialPageRoute(builder: (_) => Editor_Screen());
      case sura:
        int index = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => SuraScreen(
                  numberofsura: index,
                ));
      default:
        return MaterialPageRoute(builder: (_) => Editor_Screen());
    }
  }
}
