part of 'machine_in_bloc.dart';

enum EmployeeCategory { sh, tl, bde }

abstract class MachineInEvent {}

class LoadEmployeesEvent extends MachineInEvent {}

class ChangeCategoryEvent extends MachineInEvent {
  final EmployeeCategory category;
  ChangeCategoryEvent(this.category);
}

class ChangeStateFilterEvent extends MachineInEvent {
  final String state;
  ChangeStateFilterEvent(this.state);
}

