import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CRUD<T> {
  Future<QuerySnapshot<Map<String, dynamic>>> getCollection();
  Future<DocumentReference<Map<String, dynamic>>> add(T object);
}
