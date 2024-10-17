// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mosharkat_ayat_app/app/route.dart';
// import 'package:mosharkat_ayat_app/features/editor/model/backgrounds.dart';
// import 'package:mosharkat_ayat_app/features/surasList/model/sheikh_model.dart';
// import 'package:mosharkat_ayat_app/features/surasList/model/sura_model.dart';
// import 'package:mosharkat_ayat_app/features/surasList/view_model/suras_provider.dart';

// class ChoosingBackGroundAndSheikhScreen extends StatefulWidget {
//   int numberOfSura;
//   int start;
//   int end;
//   ChoosingBackGroundAndSheikhScreen(
//       {super.key,
//       required this.numberOfSura,
//       required this.start,
//       required this.end});

//   @override
//   State<ChoosingBackGroundAndSheikhScreen> createState() =>
//       _ChoosingBackGroundAndSheikhScreenState();
// }

// class _ChoosingBackGroundAndSheikhScreenState
//     extends State<ChoosingBackGroundAndSheikhScreen> {
//   String _sheikhName = "ar.abdulbasitmurattal";
//   int _backgroundIndex = 0;
//   bool _isAnimated = true;
//   Color _currentColor = Colors.white;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: Consumer(builder: (context, ref, child) {
//       final suraName = ref.watch(suraListProvider);
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color.fromARGB(255, 8, 90, 50),
//           title: Center(
//               child: suraName.when(
//             data: (List<Sura> suras) => Text(
//               "مشاركة سورة ${suras[widget.numberOfSura].name} من الآية ${widget.start} الى الآية ${widget.end}",
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontFamily: "Uthman",
//               ),
//             ),
//             loading: () => const CircularProgressIndicator(),
//             error: (error, stack) => Text('Error: $error'),
//           )),
//         ),
//         body: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   "قم باختيار صوت الشيخ",
//                   style: TextStyle(fontFamily: "Uthman", fontSize: 75.sp),
//                 ),
//                 DropdownButton(
//                     items: dropdownItems,
//                     value: _sheikhName,
//                     onChanged: (value) {
//                       setState(() {
//                         _sheikhName = value.toString();
//                       });
//                     }),
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       TextButton(
//                           onPressed: () {
//                             setState(() {
//                               _isAnimated = true;
//                             });
//                           },
//                           child: Text(
//                             "خلفية متحركة",
//                             style: TextStyle(
//                                 color: _isAnimated
//                                     ? const Color.fromARGB(255, 8, 90, 50)
//                                     : Colors.black,
//                                 fontFamily: "Uthman",
//                                 fontSize: 75.sp),
//                           )),
//                       TextButton(
//                           onPressed: () {
//                             setState(() {
//                               _isAnimated = false;
//                             });
//                           },
//                           child: Text(
//                             "خلفية  ثابتة",
//                             style: TextStyle(
//                                 color: !_isAnimated
//                                     ? const Color.fromARGB(255, 8, 90, 50)
//                                     : Colors.black,
//                                 fontFamily: "Uthman",
//                                 fontSize: 75.sp),
//                           )),
//                     ]),
//                 Text(
//                   "اختار خلفية",
//                   style: TextStyle(fontFamily: "Uthman", fontSize: 75.sp),
//                 ),
//                 _isAnimated
//                     ? Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   _backgroundIndex--;
//                                   if (_backgroundIndex < 0) {
//                                     _backgroundIndex = backgrounds.length - 1;
//                                   }
//                                 });
//                               },
//                               icon: const Icon(Icons.arrow_back)),
//                           SizedBox(
//                             width: 0.6.sw,
//                             height: 0.5.sh,
//                             child: Image.asset(
//                                 "assets/backgrounds/${backgrounds[_backgroundIndex]}",
//                                 fit: BoxFit.cover),
//                           ),
//                           IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   _backgroundIndex++;
//                                   if (_backgroundIndex >= backgrounds.length) {
//                                     _backgroundIndex = 0;
//                                   }
//                                 });
//                               },
//                               icon: const Icon(Icons.arrow_forward)),
//                         ],
//                       )
//                     : ColorPicker(
//                         pickerColor: _currentColor,
//                         onColorChanged: (Color color) {
//                           setState(() {
//                             _currentColor = color;
//                           });
//                         },
//                         pickerAreaHeightPercent: 0.8,
//                       ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromARGB(255, 8, 90, 50)),
//                     onPressed: () {
//                       Navigator.popAndPushNamed(context, RouteClass.editor,
//                           arguments: {
//                             "numberOfSura": widget.numberOfSura,
//                             "start": widget.start,
//                             "end": widget.end,
//                             "sheikhName": _sheikhName,
//                             "background": backgrounds[_backgroundIndex],
//                             "isAnimated": _isAnimated,
//                             "color": _currentColor
//                           });
//                     },
//                     child: Text(
//                       "تم",
//                       style: TextStyle(
//                           fontFamily: "Uthman",
//                           fontSize: 50.sp,
//                           color: Colors.white),
//                     ))
//               ],
//             ),
//           ),
//         ),
//       );
//     }));
//   }
// }
