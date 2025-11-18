import 'package:bloc/bloc.dart';
import 'package:inventory_management/config/constant.dart';
import 'package:inventory_management/models/employee_model.dart';
import 'package:inventory_management/models/product_model_response.dart';
import 'package:inventory_management/repository/machine_in_out_repo.dart';
import 'package:meta/meta.dart';

part 'machine_in_event.dart';
part 'machine_in_state.dart';


class MachineInBloc extends Bloc<MachineInEvent, MachineInState> {
  final MachineInOutRepo repository= MachineInOutRepo();

  MachineInBloc() : super(MachineInState.initial()) {
    on<ProductLoadEvent>(_loadProduct);

  }

  Future<void> _loadProduct(
      ProductLoadEvent event, Emitter<MachineInState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final product = await repository.productApi();

      emit(state.copyWith(
        isLoading: false,
        productModelResponse: product,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }


}
