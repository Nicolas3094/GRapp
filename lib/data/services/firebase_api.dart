import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  final FirebaseStorage storage;

  FirebaseApi(this.storage);

  Future<List<String>> listAll(String path) async {
    final ref = storage.ref(path);
    final result = await ref.listAll();
    final urls = await _getDownloadLinks(result.items);
    return urls;
  }

  Future<List<String>> _getDownloadLinks(List<Reference> items) {
    return Future.wait(items.map((e) => e.getDownloadURL()).toList());
  }

  Future<String> getURL(String path) async {
    final url = storage.ref(path).getDownloadURL();
    return url;
  }
}
