import 'package:capp_box/feature/home/model/capsule_model.dart';

class CapsuleService {
  // Firebase kullanımı veya mock data için örnek
  // Gerçek uygulamada, burada Firebase Firestore veya başka bir veri kaynağı kullanılabilir

  Future<List<Capsule>> getUpcomingCapsules() async {
    // Örnek veri - gerçek uygulamada API veya Firebase'den gelecek
    await Future.delayed(
        const Duration(seconds: 1)); // API çağrısını simüle etmek için

    // Şu anki tarihten itibaren yaklaşan kapsüller
    final now = DateTime.now();
    final upcomingCapsules = _mockCapsules
        .where((capsule) =>
                capsule.openingDate.isAfter(now) &&
                capsule.openingDate.difference(now).inDays <=
                    30 // Örneğin 30 gün içinde açılacaklar
            )
        .toList();

    // Açılma tarihine göre sıralama
    upcomingCapsules.sort((a, b) => a.openingDate.compareTo(b.openingDate));

    return upcomingCapsules;
  }

  Future<void> addCapsule(Map<String, dynamic> capsuleData) async {
    // Firebase veya API'ye kapsül eklemek için
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock için yeni bir kapsül oluştur
    final newCapsule = Capsule.fromJson(capsuleData);
    _mockCapsules.add(newCapsule);
  }

  Future<void> updateCapsule(
      String id, Map<String, dynamic> capsuleData) async {
    // Firebase veya API üzerinde kapsül güncellemek için
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock için kapsül güncelleme
    final index = _mockCapsules.indexWhere((capsule) => capsule.id == id);
    if (index != -1) {
      final updatedCapsule = Capsule.fromJson(capsuleData);
      _mockCapsules[index] = updatedCapsule;
    }
  }

  Future<void> deleteCapsule(String id) async {
    // Firebase veya API üzerinde kapsül silmek için
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock için kapsül silme
    _mockCapsules.removeWhere((capsule) => capsule.id == id);
  }

  // Örnek veriler - gerçek uygulamada kaldırılacak
  final List<Capsule> _mockCapsules = [
    Capsule(
      id: '1',
      title: 'Doğum Günü Anıları',
      content: 'Bu yılki doğum günü partimden hatıralar',
      creationDate: DateTime.now().subtract(const Duration(days: 60)),
      openingDate: DateTime.now().add(const Duration(days: 5)),
      mediaType: 'yazı',
    ),
    Capsule(
      id: '2',
      title: 'Mezuniyet Videosu',
      content: 'Üniversite mezuniyet töreninin videosu',
      creationDate: DateTime.now().subtract(const Duration(days: 90)),
      openingDate: DateTime.now().add(const Duration(days: 12)),
      mediaType: 'video',
      mediaUrl: 'https://example.com/video1.mp4',
    ),
    Capsule(
      id: '3',
      title: 'Sevgiliye Mesaj',
      content: 'Sevgiliye özel ses kaydı',
      creationDate: DateTime.now().subtract(const Duration(days: 30)),
      openingDate: DateTime.now().add(const Duration(days: 25)),
      mediaType: 'ses',
      mediaUrl: 'https://example.com/audio1.mp3',
    ),
    Capsule(
      id: '4',
      title: 'Tatil Fotoğrafları',
      content: 'Yaz tatilinden anılar',
      creationDate: DateTime.now().subtract(const Duration(days: 120)),
      openingDate: DateTime.now().add(const Duration(days: 1)),
      mediaType: 'fotoğraf',
      mediaUrl: 'https://example.com/photo1.jpg',
    ),
  ];
}
