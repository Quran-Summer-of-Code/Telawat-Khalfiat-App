import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mosharkat_ayat_app/app/route.dart';
import 'package:mosharkat_ayat_app/features/editor/model/backgrounds.dart';

class Ayahitem extends StatelessWidget {
  final String ayah;
  final int numberOfayah;
  final int numberofsura;
  const Ayahitem({
    super.key,
    required this.ayah,
    required this.numberOfayah,
    required this.numberofsura,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            // Use Expanded to ensure the Text widget takes the available space and wraps text as needed
            child: GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, RouteClass.editor,
                      arguments: {
                        "numberOfSura": numberofsura,
                        "start": numberOfayah,
                        "end": numberOfayah,
                        "sheikhName": "ar.abdulbasitmurattal",
                        "background": backgrounds[0],
                        "isAnimated": true,
                        "color": Colors.white
                      });
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    ayah,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily:
                          'Uthman', // Make sure to use an appropriate Quranic font
                      height:
                          2.0, // Increased line height for better readability
                      color: Colors.black87,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
