import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/machine_in_bloc.dart';

class MachineInScreen extends StatelessWidget {
  const MachineInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      MachineInBloc(MachineInRepository())..add(LoadEmployeesEvent()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Machine IN"),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Company"),
                Tab(text: "Employees"),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              _CompanyTab(),
              _EmployeesTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompanyTab extends StatelessWidget {
  const _CompanyTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Company data will come here"));
  }
}

class _EmployeesTab extends StatelessWidget {
  const _EmployeesTab();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MachineInBloc>();

    return Column(
      children: [
        const SizedBox(height: 12),

        BlocBuilder<MachineInBloc, MachineInState>(
          builder: (_, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _chip("SH's", EmployeeCategory.sh, state, bloc),
                _chip("TL's", EmployeeCategory.tl, state, bloc),
                _chip("BDE's", EmployeeCategory.bde, state, bloc),
              ],
            );
          },
        ),

        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<MachineInBloc, MachineInState>(
            builder: (_, state) {
              return DropdownButtonFormField<String>(
                value: state.selectedState,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "State Filter",
                ),
                items: ["All", "Tamil Nadu", "Kerala", "Karnataka"]
                    .map((s) => DropdownMenuItem(
                  value: s,
                  child: Text(s),
                ))
                    .toList(),
                onChanged: (v) =>
                    bloc.add(ChangeStateFilterEvent(v ?? "All")),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        Expanded(
          child: BlocBuilder<MachineInBloc, MachineInState>(
            builder: (_, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.error != null) {
                return Center(child: Text("Error: ${state.error}"));
              }

              if (state.employees.isEmpty) {
                return const Center(child: Text("No employees found"));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.employees.length,
                itemBuilder: (_, i) {
                  final emp = state.employees[i];
                  return Card(
                    child: ListTile(
                      title: Text(emp.name),
                      subtitle: Text(emp.state),
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }

  Widget _chip(String label, EmployeeCategory category,
      MachineInState state, MachineInBloc bloc) {
    final selected = state.selectedCategory == category;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: Colors.blue,
      onSelected: (_) => bloc.add(ChangeCategoryEvent(category)),
    );
  }
}
