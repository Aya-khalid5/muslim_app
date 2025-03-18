import 'package:flutter/material.dart';
import 'package:muslim_app/screans/prayer_times.dart';

import '../main.dart';

import 'my_todo.dart';

class main_screen extends StatefulWidget {
  @override
  _main_screen_state createState() => _main_screen_state();
}

class _main_screen_state extends State<main_screen> {
  int _selected_index = 0;

  final List<Widget> _screens = [
    home_screen(),
    prayer_times_screen(),
    notes_screen()
  ];

  void _on_item_tapped(int index) {
    setState(() {
      _selected_index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/masgeg.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        body: _screens[_selected_index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selected_index,
          onTap: _on_item_tapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.brown,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
            BottomNavigationBarItem(
                icon: Icon(Icons.access_time), label: "أوقات الصلاة"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "الحساب"),
            BottomNavigationBarItem(icon: Icon(Icons.note), label: "مذكرات"),
          ],
        ),
      ),
    );
  }
}