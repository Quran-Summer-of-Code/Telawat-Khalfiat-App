import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final sharedPrefsProvider = Provider<SharedPreferencesService>((ref) {
//   return SharedPreferencesService();
// });

// class SharedPreferencesService {
//   static const _sheikhNameKey = 'sheikhName';
//   static const _gifUrlKey = 'gifUrl';
//   static const _isAnimatedKey = 'isAnimated';
//   static const _brightnessKey = 'brightness';
//   static const _backgroundColorKey = 'backgroundColor';

//   Future<void> saveState({
//     required String sheikhName,
//     required String gifUrl,
//     required bool isAnimated,
//     required double brightness,
//     required Color backgroundColor,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_sheikhNameKey, sheikhName);
//     await prefs.setString(_gifUrlKey, gifUrl);
//     await prefs.setBool(_isAnimatedKey, isAnimated);
//     await prefs.setDouble(_brightnessKey, brightness);
//     await prefs.setInt(_backgroundColorKey, backgroundColor.value);
//   }

//   Future<Map<String, dynamic>> loadState() async {
//     final prefs = await SharedPreferences.getInstance();
//     return {
//       'sheikhName': prefs.getString(_sheikhNameKey) ?? 'ar.abdulbasitmurattal',
//       'gifUrl': prefs.getString(_gifUrlKey) ?? 'water2.gif',
//       'isAnimated': prefs.getBool(_isAnimatedKey) ?? true,
//       'brightness': prefs.getDouble(_brightnessKey) ?? 0.8,
//       'backgroundColor': Color(prefs.getInt(_backgroundColorKey) ?? 0xFFE7E0B5),
//     };
//   }
// }

// Define a provider for the sheikhName
final sheikhNameProvider =
    StateProvider<String>((ref) => 'ar.abdulbasitmurattal');

// final sheikhNameProvider = FutureProvider<String>((ref) async {
//   final sharedPrefsService = ref.watch(sharedPrefsProvider);
//   final state = await sharedPrefsService.loadState();
//   return state['sheikhName'] as String;
// });

// Define a provider for the gifUrl
final gifUrlProvider = StateProvider<String>((ref) => 'water2.gif');
// final gifUrlProvider = FutureProvider<String>((ref) async {
//   final sharedPrefsService = ref.watch(sharedPrefsProvider);
//   final state = await sharedPrefsService.loadState();
//   return state['gifUrl'] as String;
// });
// Define a provider for the isAnimated
final isAnimatedProvider = StateProvider<bool>((ref) => true);

// final isAnimatedProvider = FutureProvider<bool>((ref) async {
//   final sharedPrefsService = ref.watch(sharedPrefsProvider);
//   final state = await sharedPrefsService.loadState();
//   return state['isAnimated'] as bool;
// });

// Define a provider for the brightness
final brightnessProvider = StateProvider<double>((ref) => 0.8);

// final brightnessProvider = FutureProvider<double>((ref) async {
//   final sharedPrefsService = ref.watch(sharedPrefsProvider);
//   final state = await sharedPrefsService.loadState();
//   return state['brightness'] as double;
// });

// Define a provider for the backgourndColor
final backgourndColorProvider =
    StateProvider<Color>((ref) => const Color.fromARGB(255, 231, 224, 181));

// final backgourndColorProvider = FutureProvider<Color>((ref) async {
//   final sharedPrefsService = ref.watch(sharedPrefsProvider);
//   final state = await sharedPrefsService.loadState();
//   return state['backgroundColor'] as Color;
// });
