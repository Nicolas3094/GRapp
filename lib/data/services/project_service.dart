import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../Models/project.dart';

class ProjectService {
  List<Project> _projects = <Project>[];

  final String _name = "projects";
  final FirebaseStorage _storage;
  final FirebaseFirestore _db;

  ProjectService(this._db, this._storage);

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
      final list_images = await _listAll("${_name}/${project.dir}");
      project.images = list_images;
      _projects.add(project);
    }
  }

  Future<List<String>> _listAll(String path) async {
    final storageRef = await _storage.ref(path);

    final result = await storageRef.listAll();
    final urls = await _getDownloadLinks(result.items);
    return urls;
  }

  Future<List<String>> _getDownloadLinks(List<Reference> items) {
    return Future.wait(items.map((e) => e.getDownloadURL()).toList());
  }
}
