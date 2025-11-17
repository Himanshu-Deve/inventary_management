
import '../screens/inScreen/bloc/machine_in_bloc.dart';

class MachineInRepository {
  Future<List<EmployeeModel>> fetchEmployees({
    required EmployeeCategory category,
    required String state,
  }) async {

    await Future.delayed(const Duration(seconds: 1)); // loader simulation

    final data = [
      EmployeeModel(name: "John", state: "Tamil Nadu"),
      EmployeeModel(name: "Arun", state: "Kerala"),
      EmployeeModel(name: "Deepak", state: "Karnataka"),
    ];

    return data.where((e) => state == "All" || e.state == state).toList();
  }
}
