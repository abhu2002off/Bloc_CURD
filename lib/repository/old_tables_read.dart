import 'package:table_curd_bloc/models/old_table_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TableRepository {
  final FirebaseFirestore _firebaseFirestore;

  TableRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Table>> getAllTables() {
    return _firebaseFirestore.collection('table').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Table.fromSnapshot(doc)).toList();
    });
  }
}
