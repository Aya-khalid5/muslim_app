import 'package:flutter/material.dart';
import 'package:muslim_app/screans/auth/login_screan.dart';
import 'package:muslim_app/screans/lessons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muslim_app/screans/adhkar.dart';
import 'package:muslim_app/screans/my_todo.dart';
import 'package:muslim_app/screans/prayer_times.dart';
import 'package:muslim_app/screans/quran_screan.dart';
import 'package:muslim_app/screans/tasbih_screan.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // التحقق من حالة تسجيل الدخول
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn, is_logged_in: true,));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn, required bool is_logged_in});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق إسلامي',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Amiri',
        scaffoldBackgroundColor: const Color(0xFFF5F6F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1C2843),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C2843),
            fontFamily: 'Amiri',
          ),
        ),
      ),
      home: isLoggedIn ? const home_screen() :  login(),
    );
  }
}

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<home_screen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MainHomeScreen(),
    const quran_screen(),
    const azkar_screen(),
     notes_screen(),
    prayer_times_screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFF34A853),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'القرآن',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: 'الأذكار',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'مذكراتى',
            ),
          ],
        ),
      ),
    );
  }
}

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ'),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFeatureCard(
                context,
                'القرآن الكريم',
                'قراءة وتلاوة القرآن الكريم',
                Icons.menu_book_rounded,
                const Color(0xFF34A853),
                    () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const quran_screen()),
                ),
              ),
              _buildFeatureCard(
                context,
                'الأذكار',
                'أذكار الصباح والمساء',
                Icons.favorite_rounded,
                const Color(0xFF4285F4),
                    () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const azkar_screen()),
                ),
              ),
              _buildFeatureCard(
                context,
                'مواقيت الصلاة',
                'مواقيت الصلاة حسب موقعك',
                Icons.access_time_rounded,
                const Color(0xFFEA4335),
                    () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) =>  prayer_times_screen()),
                ),
              ),
              _buildFeatureCard(
                context,
                'السبحة',
                'تسبيح وذكر الله',
                Icons.contact_emergency,
                const Color(0xFF9C27B0),
                    () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const tasbih_screen()),
                ),
              ),
              _buildFeatureCard(
                context,
                'دروس دينيه',
                'تعلم فى الدين',
                Icons.bookmark,
                const Color(0xFF9C27B0),
                    () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const lessons_screen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context,
      String title,
      String subtitle,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 30,
                    color: color,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C2843),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF1C2843).withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: color,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}