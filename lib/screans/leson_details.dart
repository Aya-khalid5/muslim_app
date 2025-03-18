// lesson_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/data_hadith.dart';

class lesson_detail_screen extends StatelessWidget {
  final lesson lessonn;

  const lesson_detail_screen({super.key, required this.lessonn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lessonn.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // جعل Column يأخذ أقل مساحة ممكنة
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                lessonn.description,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                lessonn.content,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class lessons_detail_screen extends StatelessWidget {
  final lesson lessona;

  const lessons_detail_screen({super.key, required this.lessona});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lessona.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                lessona.description,
                style: const TextStyle(fontSize: 16, color: Colors.black), // لون الخط أسود
              ),
            ),
            const SizedBox(height: 16),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                lessona.content,
                style: const TextStyle(fontSize: 14, color: Colors.black), // لون الخط أسود
              ),
            ),
          ],
        ),
      ),
    );
  }
}