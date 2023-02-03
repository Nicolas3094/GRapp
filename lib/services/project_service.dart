import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:g_mcp/Models/project.dart';
import 'firebase_api.dart';
import 'package:rxdart/rxdart.dart';

class ProjectService {
  static List<Project> _projects = <Project>[];

  static final ProjectService _instance = ProjectService._internal();

  static final String _name = "projects";

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static final subject = BehaviorSubject<bool>();

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
      return a.order.compareTo(b.order);
    });

    return _projects;
  }

  static Future<bool> isLoading() {
    return subject.first;
  }

  static Future<void> fetchFirebase() async {
    final collection = await _getCollection();
    for (var doc in collection.docs) {
      final dat = doc.data();
      var project = Project.fromJson(dat);
      final list_images = await FirebaseApi.listAll("${_name}/${project.dir}");
      project.images = list_images;
      _projects.add(project);
    }
    subject.add(false);
  }
}
