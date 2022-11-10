import 'package:demo_project/module/social_login/views/loggedin_screen.dart';
import 'package:demo_project/utils/google_sign_in_api.dart';
import 'package:demo_project/utils/navigation_service.dart';
import 'package:demo_project/utils/view_util.dart';
import 'package:flutter/material.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            final user = await GoogleSignInAPi.login();
            if (user == null) {
              ViewUtil.SSLSnackbar("User not found");
            } else {
              LoggedInScreen(user: user).pushReplacement(context);
            }
          },
          child: Container(
            child: Text("Google Sign in "),
          ),
        ),
      ),
    );
  }
}
