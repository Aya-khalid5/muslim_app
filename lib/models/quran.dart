class surah {
  final int number;
  final String name;
  final String englishName;
  final String revelationType;
  final int numberOfAyahs;
  final String imageUrl; // إضافة حقل جديد لتخزين رابط الصورة

  surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.revelationType,
    required this.numberOfAyahs,
    required this.imageUrl, // إضافة الحقل الجديد
  });

  factory surah.fromJson(Map<String, dynamic> json) {
    return surah(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      revelationType: json['revelationType'],
      numberOfAyahs: json['numberOfAyahs'],
      imageUrl: json['imageUrl'], // تعيين رابط الصورة من الـ JSON
    );
  }
}