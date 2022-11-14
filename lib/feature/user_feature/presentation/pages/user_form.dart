// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/config/constants/style.dart';
import 'package:weather_app/feature/user_feature/model/user_model.dart';
import 'package:weather_app/feature/user_feature/presentation/bloc/user/user_bloc.dart';
import 'package:weather_app/feature/user_feature/presentation/widgets/custom_form_text_field.dart';
import 'package:weather_app/feature/user_feature/presentation/widgets/form_event_button.dart';

class UserForm extends StatefulWidget {
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;
  GlobalKey<FormState> formKey;
  UserForm(
      {Key? key,
      required this.firstNameController,
      required this.lastNameController,
      required this.emailController,
      required this.formKey})
      : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.firstNameController.clear();
    widget.lastNameController.clear();
    widget.emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return UnconstrainedBox(
      child: Container(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        width: size.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40))),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              CustomFormTextField(
                  controller: widget.firstNameController,
                  hintText: 'First name'),
              const SizedBox(
                height: 10,
              ),
              CustomFormTextField(
                  controller: widget.lastNameController, hintText: 'Last name'),
              const SizedBox(
                height: 10,
              ),
              CustomFormTextField(
                  controller: widget.emailController, hintText: 'Email'),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FormEventButton(
                    title: 'Cancel',
                    backgroundColor: const Color.fromARGB(255, 226, 99, 99),
                    onTap: () => Navigator.pop(context),
                  ),
                  FormEventButton(
                    title: 'Save',
                    backgroundColor: themeColor,
                    onTap: () {
                      if (widget.formKey.currentState!.validate()) {
                        saveUserToDb(context);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveUserToDb(BuildContext context) {
    final user = UserModel(
        firstName: widget.firstNameController.text.trim(),
        lastName: widget.lastNameController.text.trim(),
        email: widget.emailController.text.trim());
    context.read<UserBloc>().add(AddUser(user: user));
  }
}
