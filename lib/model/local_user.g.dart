// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalUser _$LocalUserFromJson(Map<String, dynamic> json) => LocalUser(
      name: json['name'] as String,
      email: json['email'] as String,
      token: json['token'] as String?,
      password: json['password'] as String,
      currentUserId: json['currentUserId'] as String?,
      einDate: json['einDate'] as String?,
      customerUserId: json['customerUserId'] as String,
    );

Map<String, dynamic> _$LocalUserToJson(LocalUser instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'token': instance.token,
      'currentUserId': instance.currentUserId,
      'customerUserId': instance.customerUserId,
      'einDate': instance.einDate,
    };
