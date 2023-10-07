import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  createOne({required String collection, required Map<String, dynamic> data}) {
    return _fireStore.collection(collection).add(data);
  }

  deleteOne({required String collection, required String path}) {
    return _fireStore.collection(collection).doc(path).delete();
  }

  updateOne({
    required String collection,
    required String path,
    required Map<String, dynamic> data,
  }) {
    return _fireStore.collection(collection).doc(path).update(data);
  }
}
