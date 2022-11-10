
import 'package:demo_project/module/social_login/views/social_login_screen.dart';
import 'package:demo_project/utils/google_sign_in_api.dart';
import 'package:demo_project/utils/navigation_service.dart';
import 'package:demo_project/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoggedInScreen extends StatelessWidget {
  const LoggedInScreen({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(user?.displayName ?? ""),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () async {
                await GoogleSignInAPi.logout();
                SocialLoginScreen().pushAndRemoveUntil(context);
              },
              child: Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
