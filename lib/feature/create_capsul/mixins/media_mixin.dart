import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';

mixin MediaMixin<T extends StatefulWidget> on State<T> {
  Future<void> checkPermissions(MediaType? type) async {
    if (Platform.isAndroid) {
      if (await Permission.storage.isDenied) {
        await Permission.storage.request();
      }

      if (type == MediaType.voice) {
        if (await Permission.audio.isDenied) {
          await Permission.audio.request();
        }
      } else if (type == MediaType.photo || type == MediaType.video) {
        if (await Permission.camera.isDenied) {
          await Permission.camera.request();
        }
      }
    }
  }

  Future<void> pickAudioFile(
      BuildContext context, Function(File, String) onFilePicked) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowCompression: false,
        withData: true,
        dialogTitle: 'Ses Dosyası Seç',
        allowedExtensions: [
          'mp3',
          'mp4',
          'mpeg',
          'mpga',
          'webm',
          'wav',
          'm4a',
          'aac',
        ],
      );

      if (!mounted) return;

      if (result != null &&
          result.files.isNotEmpty &&
          result.files.single.path != null) {
        onFilePicked(File(result.files.single.path!), result.files.single.name);
        BotToast.showText(
            text: 'Ses dosyası başarıyla seçildi', contentColor: Colors.green);
      }
    } catch (e) {
      if (!mounted) return;

      print('Ses dosyası seçme hatası: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Ses dosyası seçilirken bir hata oluştu: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  Future<void> pickImage(Function(File) onImagePicked) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        onImagePicked(File(image.path));
      }
    } catch (e) {
      print('Resim seçme hatası: $e');
    }
  }

  Future<void> pickVideo(Function(File) onVideoPicked) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? video = await picker.pickVideo(source: ImageSource.gallery);

      if (video != null) {
        onVideoPicked(File(video.path));
      }
    } catch (e) {
      print('Video seçme hatası: $e');
    }
  }
}
