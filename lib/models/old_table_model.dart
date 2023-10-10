import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Table extends Equatable {
  final int tablecapacity;
  final String tablename;
  const Table({required this.tablecapacity, required this.tablename});

  @override
  // TODO: implement props
  List<Object?> get props => [tablecapacity, tablename];

  static Table fromSnapshot(DocumentSnapshot snap) {
    Table table = Table(
      tablecapacity: snap['tablecapacity'],
      tablename: snap['tablename'],
    );
    return table;
  }

  static List<Table> categories = [
    Table(tablename: 'Table_1', tablecapacity: 5),
    Table(tablename: 'Table_2', tablecapacity: 3),
  ];
}
