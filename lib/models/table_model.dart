class TableModel {
  final String? tablecapacity;
  final String? tablename;
  final String? docid;
  TableModel({this.tablecapacity = "", this.tablename = "", this.docid = ""});

  factory TableModel.fromJson(Map<String, dynamic> json, String docid) {
    return TableModel(
        tablecapacity: json['table_capacity'],
        tablename: json['table_name'],
        docid: docid);
  }
}
