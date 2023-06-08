import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:g_mcp/data/Models/press_model.dart';

class PressService {
  List<Press> _press = <Press>[];

  final String _name = "press";
  final FirebaseFirestore _db;

  PressService(this._db);

  Future<QuerySnapshot<Map<String, dynamic>>> _getCollection() async {
    return await _db.collection(_name).get();
  }

  void addPress(Press obj) {
    _press.add(obj);
  }

  List<Press> getProjects() {
    _press.sort((a, b) {
      return a.order.compareTo(b.order);
    });

    return _press;
  }

  Future<void> fetchFirebase() async {
    final collection = await _getCollection();
    for (var doc in collection.docs) {
      final dat = doc.data();
      var project = Press.fromJson(dat);
      _press.add(project);
    }
  }
}
