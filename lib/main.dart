import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:table_curd_bloc/repository/old_tables_read.dart';
import 'package:table_curd_bloc/screens/table/table_operation/table_read/table_bloc.dart';
//import 'package:table_curd_bloc/screens/table/table_operation/table_read/table_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:table_curd_bloc/repository/tables_read.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:table_curd_bloc/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider(create: (context) => TablesRepository())],
      child: MaterialApp(
        title: 'Firebase CRUD Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Builder(builder: (context) {
          return const Home();
        }),
      ),
    );
  }
}

GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    TablesRepository repo = Provider.of<TablesRepository>(context);
    return BlocProvider(
      create: (context) => TablesBloc(tablesRepository: repo),
      child: Scaffold(
          key: scaffoldKey,
          body:
              BlocListener<TablesBloc, TableState>(listener: (context, state) {
            if (state is TableAdded) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Product added"),
                duration: Duration(seconds: 2),
              ));
            }
          }, child: BlocBuilder<TablesBloc, TableState>(
            builder: (context, state) {
              if (state is TableAdding) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TableError) {
                return const Center(child: Text("Error"));
              }
              return const HomePage();
            },
          ))),
    );
  }
}
