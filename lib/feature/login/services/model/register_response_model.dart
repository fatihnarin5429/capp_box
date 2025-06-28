class RegisterResponseModel {
  final bool success;
  final String token;

  RegisterResponseModel({required this.success, required this.token});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: json['success'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'token': token};
  }
}
