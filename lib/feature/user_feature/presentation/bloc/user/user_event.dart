// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent {
  const UserEvent();
}

class AddUser extends UserEvent {
  UserModel user;
  AddUser({
    required this.user,
  });
}

class DeleteUser extends UserEvent {
  int index;
  DeleteUser({
    required this.index,
  });
}

class UpdateUser extends UserEvent {

  UserModel user;
  UpdateUser({

    required this.user,
  });
}

class GetAllUser extends UserEvent {}
