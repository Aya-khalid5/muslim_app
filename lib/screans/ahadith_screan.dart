import 'package:flutter/material.dart';

class ahadith_screan extends StatelessWidget {
  const ahadith_screan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/masged2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          body: ListView.builder(
            itemBuilder: (contex, index) {},
            itemCount: 5,
          ),
        ));
  }
}
