import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mosharkat_ayat_app/app/route.dart';
import 'package:mosharkat_ayat_app/features/editor/model/backgrounds.dart';

class CreationButton extends StatefulWidget {
  //limit the number of ayahs to the number of ayahs in the sura
  final int numberOfAyahs;
  final int numberofsura;
  const CreationButton(
      {super.key, required this.numberOfAyahs, required this.numberofsura});

  @override
  State<CreationButton> createState() => _CreationButtonState();
}

class _CreationButtonState extends State<CreationButton> {
  int _formValue = 1;
  int _toValue = 1;

  @override
  Widget build(BuildContext context) {
    print("number of ayahs: ${widget.numberofsura}");
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 4, 129, 77), shape: BoxShape.circle),
      width: 200.w,
      height: 200.h,
      child: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Center(child: Text("تم مشاركة الآية")),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text("الي الآية رقم"),
                                SizedBox(
                                  width: 50.w,
                                  height: 150.h,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        _toValue = int.parse(value);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("من الآية رقم"),
                                SizedBox(
                                  width: 50.w,
                                  height: 150.h,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        _formValue = int.parse(value);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(
                                context, RouteClass.editor,
                                arguments: {
                                  "numberOfSura": widget.numberofsura,
                                  "start": _formValue,
                                  "end": _toValue,
                                  "sheikhName": "ar.abdulbasitmurattal",
                                  "background": backgrounds[6],
                                  "isAnimated": true,
                                  "color": Colors.white
                                });
                          },
                          child: const Text("حسناً"))
                    ],
                  );
                });
          },
          icon: Icon(Icons.share, size: 75.sp, color: Colors.white)),
    );
  }
}
