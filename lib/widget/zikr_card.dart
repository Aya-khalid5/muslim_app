
import 'package:flutter/material.dart';

class zikr_card extends StatelessWidget {
  final String zikr;
  final int repeat;
  final String benefit;

  const zikr_card({
    required this.zikr,
    required this.repeat,
    required this.benefit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          zikr,
          style: const TextStyle(
            fontSize: 20,
            height: 1.8,
            color: Color(0xFF1C2843),
          ),
          textDirection: TextDirection.rtl,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF34A853).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'التكرار: $repeat',
                  style: const TextStyle(
                    color: Color(0xFF34A853),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const SizedBox(height: 8),
                const Text(
                  'الفضل:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1C2843),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  benefit,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: const Color(0xFF1C2843).withOpacity(0.8),
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
