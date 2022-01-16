import 'dart:io';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_puzzle/amplifyconfiguration.dart';
import 'package:flutter_puzzle/config/ui.dart';
import 'package:flutter_puzzle/provider/auth_provider.dart';
import 'package:flutter_puzzle/utils/platform.dart';
import 'package:flutter_puzzle/widgets/auth/splash.dart';
import 'package:flutter_puzzle/widgets/game/page.dart';
import 'package:provider/provider.dart';

void main() {
  _setTargetPlatformForDesktop();
  runApp(
    const ConfigUiContainer(
      child: MyApp(),
    ),
  );
}

/// If the current platform is desktop, override the default platform to
/// a supported platform (iOS for macOS, Android for Linux and Windows).
/// Else, do nothing.
void _setTargetPlatformForDesktop() {
  TargetPlatform? targetPlatform;
  if (platformCheck(() => Platform.isMacOS)) {
    targetPlatform = TargetPlatform.iOS;
  } else if (platformCheck(() => Platform.isLinux || Platform.isWindows)) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ///Configure Amplify
  Future<void> _configureAmplify() async {
    try {
      // Add the following line to add Auth plugin to your app.
      await Amplify.addPlugin(AmplifyAuthCognito());

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      print('An error occurred configuring Amplify: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return _MyMaterialApp();
  }
}

/// Base class for all platforms, such as
/// [Platform.isIOS] or [Platform.isAndroid].
abstract class _MyPlatformApp extends StatelessWidget {
  const _MyPlatformApp();
}

class _MyMaterialApp extends _MyPlatformApp {
  @override
  Widget build(BuildContext context) {
    final ui = ConfigUiContainer.of(context);

    ThemeData applyDecor(ThemeData theme) => theme.copyWith(
          primaryColor: Colors.blue,
          // iconTheme: theme.iconTheme.copyWith(color: Colors.white),
          dialogTheme: const DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
          textTheme: theme.textTheme.apply(fontFamily: 'ManRope'),
          primaryTextTheme: theme.primaryTextTheme.apply(fontFamily: 'ManRope'),
          accentTextTheme: theme.accentTextTheme.apply(fontFamily: 'ManRope'),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
        );

    final baseDarkTheme = applyDecor(ThemeData(
      brightness: Brightness.dark,
      canvasColor: Color(0xFF121212),
      backgroundColor: Color(0xFF121212),
      cardColor: Color(0xFF1E1E1E),
    ));
    final baseLightTheme = applyDecor(ThemeData.light());

    ThemeData darkTheme;
    ThemeData lightTheme;
    if (ui.useDarkTheme == null) {
      // auto
      darkTheme = baseDarkTheme;
      lightTheme = baseLightTheme;
    } else if (ui.useDarkTheme == true) {
      // dark
      darkTheme = baseDarkTheme;
      lightTheme = baseDarkTheme;
    } else {
      // light
      darkTheme = baseLightTheme;
      lightTheme = baseLightTheme;
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: darkTheme,
        theme: lightTheme,
        home: Builder(
          builder: (context) {
            bool useDarkTheme;
            if (ui.useDarkTheme == null) {
              var platformBrightness =
                  MediaQuery.of(context).platformBrightness;
              useDarkTheme = platformBrightness == Brightness.dark;
            } else {
              useDarkTheme = ui.useDarkTheme!;
            }
            final overlay = useDarkTheme
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark;
            SystemChrome.setSystemUIOverlayStyle(
              overlay.copyWith(
                statusBarColor: Colors.transparent,
              ),
            );
            return const SplashScreen();
          },
        ),
      ),
    );
  }
}

class _MyCupertinoApp extends _MyPlatformApp {
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp();
  }
}
