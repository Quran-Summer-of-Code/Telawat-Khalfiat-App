import 'package:flutter/material.dart';
import 'package:mosharkat_ayat_app/features/editor/view/screens/Editor_Screen.dart';
import 'package:mosharkat_ayat_app/features/recording/view/recordingScreen.dart';
import 'package:mosharkat_ayat_app/features/surasList/view/surasListScreen.dart';
import 'package:mosharkat_ayat_app/features/surasList/view/sura_screen.dart';

class RouteClass {
  static const String home = '/';
  static const String sura = '/sura';
  static const String editor = '/editor';
  static const String recording = '/recording';
  //static const String backgoundAndSheikh = "/backgroundAndSheikh";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const SurasListScreen());
      case editor:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        // String background = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => Editor_Screen(
                  numberOfSura: data["numberOfSura"],
                  start: data["start"],
                  end: data["end"],
                  sheikh: data["sheikhName"],
                  background: data["background"],
                  isAnimated: data["isAnimated"],
                  backgourndColor: data["color"],
                ));
      case recording:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        // String background = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => RecordingScreen(
                  gifUrl: data["gifUrl"],
                  audioUrls: data["audioUrls"],
                  ayah: data["ayah"],
                  isAnimated: data["isAnimated"],
                  brightness: data["brightness"],
                  down: data["down"],
                  up: data["up"],
                  fontSize: data["fontSize"],
                  currentColor: data["currentColor"],
                  backgourndColor: data["backgourndColor"],
                ));
      // case backgoundAndSheikh:
      //   Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //       builder: (_) => ChoosingBackGroundAndSheikhScreen(
      //             numberOfSura: data['numberOfSura'] ?? 0,
      //             start: data['start'] ?? 0,
      //             end: data['end'] ?? 0,
      //           ));

      case sura:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
            builder: (_) => SuraScreen(
                numberofsura: data["index"], suraName: data["suraName"]));
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
                  isAnimated: data["isAnimated"],
                  backgourndColor: data["color"],
                ));
    }
  }
}
