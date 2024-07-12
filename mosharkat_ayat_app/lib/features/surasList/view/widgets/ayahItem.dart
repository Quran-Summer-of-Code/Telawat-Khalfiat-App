import 'package:flutter/material.dart';

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
            child: Text(
              ayah,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 16, // Adjust font size as needed
                fontWeight: FontWeight.bold,
              ),
              softWrap: true, // Enable text wrapping
            ),
          ),
        ],
      ),
    );
  }
}
