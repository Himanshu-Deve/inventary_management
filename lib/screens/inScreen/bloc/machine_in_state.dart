part of 'machine_in_bloc.dart';

class MachineInState {
  final ProductModelResponse productModelResponse;
  final EmployeeCategory selectedCategory;
  final String selectedState;
  final bool isLoading;
  final String? saveSuccess;
  final String? error;

  MachineInState({
    required this.productModelResponse,
    required this.selectedCategory,
    required this.selectedState,
    this.saveSuccess,
    required this.isLoading,
    this.error,
  });

  factory MachineInState.initial() {
    return MachineInState(
      productModelResponse: ProductModelResponse(),
      selectedCategory: EmployeeCategory.sh,
      selectedState: "All",
      isLoading: false,
    );
  }

  MachineInState copyWith({
    ProductModelResponse? productModelResponse,
    EmployeeCategory? selectedCategory,
    String? selectedState,
    bool? isLoading,
    String? saveSuccess,
    String? error,
  }) {
    return MachineInState(
      productModelResponse: productModelResponse ?? this.productModelResponse,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedState: selectedState ?? this.selectedState,
      isLoading: isLoading ?? this.isLoading,
      saveSuccess: saveSuccess?? this.saveSuccess,
      error: error,
    );
  }
}
