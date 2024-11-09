import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mosharkat_ayat_app/app/route.dart';

import 'package:mosharkat_ayat_app/features/surasList/view_model/convert_number_to_arabic.dart';

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
    return Row(
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
                      "color": const Color.fromARGB(255, 231, 224, 181)
                    });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 50,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  "$ayah  \ufd3f${convertToArabicNumbers(numberOfayah.toString())}\ufd3e",
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 65.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily:
                        'Uthman', // Make sure to use an appropriate Quranic font
                    height: 2.0, // Increased line height for better readability
                    color: Colors.black87,
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
