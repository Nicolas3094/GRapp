import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:g_mcp/components/loaderspinner.dart';
import 'util/flutter_util.dart';
import 'index.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FFAppState(); // Initialize FFAppState
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _fbapp = Firebase.initializeApp();
  ThemeMode _themeMode = ThemeMode.system;
  bool displaySplashImage = false;
  @override
  void initState() {
    FFAppState.readJsonBio().then((value) => FFAppState.setBio(value));
    super.initState();

    _fbapp.whenComplete(() {
      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() {
          displaySplashImage = true;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gabriel Rico Estudio',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(brightness: Brightness.light),
        themeMode: _themeMode,
        home: !displaySplashImage
            ? LoaderSpinner(
                h: 200,
                w: 200,
              )
            : HomePageWidget());
  }
}
