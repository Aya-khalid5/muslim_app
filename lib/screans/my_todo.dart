import 'package:flutter/material.dart';

import '../models/data_base.dart';

class notes_screen extends StatefulWidget {
  @override
  State<notes_screen> createState() => _notes_screen_state();
}

class _notes_screen_state extends State<notes_screen> {
  @override
  bool is_pressed = false;

  var data_controller = TextEditingController();

  var time_controller = TextEditingController();

  var title_controller = TextEditingController();

  List<Map<String, String>> tasks = [];

  void initState() {
    super.initState();
    create_database();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
                title: Text(tasks[index]['title']!),
                subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Time: ${tasks[index]['time']}"),
                      Text("Date: ${tasks[index]['date']}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: is_pressed
                                ? Icon(
                              Icons.check_circle,
                              color: Colors.red,
                            )
                                : Icon(Icons.check),
                            onPressed: () {
                              setState(() {
                                is_pressed = !is_pressed;
                              });
                            },
                          ),
                          IconButton(
                              icon:
                              Icon(Icons.delete, color: Color(0xFF048F6F)),
                              onPressed: () {
                                setState(() {
                                  tasks.removeAt(index);
                                });
                              })
                        ],
                      ),
                    ])),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Allow the sheet to take full height
            builder: (_) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: title_controller,
                        onTap: () {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          labelText: "Title",
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: time_controller,
                        onTap: () async {
                          TimeOfDay? picked_time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked_time != null) {
                            setState(() {
                              time_controller.text = picked_time.format(context);
                            });
                          }
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          labelText: "Time",
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: data_controller,
                        onTap: () async {
                          DateTime? picked_date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2090),
                          );
                          if (picked_date != null) {
                            setState(() {
                              data_controller.text =
                              "${picked_date.toLocal()}".split(' ')[0];
                            });
                          }
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          labelText: "Date",
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            tasks.add({
                              'title': title_controller.text,
                              'time': time_controller.text,
                              'date': data_controller.text,
                            });
                          });

                          Navigator.pop(context);

                          title_controller.clear();
                          time_controller.clear();
                          data_controller.clear();
                        },
                        child: Text("Save"),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add, color: Color(0xFF055A47), size: 40),
        backgroundColor: Colors.white60,
      ),
    );
  }
}