import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:g_mcp/Models/DescriptionAR.dart';
import 'firebase_api.dart';
import 'package:rxdart/rxdart.dart';

class ARProjectService {
  
  static List<DescriptionAR> _arprojects = <DescriptionAR>[];

  static final ARProjectService _instance = ARProjectService._internal();

  static final String _name = "ar_projects";

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final subject = BehaviorSubject<bool>();
  static Future<bool> isLoading() async => subject.first;

  factory ARProjectService() {
    return _instance;
  }
  ARProjectService._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {}

  static Future<QuerySnapshot<Map<String, dynamic>>> _getCollection() async {
    return await _db.collection(_name).get();
  }

  static void addARProject(DescriptionAR obj) => _arprojects.add(obj);

  static List<DescriptionAR> getCatalogues() {
    _arprojects.sort((a, b) {
      return a.order.compareTo(b.order);
    });
    return _arprojects;
  }

  static Future<void> fetchFirebase() async {
    final collection = await _getCollection();
    for (var doc in collection.docs) {
      final dat = doc.data();
      var arproject = DescriptionAR.fromJson(dat);
      final list_images =
          await FirebaseApi.listAll("${_name}/${arproject.dir}");
      arproject.images = list_images;
      _arprojects.add(arproject);
    }
    subject.add(false);
  }
}
