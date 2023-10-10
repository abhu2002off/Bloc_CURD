part of 'table_bloc.dart';

abstract class TableEvent extends Equatable {
  const TableEvent();

  @override
  List<Object> get props => [];
}

class Create extends TableEvent {
  final String tablecapacity;
  final String tablename;

  const Create(this.tablecapacity, this.tablename);
}

class LoadTable extends TableEvent {}

class LoadReadSuccessTable extends TableEvent {
  const LoadReadSuccessTable();
}
