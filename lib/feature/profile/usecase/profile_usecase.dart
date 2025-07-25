import 'package:capp_box/feature/profile/services/profile_datasource.dart';
import 'package:capp_box/feature/login/services/model/user_model.dart';

class ProfileUsecase {
  final ProfileRemoteDatasource datasource;
  ProfileUsecase(this.datasource);

  Future<UserModel> fetchProfile(String userId) =>
      datasource.fetchProfile(userId);
  Future<UserModel> updateProfile(UserModel user) =>
      datasource.updateProfile(user);
}
