import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:g_mcp/Models/catalogue.dart';
import 'firebase_api.dart';

class CatalogueService {
  static List<Catalogue> _catalogues = <Catalogue>[];

  static final CatalogueService _instance = CatalogueService._internal();

  static final String _name = "catalogues";

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  factory CatalogueService() {
    return _instance;
  }
  CatalogueService._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {}

  static Future<QuerySnapshot<Map<String, dynamic>>> _getCollection() async {
    return await _db.collection(_name).get();
  }

  static void addCatalogue(Catalogue obj) {
    _catalogues.add(obj);
  }

  static List<Catalogue> getCatalogues() => _catalogues;

  static Future<void> fetchFirebase() async {
    final collection = await _getCollection();
    for (var doc in collection.docs) {
      final dat = doc.data();
      var catalogue = Catalogue.fromJson(dat);
      final list_images =
          await FirebaseApi.listAll("${_name}/${catalogue.dir}");
      catalogue.images = list_images;
      _catalogues.add(catalogue);
    }
  }
}