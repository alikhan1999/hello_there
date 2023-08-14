import 'package:json_annotation/json_annotation.dart';

part 'local_user.g.dart';

@JsonSerializable(explicitToJson: true)
class LocalUser {
  final String name;

  final String email;
  final String password;
  final String? token;
  final String? currentUserId;
  final String customerUserId;
  final String? einDate;

  LocalUser({
    required this.name,
    required this.email,
    this.token,
    required this.password,
    this.currentUserId,
    this.einDate,
    required this.customerUserId,
  });
  factory LocalUser.fromJson(Map<String, dynamic> json) =>
      _$LocalUserFromJson(json);

  Map<String, dynamic> toJson() => _$LocalUserToJson(this);
}
