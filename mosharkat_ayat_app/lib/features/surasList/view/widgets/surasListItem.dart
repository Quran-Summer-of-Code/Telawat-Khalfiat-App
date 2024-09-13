import 'package:flutter/material.dart';
import 'package:mosharkat_ayat_app/app/route.dart';
import 'package:mosharkat_ayat_app/features/surasList/model/sura_model.dart';

class SurasListItem extends StatelessWidget {
  final Sura sura;
  final int index;

  const SurasListItem({super.key, required this.sura, required this.index});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, RouteClass.sura,
              arguments: {'index': index, 'suraName': sura.name}),
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey.shade400,
                  size: 18,
                ),
                const SizedBox(width: 16),
                // Sura Details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      sura.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "عدد الآيات ${sura.numAyas}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                // Sura Order
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      sura.order,
                      style: TextStyle(
                        fontFamily: 'Uthman',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
