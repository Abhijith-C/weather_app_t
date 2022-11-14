import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/config/application_cache/cache_manager.dart';
import 'package:weather_app/config/constants/keys.dart';
import 'package:weather_app/config/constants/style.dart';
import 'package:weather_app/feature/user_feature/presentation/bloc/user/user_bloc.dart';
import 'package:weather_app/feature/user_feature/presentation/pages/login_screen.dart';
import 'package:weather_app/feature/user_feature/presentation/pages/user_form.dart';
import 'package:weather_app/feature/weather/presentation/pages/weather_screen.dart';

class UserListScreen extends StatefulWidget {
  UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _emailController = TextEditingController();
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    context.read<UserBloc>().add(GetAllUser());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 0,
        centerTitle: true,
        title: Text('All Users'),
        actions: [
          IconButton(
              onPressed: () async {
                await Cache.saveData(LOGIN_STATUS_KEY, false);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40))),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state.users.isNotEmpty) {
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return Dismissible(
                        background: dismissilbe_background(),
                        key: Key(user.id.toString()),
                        onDismissed: (direction) {
                          context
                              .read<UserBloc>()
                              .add(DeleteUser(index: index));
                        },
                        child: ListTile(
                          onTap: () {
                            print('123 ${user.tempInCel}');

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WeatherScreen(
                                    tempInCel: user.tempInCel,
                                  ),
                                ));
                          },
                          leading: const CircleAvatar(
                            radius: 25,
                          ),
                          title: Text(user.firstName + " " + user.lastName),
                          subtitle: Text(user.email),
                          trailing: Switch(
                            value: user.tempInCel,
                            onChanged: (value) {
                              context.read<UserBloc>().add(UpdateUser(
                                  user: user.copyWith(tempInCel: value)));
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No User Found'),
                  );
                }
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeColor,
        onPressed: () async {
          await showModalBottomSheet<void>(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              context: context,
              builder: (context) => Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: UserForm(
                      formKey: _formKey,
                      firstNameController: _firstNameController,
                      lastNameController: _lastNameController,
                      emailController: _emailController,
                    ),
                  ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Container dismissilbe_background() {
    return Container(
      color: Colors.red,
      child: const Center(
        child: Text(
          'Delete',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
