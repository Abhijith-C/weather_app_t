import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/feature/user_feature/model/user_model.dart';

class UserDb {
  static Future addUser(UserModel user) async {
    int id = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    var box = await Hive.openBox<UserModel>('userDb');
    await box.put(user.email, user.copyWith(id: id));
    box.close();
  }

  static Future<List<UserModel>> getAllUser() async {
    final box = await Hive.openBox<UserModel>('userDb');
    return box.values.toList();
  }

  static Future updateUser(UserModel user) async {
    var box = await Hive.openBox<UserModel>('userDb');
    await box.put(user.email, user);
    box.close();
  }

  static Future deleteUser(
    int id,
  ) async {
    var box = await Hive.openBox<UserModel>('userDb');
    await box.deleteAt(id);
    box.close();
  }
}
