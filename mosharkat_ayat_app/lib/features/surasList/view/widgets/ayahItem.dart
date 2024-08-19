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
              child: Text(
                ayah,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 50.sp, // Adjust font size as needed
                  fontWeight: FontWeight.bold,
                ),
                softWrap: true, // Enable text wrapping
              ),
            ),
          ),
        ],
      ),
    );
  }
}
