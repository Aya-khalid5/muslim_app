import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class surah_details_screen extends StatelessWidget {
  final Map<String, dynamic> surah;

  const surah_details_screen({
    super.key,
    required this.surah,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surah['name']),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: surah['ayahs'].length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SelectableText(
                '${surah['ayahs'][index]} ﴿${index + 1}﴾',
                style: const TextStyle(
                  fontSize: 20,
                  height: 2,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          );
        },
      ),
    );
  }
}