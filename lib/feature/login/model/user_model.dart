class User {
  final String id;
  final String email;
  final String name;
  final String? profileImage;
  final DateTime createdAt;
  final String phoneNumber;
  final String password;
  final bool isEmailVerified;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.password,
    this.profileImage,
    required this.createdAt,
    this.isEmailVerified = false,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? profileImage,
    String? phoneNumber,
    String? password,
    DateTime? createdAt,
    bool? isEmailVerified,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'password': password,
      'profileImage': profileImage,
      'createdAt': createdAt.toIso8601String(),
      'isEmailVerified': isEmailVerified,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      profileImage: json['profileImage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
    );
  }
}
