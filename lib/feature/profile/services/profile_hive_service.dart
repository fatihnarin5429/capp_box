import 'package:hive_flutter/hive_flutter.dart';
import 'package:capp_box/feature/login/services/model/user_model.dart';

class ProfileHiveService {
  static const String _userBoxName = 'userBox';

  Future<void> saveUser(UserModel user) async {
    final box = await Hive.openBox<UserModel>(_userBoxName);
    await box.put(UserModel.usermodelKey, user);
  }

  Future<UserModel?> getUser() async {
    final box = await Hive.openBox<UserModel>(_userBoxName);
    return box.get(UserModel.usermodelKey);
  }

  Future<void> deleteUser() async {
    final box = await Hive.openBox<UserModel>(_userBoxName);
    await box.delete(UserModel.usermodelKey);
  }

  Future<void> updateUser(UserModel user) async {
    await saveUser(user);
  }
}
