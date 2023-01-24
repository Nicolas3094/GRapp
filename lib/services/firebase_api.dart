import 'package:firebase_storage/firebase_storage.dart';

import '../Models/firebase_file.dart';

class FirebaseApi {
  static final FirebaseStorage storage = FirebaseStorage.instance;

  static Future<List<String>> listAll(String path) async {
    final ref = storage.ref(path);
    final result = await ref.listAll();
    final urls = await _getDownloadLinks(result.items);
    return urls;
  }

  static Future<List<String>> _getDownloadLinks(List<Reference> items) {
    return Future.wait(items.map((e) => e.getDownloadURL()).toList());
  }

  static Future<String> getURL(String path) async {
    final url = storage.ref(path).getDownloadURL();
    return url;
  }
}
