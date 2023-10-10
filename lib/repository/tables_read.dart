import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:table_curd_bloc/models/table_model.dart';

class TablesRepository {
  final _fireCloud = FirebaseFirestore.instance.collection("table");

  Future<List<TableModel>> get() async {
    List<TableModel> tablemodellist = [];
    try {
      final conn = await _fireCloud.get();
      conn.docs.forEach((element) {
        print(element.id);
        print(element.data());
        return tablemodellist
            .add(TableModel.fromJson(element.data(), element.id));
      });
      return tablemodellist;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}':${e.message}");
      }
      return tablemodellist;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> create(
      {required String tablecapacity, required String tablename}) async {
    try {
      await _fireCloud
          .add({"table_capacity": tablecapacity, "table_name": tablename});
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
