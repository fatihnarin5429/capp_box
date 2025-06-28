import 'dart:async';
import 'package:capp_box/feature/login/services/model/user_model.dart';
import 'package:capp_box/product/database/hive/constants/hive_database_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

@immutable
final class HiveDatabaseManager {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<UserModel>(UserModelAdapter());
    await Hive.openBox<UserModel>(HiveDatabaseConstants.userModelBox);
  }

  static final userModelBoxHive = Hive.box<UserModel>(
    HiveDatabaseConstants.userModelBox,
  );

  Future<void> clearUserModel() async {
    await userModelBoxHive.clear();
  }

  Future<void> closeUserModel() async {
    await userModelBoxHive.close();
  }

  Future<void> setFirst() async {
    // Mevcut user modelini al
    final existingUser = getUserModel();
    if (existingUser != null) {
      // Mevcut user bilgilerini koruyarak sadece isFirst'ü güncelle
      final updatedUser = existingUser.copyWith(isFirst: true);
      await userModelBoxHive.put(HiveDatabaseConstants.userModel, updatedUser);
      print('Updated existing user with isFirst: true');
    } else {
      // Eğer user yoksa sadece isFirst ile yeni bir model oluştur
      await userModelBoxHive.put(
        HiveDatabaseConstants.userModel,
        UserModel(isFirst: true),
      );
      print('Created new user with isFirst: true');
    }
  }

  Future<void> saveUserModel(UserModel userModel) async {
    await userModelBoxHive.put(HiveDatabaseConstants.userModel, userModel);
  }

  UserModel? getUserModel() {
    try {
      print('Getting user model from Hive...');
      final user = userModelBoxHive.get(HiveDatabaseConstants.userModel);
      print('User retrieved: ${user != null}');
      if (user != null) {
        print('User details: name=${user.name}, token=${user.token}');
      }
      return user;
    } catch (e) {
      print('Error getting user model: $e');
      return null;
    }
  }

  Future<void> deleteUserModel() async {
    await userModelBoxHive.delete(HiveDatabaseConstants.userModel);
  }

  Future<bool> loadPushNotificationsSetting() async {
    var box = await Hive.openBox(HiveDatabaseConstants.settings);
    return box.get(HiveDatabaseConstants.settings, defaultValue: true);
  }

  /// Bildirim ayarlarını kaydeder
  Future<void> savePushNotificationsSetting(bool value) async {
    var box = await Hive.openBox(HiveDatabaseConstants.settings);
    await box.put(HiveDatabaseConstants.settings, value);
  }

  /// Varsayılan bildirim ayarlarını ayarlar
  Future<void> setDefaultPushNotificationsSetting() async {
    await savePushNotificationsSetting(true);
  }
}
