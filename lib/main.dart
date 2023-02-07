import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:g_mcp/app_state.dart';
import 'package:g_mcp/components/loaderspinner.dart';
import 'package:g_mcp/services/catalogue_service.dart';
import 'package:g_mcp/services/project_service.dart';
import 'util/flutter_util.dart';
import 'util/internationalization.dart';
import 'index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FFAppState(); // Initialize FFAppState
  FFAppState.queueIndex.add(0);
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
  Future<List<String>> futureFiles;

  Locale _locale;
  ThemeMode _themeMode = ThemeMode.system;
  bool displaySplashImage = true;

  _asyncMethod() {
    ProjectService.fetchFirebase();
    CatalogueService.fetchFirebase();

    Future.delayed(Duration(milliseconds: 4000),
        () => setState(() => displaySplashImage = false));
  }

  @override
  void initState() {
    FFAppState.readJsonBio().then((value) => FFAppState.setBio(value));
    _asyncMethod();
    super.initState();
    _locale = Locale.fromSubtags(languageCode: "en");
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
        home: displaySplashImage
            ? LoaderSpinner(h: 200, w: 200)
            : HomePageWidget());
  }
}
