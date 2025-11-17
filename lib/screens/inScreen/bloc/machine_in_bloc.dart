import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'machine_in_event.dart';
part 'machine_in_state.dart';


class MachineInBloc extends Bloc<MachineInEvent, MachineInState> {
  final MachineInRepository repository;

  MachineInBloc(this.repository) : super(MachineInState.initial()) {
    on<LoadEmployeesEvent>(_loadEmployees);
    on<ChangeCategoryEvent>(_changeCategory);
    on<ChangeStateFilterEvent>(_changeStateFilter);
  }

  Future<void> _loadEmployees(
      LoadEmployeesEvent event, Emitter<MachineInState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final employees = await repository.fetchEmployees(
        category: state.selectedCategory,
        state: state.selectedState,
      );

      emit(state.copyWith(
        isLoading: false,
        employees: employees,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void _changeCategory(
      ChangeCategoryEvent event, Emitter<MachineInState> emit) {
    emit(state.copyWith(selectedCategory: event.category));
    add(LoadEmployeesEvent());
  }

  void _changeStateFilter(
      ChangeStateFilterEvent event, Emitter<MachineInState> emit) {
    emit(state.copyWith(selectedState: event.state));
    add(LoadEmployeesEvent());
  }
}
