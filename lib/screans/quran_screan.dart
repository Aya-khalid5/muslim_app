import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart'; // استيراد مكتبة just_audio
import '../servers/api_service.dart';
import '../widget/search_bar.dart';

class quran_screen extends StatefulWidget {
  const quran_screen({super.key});

  @override
  State<quran_screen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<quran_screen> {
  final api_service _quranService = api_service();
  final AudioPlayer _audioPlayer = AudioPlayer(); // استخدام AudioPlayer من just_audio
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _surahs = [];
  List<dynamic> _filteredSurahs = [];
  Map<String, dynamic>? _selectedSurah;
  bool _isLoading = true;
  String _searchQuery = '';
  int? _selectedAyahIndex;

  @override
  void initState() {
    super.initState();
    _loadSurahs();
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // التخلص من مشغل الصوت عند التخلص من الشاشة
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadSurahs() async {
    try {
      final surahs = await _quranService.get_all_surahs();
      setState(() {
        _surahs = surahs;
        _filteredSurahs = surahs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: $e')),
        );
      }
    }
  }

  void _filterSurahs(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredSurahs = _surahs;
      } else {
        _filteredSurahs = _surahs.where((surah) {
          final name = surah['name'].toString().toLowerCase();
          final englishName = surah['englishName'].toString().toLowerCase();
          return name.contains(query.toLowerCase()) ||
              englishName.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  Future<void> _loadSurahDetails(int surahNumber) async {
    setState(() => _isLoading = true);
    try {
      final response = await _quranService.get_surah_ayahs(surahNumber);
      setState(() {
        _selectedSurah = response;
        _isLoading = false;
        _selectedAyahIndex = null;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: $e')),
        );
      }
    }
  }

  Future<void> _playAudio(String url, int index) async {
    setState(() {
      _selectedAyahIndex = index;
    });
    try {
      await _audioPlayer.stop(); // إيقاف الصوت الحالي
      await _audioPlayer.setUrl(url); // تعيين مصدر الصوت
      await _audioPlayer.play(); // تشغيل الصوت
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://i.imgur.com/8eEUqUP.jpg'),
          fit: BoxFit.cover,
          opacity: 0.05,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            _selectedSurah?['data']['name'] ?? 'القرآن الكريم',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          leading: _selectedSurah != null
              ? IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              _audioPlayer.stop();
              setState(() {
                _selectedSurah = null;
                _selectedAyahIndex = null;
              });
            },
          )
              : null,
        ),
        body: _isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF34A853),
          ),
        )
            : _selectedSurah == null
            ? Container(decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/8596945.jpg"),
            fit: BoxFit.cover,
          ),
        ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: search_bar_widget(
                  controller: _searchController,
                  onChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                  hintText: 'ابحث في السور...', onchanged: (String ) {  }, hinttext: '',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filteredSurahs.length,
                  itemBuilder: (context, index) {
                    final surah = _filteredSurahs[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Material(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15),
                        elevation: 2,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () => _loadSurahDetails(surah['number']),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF34A853).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${surah['number']}',
                                      style: const TextStyle(
                                        color: Color(0xFF34A853),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        surah['name'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1C2843),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${surah['revelationType']} - ${surah['numberOfAyahs']} آية',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: const Color(0xFF1C2843).withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF34A853).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow_rounded,
                                    color: Color(0xFF34A853),
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
            : Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF34A853).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'عدد الآيات: ${_selectedSurah!['data']['numberOfAyahs']}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF34A853),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SelectableText.rich(
                  TextSpan(
                    children: _selectedSurah!['data']['ayahs']
                        .asMap()
                        .entries
                        .map<InlineSpan>((entry) {
                      final index = entry.key;
                      final ayah = entry.value;
                      return TextSpan(
                        text: ' ${ayah['text']} ﴿${ayah['numberInSurah']}﴾ ',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _playAudio(ayah['audio'], index),
                        style: TextStyle(
                          fontSize: 24,
                          height: 2,
                          color: _selectedAyahIndex == index
                              ? const Color(0xFF34A853)
                              : const Color(0xFF1C2843),
                        ),
                      );
                    }).toList(),
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

