import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:g_mcp/UI/transformer/transformers.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:rxdart/rxdart.dart';

import '../data/Models/Description.dart';
import '../data/Models/bio.dart';
import '../data/Models/imagen.dart';
import '../data/Models/project.dart';

class FFAppState {
  static final queueIndex = Queue<int>();

  static final subject = BehaviorSubject<String>();

  static const String _BIOTPATH = "jsonfile/bioinfo.json";
  static const String _ARPATH = "jsonfile/ar_description.json";

  static final FFAppState _instance = FFAppState._internal();
  static List<Project> _projectsar;

  static BioInfo _bio;
  static Description _arDescription;

  static bool _firstSplash = false;

  static final _transformers = [
    AccordionTransformer(),
    ThreeDTransformer(),
    ZoomInPageTransformer(),
    ZoomOutPageTransformer(),
    DeepthPageTransformer(),
    ScaleAndFadeTransformer()
  ];

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _english = prefs.getBool('ff_English') ?? _english;
  }

  SharedPreferences prefs;

  bool _english = true;
  bool get english => _english;
  set english(bool _value) {
    _english = _value;
    prefs.setBool('ff_English', _value);
  }

  static void setIDx(int i) {
    queueIndex.add(i);
  }

  static int getIDx() {
    if (queueIndex.isEmpty) return 0;
    return queueIndex.last;
  }

  static void popIdx() {
    if (queueIndex.isEmpty) return;
    queueIndex.removeLast();
  }

  static void setFirstSplash() {
    _firstSplash = true;
  }

  static bool getFirstSplash() {
    return _firstSplash;
  }

  static Future<List<Imagen>> getImgsProject(List<dynamic> jsondata) async =>
      jsondata.map((e) => Imagen.fromJson(e)).toList();

  static List<Project> getARProjects() => _projectsar;

  static void setARProjects(List<Project> futurePorject) {
    _projectsar = futurePorject;
  }

  static Future<BioInfo> readJsonBio() async {
    final jsondata = await rootBundle.loadString(_BIOTPATH);
    final dat = json.decode(jsondata);
    return BioInfo.fromJson(dat);
  }

  static Future<Description> readJsonARDescription() async {
    final jsondata = await rootBundle.loadString(_ARPATH);
    final dat = json.decode(jsondata);
    return Description.fromJson(dat);
  }

  static void setBio(BioInfo bio) {
    _bio = bio;
  }

  static Description getARDescription() => _arDescription;
  static BioInfo getBio() => _bio;

  static PageTransformer getTransformer(int index) => _transformers[index];

  static List<PageTransformer> getTransformers() => _transformers;

  static getMenu() {
    return;
  }
}
