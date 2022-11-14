// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

class UserState {
  List<UserModel> users;
  UserState({
    required this.users,
  });
}

class UserInitial extends UserState {
  UserInitial() : super(users: []);
}
