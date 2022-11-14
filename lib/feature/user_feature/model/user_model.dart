// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String email;

  @HiveField(4)
  bool tempInCel;

  UserModel(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      this.tempInCel = true});

  UserModel copyWith(
      {int? id,String? firstName, String? lastName, String? email, bool? tempInCel}) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      tempInCel: tempInCel ?? this.tempInCel,
    );
  }
}
