// lesson_card.dart
import 'package:flutter/material.dart';
import '../models/data_hadith.dart';

class lesson_card extends StatelessWidget {
  final lesson lessonn;
  final VoidCallback onTap;

  const lesson_card({
    required this.lessonn,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white.withOpacity(0.8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            lessonn.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                lessonn.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: lessonn.tags.map((tag) {
                return Chip(
                  label: Text(tag),
                  backgroundColor: const Color(0xFF014535),
                  labelStyle: const TextStyle(color: Color(0xFF96D6C7)),
                );
              }).toList(),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}