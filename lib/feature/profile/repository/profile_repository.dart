import 'package:capp_box/feature/profile/services/profile_datasource.dart';
import 'package:capp_box/feature/profile/services/profile_hive_service.dart';
import 'package:capp_box/feature/login/services/model/user_model.dart';

class ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;
  final ProfileHiveService hiveService;

  ProfileRepository({
    ProfileRemoteDatasource? remoteDatasource,
    ProfileHiveService? hiveService,
  }) : remoteDatasource = remoteDatasource ?? ProfileRemoteDatasource(),
       hiveService = hiveService ?? ProfileHiveService();

  // Local işlemler
  Future<UserModel?> getUser() => hiveService.getUser();
  Future<void> saveUser(UserModel user) => hiveService.saveUser(user);
  Future<void> updateUser(UserModel user) => hiveService.updateUser(user);
  Future<void> deleteUser() => hiveService.deleteUser();

  // Remote işlemler
  Future<UserModel> fetchProfile(String userId) =>
      remoteDatasource.fetchProfile(userId);
  Future<UserModel> updateProfileRemote(UserModel user) =>
      remoteDatasource.updateProfile(user);
}
