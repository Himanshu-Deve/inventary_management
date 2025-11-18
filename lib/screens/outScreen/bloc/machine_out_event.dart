part of 'machine_out_bloc.dart';

abstract class MachineOutEvent {}

class LoadStatesOutEvent extends MachineOutEvent {}

class LoadEmployeesOutEvent extends MachineOutEvent {
  final bool loadMore;
  LoadEmployeesOutEvent({this.loadMore = false});
}

class SearchUserOutEvent extends MachineOutEvent {
  final String query;
  SearchUserOutEvent(this.query);
}

class ChangeStateOutEvent extends MachineOutEvent {
  final int stateId;
  ChangeStateOutEvent(this.stateId);
}
