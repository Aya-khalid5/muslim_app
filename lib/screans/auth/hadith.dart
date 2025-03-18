import 'package:flutter/material.dart';
import '../../models/lesson.dart';
import '../category_lesson.dart';
import '../lessons.dart';

class category_lessons_screen extends StatelessWidget {
  final String category_id;
  final String category_name;

  const category_lessons_screen({
    super.key,
    required this.category_id,
    required this.category_name,
  });

  @override
  Widget build(BuildContext context) {
    final lessons = lesson_data.lessons
        .where((lesson) => lesson.category == category_id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category_name),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: lessons.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                lesson.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(lesson.description),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: lesson.tags.map((tag) {
                      return Chip(
                        label: Text(tag),
                        backgroundColor: const Color(0xFF014535),
                        labelStyle: const TextStyle(color: Color(0xFF96D6C7)),
                      );
                    }).toList(),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => lesson_detail_screen(lessona: lesson),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}