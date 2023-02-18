import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/catalogue.dart';
import 'firebase_api.dart';
import 'package:rxdart/rxdart.dart';

class CatalogueService {
  List<Catalogue> _catalogues = <Catalogue>[];

  static final CatalogueService _instance = CatalogueService._internal();

  final String _name = "catalogues";

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final subject = BehaviorSubject<bool>();
  Future<bool> isLoading() async => subject.first;

  factory CatalogueService() {
    return _instance;
  }
  CatalogueService._internal();

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
      final list_images =
          await FirebaseApi.listAll("${_name}/${catalogue.dir}");
      catalogue.images = list_images;
      _catalogues.add(catalogue);
    }
    subject.add(false);
  }
}
