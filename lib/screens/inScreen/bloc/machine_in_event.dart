part of 'machine_in_bloc.dart';


abstract class MachineInEvent {}

class ProductLoadEvent extends MachineInEvent {}

class ChangeCategoryEvent extends MachineInEvent {
  final EmployeeCategory category;
  ChangeCategoryEvent(this.category);
}

class ChangeStateFilterEvent extends MachineInEvent {
  final String state;
  ChangeStateFilterEvent(this.state);
}

