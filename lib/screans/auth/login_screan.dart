import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/custom_input.dart';
import 'auth_screan.dart';

import '../../main.dart'; // Import the home screen

class login extends StatefulWidget {
  @override
  _login_screen_state createState() => _login_screen_state();
}

class _login_screen_state extends State<login> {
  final TextEditingController email_controller = TextEditingController();
  final TextEditingController password_controller = TextEditingController();

  bool _is_email_valid(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp reg_exp = RegExp(pattern);
    return reg_exp.hasMatch(email);
  }

  bool _is_password_valid(String password) {
    return password.length > 6;
  }

  void _login() async {
    if (email_controller.text.isEmpty || password_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("الرجاء إدخال البريد الإلكتروني وكلمة المرور")));
    } else if (!_is_email_valid(email_controller.text)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("البريد الإلكتروني غير صالح")));
    } else if (!_is_password_valid(password_controller.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("كلمة المرور يجب أن تكون أكبر من 6 أحرف")));
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => home_screen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/tasge.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/masged.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("تسجيل الدخول",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                custom_input_field(
                  controller: email_controller,
                  labelText: "البريد الإلكتروني",
                ),
                SizedBox(height: 10),
                custom_input_field(
                  controller: password_controller,
                  labelText: "كلمة المرور",
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(onPressed: _login, child: Text("تسجيل الدخول")),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => sign_up_screen()),
                    );
                  },
                  child: Text("إنشاء حساب جديد"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
