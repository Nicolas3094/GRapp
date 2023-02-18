import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/project.dart';
import 'firebase_api.dart';

class ProjectService {
  List<Project> _projects = <Project>[];

  static final ProjectService _instance = ProjectService._internal();

  final String _name = "projects";

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  factory ProjectService() {
    return _instance;
  }
  ProjectService._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {}

  Future<QuerySnapshot<Map<String, dynamic>>> _getCollection() async {
    return await _db.collection(_name).get();
  }

  void addProject(Project obj) {
    _projects.add(obj);
  }

  List<Project> getProjects() {
    _projects.sort((a, b) {
      return a.order.compareTo(b.order);
    });

    return _projects;
  }

  Future<void> fetchFirebase() async {
    final collection = await _getCollection();
    for (var doc in collection.docs) {
      final dat = doc.data();
      var project = Project.fromJson(dat);
      final list_images = await FirebaseApi.listAll("${_name}/${project.dir}");
      project.images = list_images;
      _projects.add(project);
    }
  }
}
