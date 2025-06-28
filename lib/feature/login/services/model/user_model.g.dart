// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      url: fields[0] as String?,
      name: fields[1] as String?,
      photo: fields[2] as String?,
      userId: fields[3] as String?,
      token: fields[4] as String?,
      isFirst: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.photo)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.token)
      ..writeByte(5)
      ..write(obj.isFirst);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  url: json['url'] as String?,
  name: json['name'] as String?,
  photo: json['photo'] as String?,
  userId: json['userId'] as String?,
  token: json['token'] as String?,
  isFirst: json['isFirst'] as bool?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'url': instance.url,
  'name': instance.name,
  'photo': instance.photo,
  'userId': instance.userId,
  'token': instance.token,
  'isFirst': instance.isFirst,
};
