import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_curd_bloc/repository/tables_read.dart';
import '../../../../models/table_model.dart';

part 'table_event.dart';

part 'table_state.dart';

class TablesBloc extends Bloc<TableEvent, TableState> {
  final TablesRepository tablesRepository;
  TablesBloc({required this.tablesRepository}) : super(InitialState()) {
    on<Create>((event, emit) async {
      emit(TableAdding());
      await Future.delayed(const Duration(seconds: 1));
      try {
        await tablesRepository.create(
            tablecapacity: event.tablecapacity, tablename: event.tablename);
        emit(TableAdded());
      } catch (e) {
        emit(TableError(e.toString()));
      }
    });

    on<LoadReadSuccessTable>((event, emit) async {
      emit(TableReadLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
        final data = await tablesRepository.get();

        emit(TableReadLoaded(mytables: data));
      } catch (e) {
        emit(TableError(e.toString()));
      }
    });
  }
}
