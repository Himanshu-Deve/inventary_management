part of 'machine_in_bloc.dart';


abstract class MachineInEvent {}

class ProductLoadEvent extends MachineInEvent {}
class SaveDataInExistEvent extends MachineInEvent {
  List<String> items;
  SaveDataInExistEvent({required this.items});
}
class SaveDataInNewEvent extends MachineInEvent {
  final List<Map<String, Object?>> items;
  SaveDataInNewEvent({required this.items});
}

class ChangeCategoryEvent extends MachineInEvent {
  final EmployeeCategory category;
  ChangeCategoryEvent(this.category);
}

class ChangeStateFilterEvent extends MachineInEvent {
  final String state;
  ChangeStateFilterEvent(this.state);
}

