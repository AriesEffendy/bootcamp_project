import 'dart:async';

import 'package:bootcamp_project/constants/r.dart';
import 'package:bootcamp_project/helpers/user_email.dart';
import 'package:bootcamp_project/models/network_response.dart';
import 'package:bootcamp_project/models/user_by_email.dart';
import 'package:bootcamp_project/repository/auth_api.dart';
import 'package:bootcamp_project/view/login_page.dart';
import 'package:bootcamp_project/view/main_page.dart';
import 'package:bootcamp_project/view/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SpalshScreen extends StatelessWidget {
  const SpalshScreen({super.key});
  static const String route = "splash_screen";

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () async {
      final user = UserEmail.getUserEmail();

      if (user != null) {
        final dataUser = await AuthApi().getUserEmail();
        if (dataUser.status == Status.success) {
          final data = UserByEmail.fromJson(dataUser.data!);
          if (data.status == 1) {
            Navigator.of(context).pushNamed(MainPage.route);
          } else {
            Navigator.of(context).pushNamed(RegisterPage.route);
          }
        }
      } else {
        Navigator.of(context).pushReplacementNamed(LoginPage.route);
      }
    });

    return Scaffold(
      backgroundColor: R.colors.primary,
      body: Center(
        child: Image.asset(R.assets.icSplash),
      ),
    );
  }
}
