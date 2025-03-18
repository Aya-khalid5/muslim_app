import 'package:flutter/material.dart';
// lesson.dart
class lesson {
  final String id;
  final String title;
  final String description;
  final String content;
  final String category;
  final String subCategories;
  final List<String> tags;

  const lesson( {
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.category,
    required this.tags, required String subCategory,
    required this.subCategories,
  });
}

IconData _getIconData(String iconName) {
  switch (iconName) {
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
