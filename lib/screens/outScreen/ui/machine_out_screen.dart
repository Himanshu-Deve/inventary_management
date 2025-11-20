import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management/navigator/my_routes.dart';
import 'package:inventory_management/screens/outScreen/bloc/machine_out_bloc.dart';
import 'package:inventory_management/widgets/my_primary_textfield.dart';

class MachineOutScreen extends StatefulWidget {
  const MachineOutScreen({super.key});

  @override
  State<MachineOutScreen> createState() => _MachineOutScreenState();
}

class _MachineOutScreenState extends State<MachineOutScreen> {
  late final MachineOutBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = MachineOutBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Machine OUT"),
      ),
      body: _EmployeeBody(bloc: bloc),
    );
  }
}

class _EmployeeBody extends StatefulWidget {
  final MachineOutBloc bloc;
  const _EmployeeBody({super.key, required this.bloc});

  @override
  State<_EmployeeBody> createState() => _EmployeeBodyState();
}

class _EmployeeBodyState extends State<_EmployeeBody> {
  final TextEditingController searchController = TextEditingController();

  late final MachineOutBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = widget.bloc;

  }

  @override
  Widget build(BuildContext context) {
   bloc.add(LoadEmployeesOutEvent());
    return Column(
      children: [
        const SizedBox(height: 16),

        // ⭐ SEARCH + BUTTON
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: MyPrimaryTextField(
                  controller: searchController,
                  onChanged: (value) {
                    bloc.add(SearchUserOutEvent(value.trim())); // 🔥 LIVE SEARCH
                  },
                   hintText: "Search by name or number",
                  prefixIcon: Icons.search_outlined,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ⭐ STATE DROPDOWN
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<MachineOutBloc, MachineOutState>(
            bloc: bloc,
            builder: (context, state) {
              if (state.statesLoading) {
                return const LinearProgressIndicator();
              }

              final stateList = state.states.data ?? [];

              return DropdownButtonHideUnderline(
                child: DropdownButton2<int>(
                  isExpanded: true,
                  hint: const Text("Select State"),

                  value: stateList.any((e) => e.id == state.selectedStateId)
                      ? state.selectedStateId
                      : null,

                  items: stateList
                      .map((s) => DropdownMenuItem(
                    value: s.id?.toInt(),
                    child: Text(s.name ?? ""),
                  ))
                      .toList(),

                  onChanged: (v) {
                    if (v != null) {
                      bloc.add(ChangeStateOutEvent(v));
                    }
                  },

                  buttonStyleData: ButtonStyleData(
                    height: 55,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade400)),
                  ),

                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              );
            },
          )
        ),

        const SizedBox(height: 16),

        Expanded(
          child: BlocBuilder<MachineOutBloc, MachineOutState>(
            bloc: bloc,
            builder: (_, state) {
              if (state.isLoading && state.allUsers.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.error != null) {
                return Center(child: Text("Error: ${state.error}"));
              }

              if (state.allUsers.isEmpty) {
                return const Center(child: Text("No users found"));
              }

              return ListView.builder(
                itemCount: state.allUsers.length,
                itemBuilder: (_, i) {
                  final u = state.allUsers[i];

                  return GestureDetector(
                    onTap: (){
                      context.push(
                        MyRoutes.scannerScreen,
                        extra: {
                          "bloc": bloc,
                          "isNew": true,
                          "userId": u.id,
                          "number": u.mobileNo,
                          "isMachineIn": false
                        },
                      );
                    },
                    child: Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.blue.shade100,
                              child: Text(
                                u.name != null && u.name!.isNotEmpty
                                    ? u.name![0].toUpperCase()
                                    : '?',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),

                            const SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    u.name ?? "",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${u.stateName ?? ''} (${u.mobileNo ?? ''})",
                                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                                  ),

                                ],
                              ),
                            ),

                            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade600),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );

            },
          ),
        ),
      ],
    );
  }
}
