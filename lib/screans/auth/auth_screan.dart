import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/custom_input.dart';

class sign_up_screen extends StatefulWidget {
  @override
  _sign_up_screen_state createState() => _sign_up_screen_state();
}

class _sign_up_screen_state extends State<sign_up_screen> {
  final TextEditingController email_controller = TextEditingController();
  final TextEditingController password_controller = TextEditingController();

  void _sign_up() async {
    if (email_controller.text.isNotEmpty && password_controller.text.isNotEmpty) {
     
      user new_user = user(
        email: email_controller.text,
        password: password_controller.text,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', new_user.email);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("تم إنشاء الحساب بنجاح")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("الرجاء إدخال جميع البيانات")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/masged.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(25),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/masgeg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("إنشاء حساب جديد",
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
                ElevatedButton(onPressed: _sign_up, child: Text("إنشاء الحساب")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
