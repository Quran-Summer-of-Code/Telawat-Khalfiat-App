import 'package:flutter/material.dart';
import 'package:mosharkat_ayat_app/app/route.dart';

import 'package:mosharkat_ayat_app/features/surasList/model/sura_model.dart';

class Suraslistitem extends StatelessWidget {
  final Sura sura;
  final int index;
  const Suraslistitem({super.key, required this.sura, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteClass.sura, arguments: index);
      },
      child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                sura.name,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
    );
  }
}
