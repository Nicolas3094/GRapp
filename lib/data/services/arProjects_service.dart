import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../Models/DescriptionAR.dart';

class ARProjectService {
  List<DescriptionAR> _arprojects = <DescriptionAR>[];

  final String _name = "ar_projects";

  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  ARProjectService(this._db, this._storage);

  Future<QuerySnapshot<Map<String, dynamic>>> _getCollection() async {
    return await _db.collection(_name).get();
  }

  void addARProject(DescriptionAR obj) => _arprojects.add(obj);

  List<DescriptionAR> getProjects() {
    _arprojects.sort((a, b) {
      return a.order.compareTo(b.order);
    });
    return _arprojects;
  }

  Future<void> fetchFirebase() async {
    final collection = await _getCollection();
    for (var doc in collection.docs) {
      final dat = doc.data();
      var arproject = DescriptionAR.fromJson(dat);
      final list_images = await _listAll("${_name}/${arproject.dir}");
      arproject.images = list_images;
      _arprojects.add(arproject);
    }
  }

  Future<List<String>> _listAll(String path) async {
    final ref = _storage.ref(path);
    final result = await ref.listAll();
    final urls = await _getDownloadLinks(result.items);
    return urls;
  }

  Future<List<String>> _getDownloadLinks(List<Reference> items) {
    return Future.wait(items.map((e) => e.getDownloadURL()).toList());
  }
}
