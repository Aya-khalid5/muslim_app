// login_screen.dart
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

  // دالة للتحقق من صحة البريد الإلكتروني
  bool _is_email_valid(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp reg_exp = RegExp(pattern);
    return reg_exp.hasMatch(email);
  }

  // دالة للتحقق من صحة كلمة المرور
  bool _is_password_valid(String password) {
    // مثال على التحقق من كلمة المرور: التأكد من أن طول كلمة المرور أكبر من 6 أحرف
    return password.length > 6;
  }

  void _login() async {
    if (email_controller.text.isEmpty || password_controller.text.isEmpty) {
      // التأكد من أن الحقول ليست فارغة
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("الرجاء إدخال البريد الإلكتروني وكلمة المرور")));
    } else if (!_is_email_valid(email_controller.text)) {
      // التأكد من صحة البريد الإلكتروني
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("البريد الإلكتروني غير صالح")));
    } else if (!_is_password_valid(password_controller.text)) {
      // التأكد من صحة كلمة المرور
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("كلمة المرور يجب أن تكون أكبر من 6 أحرف")));
    } else {
      // تخزين حالة تسجيل الدخول
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);

      // الانتقال إلى شاشة home_screen بعد تسجيل الدخول
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
                    // الانتقال إلى شاشة التسجيل
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