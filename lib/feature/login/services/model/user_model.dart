import 'package:equatable/equatable.dart';
import 'package:capp_box/product/database/hive/core/hive_types.dart';
import 'package:capp_box/product/database/hive/core/model/hive_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypes.userModelId)
@immutable
final class UserModel with EquatableMixin, HiveModelMixin {
  const UserModel({
    this.url,
    this.name,
    this.photo,
    this.userId,
    this.email,
    this.token,
    this.isFirst,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  static const String usermodelKey = 'usermodel';

  @override
  // Model unique key
  String get key => usermodelKey;

  @HiveField(0)
  final String? url;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? photo;
  @HiveField(3)
  final String? userId;
  @HiveField(4)
  final String? email;
  @HiveField(5)
  final String? token;
  @HiveField(6)
  final bool? isFirst;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [url, name, photo, userId, email, token, isFirst];

  UserModel copyWith({
    String? url,
    String? name,
    String? photo,
    String? userId,
    String? email,
    String? token,
    bool? isFirst,
  }) {
    return UserModel(
      url: url ?? this.url,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      token: token ?? this.token,
      isFirst: isFirst ?? this.isFirst,
    );
  }
}

extension UserModelExtension on UserModel {
  bool get isEmpty =>
      url == null ||
      name == null ||
      photo == null ||
      userId == null ||
      token == null;
}
