import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/DescriptionAR.dart';
import 'firebase_api.dart';

class ARProjectService {
  List<DescriptionAR> _arprojects = <DescriptionAR>[];

  static final ARProjectService _instance = ARProjectService._internal();

  final String _name = "ar_projects";

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  factory ARProjectService() {
    return _instance;
  }
  ARProjectService._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {}

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
      final list_images =
          await FirebaseApi.listAll("${_name}/${arproject.dir}");
      arproject.images = list_images;
      _arprojects.add(arproject);
    }
  }
}
