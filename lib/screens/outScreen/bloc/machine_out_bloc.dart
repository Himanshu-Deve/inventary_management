import 'package:bloc/bloc.dart';
import 'package:inventory_management/models/users_response_model.dart';
import 'package:inventory_management/models/state_model_response.dart';
import 'package:inventory_management/repository/machine_in_out_repo.dart';

part 'machine_out_event.dart';
part 'machine_out_state.dart';

class MachineOutBloc extends Bloc<MachineOutEvent, MachineOutState> {
  final repo = MachineInOutRepo();

  MachineOutBloc() : super(MachineOutState.initial()) {
    on<LoadStatesOutEvent>(_loadStates);
    on<LoadEmployeesOutEvent>(_loadUsers);
    on<SearchUserOutEvent>(_localSearch);
    on<ChangeStateOutEvent>(_changeState);
    on<SaveDataOutEvent>(_saveData);
  }

  // LOAD STATES ONLY ONCE
  Future<void> _loadStates(
      LoadStatesOutEvent event, Emitter<MachineOutState> emit) async {
    emit(state.copyWith(statesLoading: true));

    final res = await repo.stateApi(0);

    emit(state.copyWith(
      statesLoading: false,
      states: res,
    ));
  }

  // CALL API ONCE — GET ALL USERS
  Future<void> _loadUsers(
      LoadEmployeesOutEvent event, Emitter<MachineOutState> emit) async {
     add(LoadStatesOutEvent());
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final users = await repo.usersApi(
        page: 0,
        state: state.selectedStateId,
        query: "",
      );

      final list = users.data ?? [];

      emit(state.copyWith(
        isLoading: false,
        originalUsers: list,
        allUsers: list,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  // LOCAL SEARCH (FAST)
  Future<void> _localSearch(
      SearchUserOutEvent event, Emitter<MachineOutState> emit) async {

    final q = event.query.trim().toLowerCase();

    final filtered = state.originalUsers.where((u) {
      final name = u.name?.toLowerCase() ?? "";
      final mobile = u.mobileNo ?? "";

      return name.contains(q) || mobile.contains(q);
    }).toList();

    emit(state.copyWith(
      searchQuery: q,
      allUsers: filtered,
    ));
  }

  // STATE CHANGE -> CALL API AGAIN
  Future<void> _changeState(
      ChangeStateOutEvent event, Emitter<MachineOutState> emit) async {

    emit(state.copyWith(
      selectedStateId: event.stateId,
    ));

    add(LoadEmployeesOutEvent());
  }


  Future<void> _saveData(
      SaveDataOutEvent event, Emitter<MachineOutState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final location = await repo.getUserLocations(userId: event.userId);
      final product = await repo.bulkTransferBySerial(serials: event.item,location:location.location?.id??0,notes:"OUT Source" );
      if(product['success']==true && ((product['failed_count']??0)<0)) {
        emit(state.copyWith(
          isLoading: false,
          saveSuccess: "Successfully Added",
          error: null,
        ));
      }else{
        emit(state.copyWith(
          isLoading: false,
          saveSuccess:"Successfully Added But these are Already in Inventary ${product['failed_serials']}",
          error: null,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }


}
