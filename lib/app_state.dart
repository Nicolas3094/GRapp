import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:g_mcp/Models/bio.dart';
import 'package:g_mcp/Models/catalogue.dart';
import 'package:g_mcp/Models/imagen.dart';
import 'package:g_mcp/Models/project.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:g_mcp/UI/transformer/transformers.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:rxdart/rxdart.dart';

import 'Models/Description.dart';

class FFAppState {
  static final queueIndex = Queue<int>();

  static final subject = BehaviorSubject<String>();

  static const String _PROJECTPATH = "jsonfile/projects.json";
  static const String _PROJECTARPATH = "jsonfile/arprojects.json";

  static const String _CATALOGUETPATH = "jsonfile/catginfo.json";
  static const String _BIOTPATH = "jsonfile/bioinfo.json";
  static const String _ARPATH = "jsonfile/ar_description.json";

  static final FFAppState _instance = FFAppState._internal();
  static List<Project> _projects = <Project>[];
  static List<Catalogue> _catalogues = <Catalogue>[];
  static List<Project> _projectsar;

  static BioInfo _bio;
  static Description _arDescription;

  static bool _firstSplash = false;

  static int _indx = 0;

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

  static Future<List<Project>> readJsonProjects() async {
    final jsondata = await rootBundle.loadString(_PROJECTPATH);
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Project.fromJson(e)).toList();
  }

  static Future<List<Project>> readJsonARProjects() async {
    final jsondata = await rootBundle.loadString(_PROJECTARPATH);
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Project.fromJson(e)).toList();
  }

  static Future<List<Imagen>> getImgsProject(List<dynamic> jsondata) async =>
      jsondata.map((e) => Imagen.fromJson(e)).toList();

  static List<Project> getProjects() => _projects;
  static List<Project> getARProjects() => _projectsar;

  static void setProjects(List<Project> futurePorject) {
    _projects = futurePorject;
  }

  static void addProject(Project obj) {
    _projects.add(obj);
  }

  static void addCatalogue(Catalogue obj) {
    _catalogues.add(obj);
  }

  static void setARProjects(List<Project> futurePorject) {
    _projectsar = futurePorject;
  }

  static Future<List<Catalogue>> readJsonCatalogues() async {
    final jsondata = await rootBundle.loadString(_CATALOGUETPATH);
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Catalogue.fromJson(e)).toList();
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

  static List<Catalogue> getCatalogues() => _catalogues;

  static void setCatalogues(List<Catalogue> futureCatalogues) {
    _catalogues = futureCatalogues;
  }

  static void setBio(BioInfo bio) {
    _bio = bio;
  }

  static Description getARDescription() => _arDescription;
  static BioInfo getBio() => _bio;

  static PageTransformer getTransformer(int index) => _transformers[index];

  static List<PageTransformer> getTransformers() => _transformers;

  static Future<bool> compileJSON() async {
    var listprj = await readJsonProjects();
    setProjects(listprj);
    var listcat = await readJsonCatalogues();
    setCatalogues(listcat);
    var bioi = await readJsonBio();
    setBio(bioi);
    return true;
  }

  static getMenu() {
    return;
  }
}
