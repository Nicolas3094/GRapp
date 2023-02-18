import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:g_mcp/data/repository/catalogue_rep.dart';
import 'package:g_mcp/logic/blocs/arProjects/arproject_bloc.dart';

import 'package:g_mcp/logic/blocs/projects/project_bloc.dart';
import 'UI/app_state.dart';
import 'UI/components/loaderspinner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'UI/screens/home_page_widget.dart';
import 'UI/util/internationalization.dart';

import 'data/repository/arPorjects_repository.dart';
import 'data/repository/projects_rep.dart';
import 'firebase_options.dart';
import 'logic/blocs/catalogue/catalogue_bloc.dart';

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
  const MyApp({Key key}) : super(key: key);
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

  _MyAppState();

  _asyncMethod() {
    Future.delayed(Duration(milliseconds: 4000),
        () => setState(() => displaySplashImage = false));
  }

  @override
  void initState() {
    FFAppState.readJsonBio().then((value) => FFAppState.setBio(value));
    _asyncMethod();
    super.initState();
    _locale = Locale.fromSubtags(languageCode: "en");
    setState(() => FFAppState.setIDx(0));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });
  void setIndexMenu(int i) => setState(() => FFAppState.setIDx(i));
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => ProjectRepository()),
          RepositoryProvider(create: (context) => CatalogueRepository()),
          RepositoryProvider(create: (context) => ARProjectRepository()),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<ProjectBloc>(
                  lazy: false,
                  create: (context) => ProjectBloc(
                      RepositoryProvider.of<ProjectRepository>(context))
                    ..add(LoadProjectEvent())),
              BlocProvider<CatalogueBloc>(
                  lazy: false,
                  create: (context) => CatalogueBloc(
                      RepositoryProvider.of<CatalogueRepository>(context))
                    ..add(LoadCatalogueEvent())),
              BlocProvider<ARProjectBloc>(
                  lazy: true,
                  create: (context) => ARProjectBloc(
                      RepositoryProvider.of<ARProjectRepository>(context))
                    ..add(LoadARProjectEvent())),
            ],
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Gabriel Rico Studio',
                localizationsDelegates: [
                  FLocalizationsDelegate(),
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
                    : HomePageWidget())));
  }
}
