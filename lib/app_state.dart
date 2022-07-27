import 'package:flutter/services.dart';
import 'package:g_mcp/Models/bio.dart';
import 'package:g_mcp/Models/catalogue.dart';
import 'package:g_mcp/Models/imagen.dart';
import 'package:g_mcp/Models/project.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:g_mcp/transformer/transformers.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class FFAppState {
  static const String _PROJECTPATH = "jsonfile/projects.json";
  static const String _CATALOGUETPATH = "jsonfile/catginfo.json";
  static const String _BIOTPATH = "jsonfile/bioinfo.json";

  static final FFAppState _instance = FFAppState._internal();
  static List<Project> _projects;
  static List<Catalogue> _catalogues;
  static BioInfo _bio;
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

  static Future<List<Imagen>> getImgsProject(List<dynamic> jsondata) async =>
      jsondata.map((e) => Imagen.fromJson(e)).toList();

  static List<Project> getProjects() => _projects;

  static void setProjects(List<Project> futurePorject) {
    _projects = futurePorject;
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

  static List<Catalogue> getCatalogues() => _catalogues;

  static void setCatalogues(List<Catalogue> futureCatalogues) {
    _catalogues = futureCatalogues;
  }

  static void setBio(BioInfo bio) {
    _bio = bio;
  }

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
/*
LatLng _latLngFromString(String val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}*/
