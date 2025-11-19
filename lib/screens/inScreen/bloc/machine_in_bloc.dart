import 'package:bloc/bloc.dart';
import 'package:inventory_management/config/constant.dart';
import 'package:inventory_management/models/location_model_response.dart';
import 'package:inventory_management/models/product_model_response.dart';
import 'package:inventory_management/repository/machine_in_out_repo.dart';
import 'package:meta/meta.dart';

part 'machine_in_event.dart';
part 'machine_in_state.dart';


class MachineInBloc extends Bloc<MachineInEvent, MachineInState> {
  final MachineInOutRepo repository= MachineInOutRepo();

  MachineInBloc() : super(MachineInState.initial()) {
    on<ProductLoadEvent>(_loadProduct);

    on<SaveDataInNewEvent>(_saveNewData);
    on<SaveDataInExistEvent>(_saveExistData);
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

  Future<void> _saveNewData(
      SaveDataInNewEvent event, Emitter<MachineInState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final items = event.items;
      await repository.createInventreeStock(items: items);
     emit(state.copyWith(
          isLoading: false,
          saveSuccess:"Successfully Added!",
          error: null,
        ));

    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _saveExistData(
      SaveDataInExistEvent event, Emitter<MachineInState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final product = await repository.bulkTransferBySerial(serials:event.item,location:7,notes: "IN Source");
     if(product['success']==true && (product['failed_count']==0)) {
       emit(state.copyWith(
         isLoading: false,
         saveSuccess:  "Successfully Added",
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
