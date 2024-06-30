import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Editor_Widget extends StatelessWidget {
  final String gifUrl;
  const Editor_Widget({super.key, required this.gifUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
          width: 0.9.sw,
          height: 0.8.sh,
          child: Stack(
            children: [
              Image.network(gifUrl),
              SizedBox(
                width: 0.9.sw,
                height: 0.8.sh,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("بِسْمِ ٱللّٰهِِ الرَّحْمٰنِ الرَّحِيْمِ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 0.9.sw,
                      height: 0.6.sh,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("اللهم صل وسلم على سيدنا محمد",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
