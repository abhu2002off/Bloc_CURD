import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:table_curd_bloc/screens/table/table_operation/table_read/table_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController _tablecapacityController =
      TextEditingController();
  final TextEditingController _tablenameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TablesBloc>(context).add(const LoadReadSuccessTable());
  }

  void _postData(context) {
    BlocProvider.of<TablesBloc>(context).add(
      Create(_tablecapacityController.text, _tablenameController.text),
    );
  }

  Future<void> create() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                left: 20,
                top: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _tablecapacityController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration:
                      const InputDecoration(labelText: 'Table Capacity'),
                ),
                TextField(
                  controller: _tablenameController,
                  decoration: const InputDecoration(labelText: "Table Name"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String tablename = _tablenameController.text;
                      final String? tablecapacity =
                          _tablecapacityController.text;

                      if (tablecapacity != null) {
                        _postData(context);

                        _tablenameController.text = '';
                        _tablecapacityController.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Create"))
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Firebase Firestore')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
