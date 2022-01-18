import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_puzzle/utils/router.dart';
import 'package:flutter_puzzle/widgets/auth/login.dart';
import 'package:flutter_puzzle/widgets/game/page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      // if (!kIsWeb) {
      //   if (Platform.isAndroid || Platform.isIOS) {
      //     try {
      //       final awsUser = await Amplify.Auth.getCurrentUser();
      //       //send user to dashboard
      //       PageRouter(context).pushPageAndRemove(GamePage());
      //     } on AuthException catch (e) {
      //       //send user to login
      //       print(e.message);
      //       PageRouter(context).pushPageAndRemove(const SignIn());
      //     }
      //   } else {
      //     PageRouter(context).pushPageAndRemove(GamePage());
      //   }
      // } else {
      //   PageRouter(context).pushPageAndRemove(GamePage());
      // }
      PageRouter(context).pushPageAndRemove(GamePage());
    });
    return Scaffold(
      body: Center(
        child: Image.asset('artwork/ic_launcher.png', width: 100),
      ),
    );
  }
}
