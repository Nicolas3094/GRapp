import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:g_mcp/Models/project.dart';
import 'firebase_api.dart';

class ProjectService {
  static List<Project> _projects = <Project>[];

  static final ProjectService _instance = ProjectService._internal();

  static final String _name = "projects";

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  factory ProjectService() {
    return _instance;
  }
  ProjectService._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {}

  static Future<QuerySnapshot<Map<String, dynamic>>> _getCollection() async {
    return await _db.collection(_name).get();
  }

  static void addProject(Project obj) {
    _projects.add(obj);
  }

  static List<Project> getProjects() {
    _projects.sort((a, b) {
      var idxA = a.dir.substring(0, 2);
      var splittedA = idxA.split(".");
      var indexA = int.parse(splittedA[0]);

      var idxB = b.dir.substring(0, 2);
      var splittedB = idxB.split(".");
      var indexB = int.parse(splittedB[0]);

      return indexA.compareTo(indexB);
    });

    return _projects.reversed.toList();
  }

  static Future<void> fetchFirebase() async {
    final collection = await _getCollection();
    for (var doc in collection.docs) {
      final dat = doc.data();
      var project = Project.fromJson(dat);
      final list_images = await FirebaseApi.listAll(_name + "/" + project.dir);
      project.images = list_images;
      _projects.add(project);
    }
  }
}
