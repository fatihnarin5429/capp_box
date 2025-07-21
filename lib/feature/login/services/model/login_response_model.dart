import 'package:capp_box/feature/login/services/model/user_model.dart';

class LoginResponseModel {
  final bool success;
  final String token;

  LoginResponseModel({required this.success, required this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] ?? false,
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'token': token};
  }
}
