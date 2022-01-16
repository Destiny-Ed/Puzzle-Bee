import 'dart:io';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/foundation.dart' as notify;
import 'package:flutter/material.dart';
import 'package:flutter_puzzle/utils/router.dart';
import 'package:flutter_puzzle/widgets/auth/verify_account.dart';
import 'package:flutter_puzzle/widgets/game/page.dart';

class AuthProvider extends notify.ChangeNotifier {
  String? _msg = '';
  bool _status = false;

  String get getMsg => _msg!;

  bool get getStatus => _status;

  void createAccount(
      {String? email,
      String? password,
      String? phone,
      String? username,
      BuildContext? ctx}) async {
    ///Create New User
    var userAttributes = {'phone_number': '$phone', 'name': '$username'};
    try {
      SignUpResult res = await Amplify.Auth.signUp(
          username: email!,
          password: password,
          options: CognitoSignUpOptions(userAttributes: userAttributes));
      if (res.isSignUpComplete == true) {
        _status = false;
        _msg = "Success";
        notifyListeners();
        PageRouter(ctx).pushPageAndRemove(OTPConf(email: email));
      }
    } on AuthException catch (e) {
      print(e.message);
      _msg = e.message;
      _status = false;
      notifyListeners();
    } on SocketException catch (_) {
      _msg = "Please connect to internet";
      _status = false;
      notifyListeners();
    } catch (_) {
      _msg = "Please try again";
      _status = false;
      notifyListeners();
    }
  }

  void loginUser({String? email, String? password, BuildContext? ctx}) async {
    ///Login existing user
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: email!,
        password: password!,
      );
      if (res.isSignedIn == true) {
        _status = false;
        _msg = "Success";
        notifyListeners();
        PageRouter(ctx).pushPageAndRemove(GamePage());
      }
    } on AuthException catch (e) {
      print(e.message);
      _msg = e.message;
      _status = false;
      notifyListeners();
    } on SocketException catch (_) {
      _msg = "Please connect to internet";
      _status = false;
      notifyListeners();
    } catch (_) {
      _msg = "Please try again";
      _status = false;
      notifyListeners();
    }
  }

  void verifyEmail({String? email, String? code, BuildContext? ctx}) async {
    ///Verify user email
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
        username: email!,
        confirmationCode: code!,
      );
      if (res.isSignUpComplete == true) {
        _status = false;
        _msg = "Success";
        notifyListeners();
        PageRouter(ctx).pushPageAndRemove(GamePage());
      }
    } on AuthException catch (e) {
      print(e.message);
      _msg = e.message;
      _status = false;
      notifyListeners();
    } on SocketException catch (_) {
      _msg = "Please connect to internet";
      _status = false;
      notifyListeners();
    } catch (_) {
      _msg = "Please try again";
      _status = false;
      notifyListeners();
    }
  }
}
