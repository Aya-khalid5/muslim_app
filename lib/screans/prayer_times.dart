import 'package:flutter/material.dart';
import '../servers/api_time.dart';

class prayer_times_screen extends StatefulWidget {
  @override
  _prayer_times_screen_state createState() => _prayer_times_screen_state();
}

class _prayer_times_screen_state extends State<prayer_times_screen> {
  Map<String, dynamic> prayer_times = {};

  @override
  void initState() {
    super.initState();
    fetch_prayer_times();
  }

  Future<void> fetch_prayer_times() async {
    try {
      final times = await api_service.fetch_prayer_times("Cairo", "Egypt");
      setState(() {
        prayer_times = times;
      });
    } catch (e) {
      print("Error fetching prayer times: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("فشل في جلب مواقيت الصلاة")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("مواقيت الصلاة"),
      ),
      body: prayer_times.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/8596945.jpg"),
              fit: BoxFit.cover,
            )),
        child: ListView(
          children: prayer_times.entries.map((entry) {
            return ListTile(
              title: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFFF3F6F6),
                        borderRadius: BorderRadius.circular(15)),
                    child: Text("${entry.key}: ${entry.value}")),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}