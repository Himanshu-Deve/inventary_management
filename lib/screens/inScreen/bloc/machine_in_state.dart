part of 'machine_in_bloc.dart';

class MachineInState {
  final EmployeeCategory selectedCategory;
  final String selectedState;
  final bool isLoading;
  final List<EmployeeModel> employees;
  final String? error;

  MachineInState({
    required this.selectedCategory,
    required this.selectedState,
    required this.isLoading,
    required this.employees,
    this.error,
  });

  factory MachineInState.initial() {
    return MachineInState(
      selectedCategory: EmployeeCategory.sh,
      selectedState: "All",
      isLoading: false,
      employees: [],
    );
  }

  MachineInState copyWith({
    EmployeeCategory? selectedCategory,
    String? selectedState,
    bool? isLoading,
    List<EmployeeModel>? employees,
    String? error,
  }) {
    return MachineInState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedState: selectedState ?? this.selectedState,
      isLoading: isLoading ?? this.isLoading,
      employees: employees ?? this.employees,
      error: error,
    );
  }
}
