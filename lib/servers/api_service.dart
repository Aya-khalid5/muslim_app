import 'package:dio/dio.dart';
import '../models/quran.dart';
class api_service {
  final Dio _dio = Dio();
  static const String _baseUrl = 'https://api.alquran.cloud/v1';
  static const String _audioBaseUrl = 'http://api.alquran.cloud/v1/quran/ar.alafasy';
  static const String prayerBaseUrl = 'https://api.aladhan.com/v1';

  Future<List<Map<String, dynamic>>> get_all_surahs() async {
    try {
      final response = await _dio.get('$_baseUrl/surah');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return List<Map<String, dynamic>>.from(data);
      }
      throw Exception('فشل في تحميل السور');
    } catch (e) {
      throw Exception('حدث خطأ: $e');
    }
  }

  Future<Map<String, dynamic>> get_surah_ayahs(int surahNumber) async {
    try {
      final response = await _dio.get(
          '$_baseUrl/surah/$surahNumber/ar.alafasy');
      if (response.statusCode == 200) {
        final Map<String, dynamic> surahData = Map<String, dynamic>.from(
            response.data);

        // تحديث روابط الصوت لكل آية
        if (surahData['data'] != null && surahData['data']['ayahs'] != null) {
          final List<dynamic> ayahs = surahData['data']['ayahs'];
          for (var ayah in ayahs) {
            final int number = ayah['number'];
            final String audioUrl = '$_audioBaseUrl/${number.toString()
                .padLeft(3, '0')}.mp3';
            ayah['audio'] = audioUrl;
          }
        }

        return surahData;
      }
      throw Exception('فشل في تحميل الآيات');
    } catch (e) {
      throw Exception('حدث خطأ: $e');
    }
  }

}

class QuranService {
  final Dio _dio = Dio();
  static const String _baseUrl = 'https://api.alquran.cloud/v1';

  Future<List<Map<String, dynamic>>> get_all_surahs() async {
    try {
      final response = await _dio.get('$_baseUrl/surah');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return List<Map<String, dynamic>>.from(data);
      }
      throw Exception('فشل في تحميل السور');
    } catch (e) {
      throw Exception('حدث خطأ: $e');
    }
  }

  Future<Map<String, dynamic>> get_surah_ayahs(int surahNumber) async {
    try {
      final response = await _dio.get('$_baseUrl/surah/$surahNumber/ar.alafasy');
      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(response.data);
      }
      throw Exception('فشل في تحميل الآيات');
    } catch (e) {
      throw Exception('حدث خطأ: $e');
    }
  }
}