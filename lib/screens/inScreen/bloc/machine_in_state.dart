part of 'machine_in_bloc.dart';

class MachineInState {
  final ProductModelResponse productModelResponse;
  final EmployeeCategory selectedCategory;
  final String selectedState;
  final bool isLoading;
  final List<EmployeeModel> employees;
  final String? error;

  MachineInState({
    required this.productModelResponse,
    required this.selectedCategory,
    required this.selectedState,
    required this.isLoading,
    required this.employees,
    this.error,
  });

  factory MachineInState.initial() {
    return MachineInState(
      productModelResponse: ProductModelResponse(),
      selectedCategory: EmployeeCategory.sh,
      selectedState: "All",
      isLoading: false,
      employees: [],
    );
  }

  MachineInState copyWith({
    ProductModelResponse? productModelResponse,
    EmployeeCategory? selectedCategory,
    String? selectedState,
    bool? isLoading,
    List<EmployeeModel>? employees,
    String? error,
  }) {
    return MachineInState(
      productModelResponse: productModelResponse ?? this.productModelResponse,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedState: selectedState ?? this.selectedState,
      isLoading: isLoading ?? this.isLoading,
      employees: employees ?? this.employees,
      error: error,
    );
  }
}
