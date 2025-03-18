// lessons_screen.dart
import 'package:flutter/material.dart';

import '../models/lesson.dart';
import '../widget/search_bar.dart';
import 'category_lesson.dart';

class lessons_screen extends StatefulWidget {
  const lessons_screen({super.key});

  @override
  State<lessons_screen> createState() => _lessons_screen_state();
}

class _lessons_screen_state extends State<lessons_screen> {
  final TextEditingController _search_controller = TextEditingController();
  String _search_query = '';

  @override
  void dispose() {
    _search_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدروس الدينية'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: search_bar_widget(
              controller: _search_controller,
              onChanged: (query) {
                setState(() {
                  _search_query = query;
                });
              },
              hintText: 'ابحث في الدروس...', onchanged:  (query) {
              setState(() {
                _search_query = query;
              });
            }, hinttext:'ابحث في الدروس...',
            ),
          ),
          Expanded(
            child: _search_query.isEmpty
                ? _build_categories_grid()
                : _build_search_results(),
          ),
        ],
      ),
    );
  }

  Widget _build_categories_grid() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/time.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: lesson_data.categories.length,
        itemBuilder: (context, index) {
          final category = lesson_data.categories[index];
          return _build_category_card(context, category);
        },
      ),
    );
  }

  Widget _build_search_results() {
    final filtered_lessons = lesson_data.lessons.where((lesson) {
      final search_lower = _search_query.toLowerCase();
      return lesson.title.toLowerCase().contains(search_lower) ||
          lesson.description.toLowerCase().contains(search_lower) ||
          lesson.content.toLowerCase().contains(search_lower) ||
          lesson.tags.any((tag) => tag.toLowerCase().contains(search_lower));
    }).toList();

    if (filtered_lessons.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'لم يتم العثور على نتائج لـ "$_search_query"',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black, 
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filtered_lessons.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final lesson = filtered_lessons[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                lesson.title,
                style: const TextStyle(
                  color: Colors.black, 
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    lesson.description,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      _get_icon_data(lesson_data.categories.firstWhere(
                              (cat) => cat['id'] == lesson.category)['icon']!),
                      size: 16,
                      color: const Color(0xFF014535),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      lesson_data.categories.firstWhere(
                              (cat) => cat['id'] == lesson.category)['name']!,
                      style: const TextStyle(color: Colors.black), 
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: lesson.tags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      backgroundColor: const Color(0xFFCAF3E8),
                      labelStyle: const TextStyle(color: Colors.black), 
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
    );
  }

  Widget _build_category_card(
      BuildContext context, Map<String, String> category) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => sub_category_lessons_screen(
                sub_category_id: category['id']!,
                sub_category_name: category['name']!,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _get_icon_data(category['icon']!),
                size: 48,
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              Text(
                category['name']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, 
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                category['description']!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black, 
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _get_icon_data(String icon_name) {
    switch (icon_name) {
      case 'mosque':
        return Icons.mosque;
      case 'book':
        return Icons.book;
      case 'history':
        return Icons.history;
      case 'menu_book':
        return Icons.menu_book;
      case 'article':
        return Icons.article;
      default:
        return Icons.library_books;
    }
  }
}
