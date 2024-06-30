import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mosharkat_ayat_app/features/editor/view/screens/Editor_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2220),
      builder: (_, context) => const MaterialApp(
        title: 'Mosharkat Ayat App',
        home: Editor_Screen(),
      ),
    );
  }
}
