import 'package:flutter/material.dart';

class tasbih_screen extends StatefulWidget {
  const tasbih_screen({super.key});

  @override
  State<tasbih_screen> createState() => _tasbih_screen_state();
}

class _tasbih_screen_state extends State<tasbih_screen> {
  int _count = 0;
  String _current_dhikr = 'سبحان الله';
  int _target = 33;

  final List<Map<String, dynamic>> _dhikr_list = [
    {'text': 'سبحان الله', 'target': 33},
    {'text': 'الحمد لله', 'target': 33},
    {'text': 'الله أكبر', 'target': 33},
    {'text': 'لا إله إلا الله', 'target': 100},
    {'text': 'اللهم صل وسلم على محمد', 'target': 100},
    {'text': 'أستغفر الله', 'target': 100},
    {'text': 'لا حول ولا قوة إلا بالله', 'target': 100},
    {
      'text':
      'لا إله إلا الله، وحده لا شريك له، له الملك، وله الحمد، وهو على كل شيء قدير',
      'target': 100
    },
    {'text': 'اللهم لك الحمد', 'target': 33},
    {'text': 'رَبِّ اغْفِرْ لِي', 'target': 33},
    {'text': 'اللهم إني أسألك من فضلك ورحمتك', 'target': 33},
    {'text': 'سبحان الله وبحمده، سبحان الله العظيم', 'target': 100},
    {'text': 'اللهم اجعلني من أهل الجنة', 'target': 33},
    {
      'text': 'حسبي الله لا إله إلا هو عليه توكلت وهو رب العرش العظيم',
      'target': 33
    },
    {'text': 'أعوذ بالله من الشيطان الرجيم', 'target': 33},
  ];

  void _increment_count() {
    setState(() {
      if (_count < _target) {
        _count++;
      }
    });
  }

  void _reset_count() {
    setState(() {
      _count = 0;
    });
  }

  void _change_dhikr(Map<String, dynamic> dhikr) {
    setState(() {
      _current_dhikr = dhikr['text'];
      _target = dhikr['target'];
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text(
          'التسبيح',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<Map<String, dynamic>>(
                        isExpanded: true,
                        value: _dhikr_list
                            .firstWhere((d) => d['text'] == _current_dhikr),
                        items: _dhikr_list.map((dhikr) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: dhikr,
                            child: Text(
                              dhikr['text'],
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFF1C2843),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            _change_dhikr(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: _increment_count,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/8596945.jpg"),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _count.toString(),
                          style: const TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF064032),
                          ),
                        ),
                        Text(
                          'من $_target',
                          style: TextStyle(
                            fontSize: 18,
                            color: const Color(0xFF70AEA0).withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _reset_count,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF015743),
                      foregroundColor: Color(0xFFA0C3BB),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text(
                      'إعادة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}