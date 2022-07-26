import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'util/flutter_util.dart';
import 'util/internationalization.dart';
import 'index.dart';

void main() async {
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
  Locale _locale;
  ThemeMode _themeMode = ThemeMode.system;
  bool displaySplashImage = false;
  @override
  void initState() {
    FFAppState.readJsonBio().then((value) => FFAppState.setBio(value));
    Future.delayed(Duration(milliseconds: 3000),
        () => setState(() => displaySplashImage = true));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gabriel Rico Estudio',
        localizationsDelegates: [
          FFLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: _locale,
        supportedLocales: const [
          Locale('en', ''),
          Locale('es', ''),
        ],
        theme: ThemeData(brightness: Brightness.light),
        themeMode: _themeMode,
        home: !displaySplashImage
            ? Container(
                width: 400,
                height: 400,
                color: Colors.white,
                child: Center(
                    child: Image.asset(
                  'assets/images/GABRIEGIRANDO.gif',
                  fit: BoxFit.fitWidth,
                )))
            : HomePageWidget());
  }
}
