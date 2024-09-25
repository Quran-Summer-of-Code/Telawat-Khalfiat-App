import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mosharkat_ayat_app/app/route.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermissions();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _requestPermissions() async {
  await [Permission.manageExternalStorage, Permission.videos, Permission.audio]
      .request();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2220),
      builder: (_, context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteClass.home,
        onGenerateRoute: RouteClass.generateRoute,
        title: 'Mosharkat Ayat App',
      ),
    );
  }
}
