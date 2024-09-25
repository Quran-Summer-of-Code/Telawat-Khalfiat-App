import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mosharkat_ayat_app/app/route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
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
