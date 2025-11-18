part of 'machine_out_bloc.dart';

class MachineOutState {
  final bool statesLoading;
  final StateModelResponse states;

  final bool isLoading;

  final int? selectedStateId;

  final List<UsersData> originalUsers; // master list (all users)
  final List<UsersData> allUsers;      // filtered list shown in UI

  final String searchQuery;

  final String? error;

  MachineOutState({
    required this.statesLoading,
    required this.states,
    required this.isLoading,
     this.selectedStateId,
    required this.originalUsers,
    required this.allUsers,
    required this.searchQuery,
    this.error,
  });

  factory MachineOutState.initial() {
    return MachineOutState(
      statesLoading: false,
      states: StateModelResponse(),
      isLoading: false,
      selectedStateId: null,
      originalUsers: [],
      allUsers: [],
      searchQuery: "",
      error: null,
    );
  }

  MachineOutState copyWith({
    bool? statesLoading,
    StateModelResponse? states,
    bool? isLoading,
    int? selectedStateId,
    List<UsersData>? originalUsers,
    List<UsersData>? allUsers,
    String? searchQuery,
    String? error,
  }) {
    return MachineOutState(
      statesLoading: statesLoading ?? this.statesLoading,
      states: states ?? this.states,
      isLoading: isLoading ?? this.isLoading,
      selectedStateId: selectedStateId ?? this.selectedStateId,
      originalUsers: originalUsers ?? this.originalUsers,
      allUsers: allUsers ?? this.allUsers,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error,
    );
  }
}
