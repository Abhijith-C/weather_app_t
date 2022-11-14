import 'package:bloc/bloc.dart';
import 'package:weather_app/feature/user_feature/data/local_db/user_db.dart';
import 'package:weather_app/feature/user_feature/model/user_model.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<AddUser>((event, emit) async {
      await UserDb.addUser(event.user);
      add(GetAllUser());
    });
    on<DeleteUser>((event, emit) async {
      await UserDb.deleteUser(event.index);
      add(GetAllUser());
    });
    on<GetAllUser>((event, emit) async {
      final allUser = await UserDb.getAllUser();
      emit(UserState(users: allUser));
    });
    on<UpdateUser>((event, emit) async {
      await UserDb.updateUser( event.user);
      add(GetAllUser());
    });
  }
}
