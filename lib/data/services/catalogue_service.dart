import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Models/catalogue.dart';

class CatalogueService {
  List<Catalogue> _catalogues = <Catalogue>[];

  final String _name = "catalogues";

  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  CatalogueService(this._db, this._storage);

  Future<QuerySnapshot<Map<String, dynamic>>> _getCollection() async {
    return await _db.collection(_name).get();
  }

  void addCatalogue(Catalogue obj) => _catalogues.add(obj);

  List<Catalogue> getCatalogues() {
    _catalogues.sort((a, b) {
      return a.order.compareTo(b.order);
    });
    return _catalogues;
  }

  Future<void> fetchFirebase() async {
    final collection = await _getCollection();
    for (var doc in collection.docs) {
      final dat = doc.data();
      var catalogue = Catalogue.fromJson(dat);
      final list_images = await _listAll("${_name}/${catalogue.dir}");
      catalogue.images = list_images;
      _catalogues.add(catalogue);
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
