import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../dashboard/screens/dasboad_screen.dart';
import '../bloc/register_bloc.dart';
import '../../../utils/ui/animations/router/push_animation_pageroute.dart';

import '../../../utils/ui/dialogs/loading_dialog.dart';
import '../../../widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterBloc _registerBloc = RegisterBloc();
  final TextEditingController idControlller = TextEditingController();
  final TextEditingController usernameControlller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterBloc, RegisterState>(
        bloc: _registerBloc,
        listener: (_, state) async {
          if (state is RegisterLoadingState) {
            showLoadingDialog(context);
          }
          if (state is RegisteredState) {
            Navigator.of(context).pushAndRemoveUntil(
              AppPageRoute(page: const DashBoard()),
              (_) => false,
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            // padding: const EdgeInsets.all(20).copyWith(bottom: 0),
            child: Column(
              children: [
                const Text(
                  'Registration',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  'A UserProperty is an attribute that describes the app-user. By supplying UserProperties, you can easy analyze later.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: idControlller,
                  label: 'Id',
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: usernameControlller,
                  label: 'Username',
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[900],
                    surfaceTintColor: Colors.transparent,
                    // shape: const BeveledRectangleBorder()
                    minimumSize: const Size(double.infinity, 40),
                    // maximumSize: const Size(double.infinity, 40),
                  ),
                  onPressed: () {
                    _registerBloc.add(
                      OnClickRegisterEvent(
                        idControlller.text,
                        usernameControlller.text,
                      ),
                    );
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
