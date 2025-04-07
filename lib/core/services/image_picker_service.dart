import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  // Galeriden resim seçme
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      throw Exception('Galeriden resim seçme işlemi başarısız: $e');
    }
  }

  // Kameradan resim çekme
  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      throw Exception('Kameradan resim çekme işlemi başarısız: $e');
    }
  }
}
