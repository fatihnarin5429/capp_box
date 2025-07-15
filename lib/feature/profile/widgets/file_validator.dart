import 'dart:io';
import 'package:flutter/material.dart';

class FileValidator {
  // Dosya boyutu sınırlaması (10MB)
  static const int maxFileSize = 10 * 1024 * 1024;

  // İzin verilen dosya tipleri
  static const List<String> allowedVideoTypes = ['mp4', 'webm', 'ogg'];
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'gif'];
  static const List<String> allowedAudioTypes = ['mp3', 'wav', 'ogg'];

  // Dosya sayısı sınırlamaları
  static const int maxVideoCount = 5;
  static const int maxImageCount = 10;
  static const int maxAudioCount = 3;

  // Dosya boyutunu kontrol eder
  static bool validateFileSize(File file, BuildContext context) {
    if (file.lengthSync() > maxFileSize) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Dosya boyutu çok büyük. Maksimum 10MB yükleyebilirsiniz.',
          ),
        ),
      );
      return false;
    }
    return true;
  }

  // Dosya tipini kontrol eder
  static bool validateFileType(File file, String type, BuildContext context) {
    final fileExtension = file.path.split('.').last.toLowerCase();

    if (type == 'video' && !allowedVideoTypes.contains(fileExtension)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Sadece MP4, WebM ve OGG video formatları desteklenmektedir.',
          ),
        ),
      );
      return false;
    } else if (type == 'image' && !allowedImageTypes.contains(fileExtension)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Sadece JPEG, PNG ve GIF resim formatları desteklenmektedir.',
          ),
        ),
      );
      return false;
    } else if (type == 'audio' && !allowedAudioTypes.contains(fileExtension)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Sadece MP3, WAV ve OGG ses formatları desteklenmektedir.',
          ),
        ),
      );
      return false;
    }
    return true;
  }

  // Dosya sayısını kontrol eder
  static bool validateFileCount(
    String type,
    int currentCount,
    BuildContext context,
  ) {
    if (type == 'video' && currentCount >= maxVideoCount) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('En fazla $maxVideoCount video yükleyebilirsiniz.'),
        ),
      );
      return false;
    } else if (type == 'image' && currentCount >= maxImageCount) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('En fazla $maxImageCount fotoğraf yükleyebilirsiniz.'),
        ),
      );
      return false;
    } else if (type == 'audio' && currentCount >= maxAudioCount) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'En fazla $maxAudioCount ses dosyası yükleyebilirsiniz.',
          ),
        ),
      );
      return false;
    }
    return true;
  }

  // Dosya tipini belirler
  static String? determineFileType(File file) {
    final fileExtension = file.path.split('.').last.toLowerCase();

    if (allowedVideoTypes.contains(fileExtension)) {
      return 'video';
    } else if (allowedImageTypes.contains(fileExtension)) {
      return 'image';
    } else if (allowedAudioTypes.contains(fileExtension)) {
      return 'audio';
    }

    return null;
  }

  // Add this method to the FileValidator class
  static String extractFileName(File file) {
    return file.path.split('/').last;
  }
}
