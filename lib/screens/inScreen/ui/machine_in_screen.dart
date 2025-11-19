import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management/navigator/my_routes.dart';
import 'package:inventory_management/utils/app_utils.dart';
import 'package:inventory_management/widgets/mobil_scanner_screen.dart';
import 'package:inventory_management/widgets/my_primary_button.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../bloc/machine_in_bloc.dart';

class MachineInScreen extends StatefulWidget {
  const MachineInScreen({super.key});

  @override
  State<MachineInScreen> createState() => _MachineInScreenState();
}

class _MachineInScreenState extends State<MachineInScreen> {
  late final MachineInBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = MachineInBloc();
    bloc.add(ProductLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Machine IN"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          bottom: const TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "New"),
              Tab(text: "Exist"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProductDropdownScreen(
              bloc: bloc,
            ),
            MachineScannerScreen(
              isNew: false,
              isMachineIn: true,
              bloc: bloc,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDropdownScreen extends StatefulWidget {
  final MachineInBloc bloc;

  const ProductDropdownScreen({super.key, required this.bloc});

  @override
  State<ProductDropdownScreen> createState() => _ProductDropdownScreenState();
}

class _ProductDropdownScreenState extends State<ProductDropdownScreen> {
  int? selectedProductId;
  final MobileScannerController controller = MobileScannerController();
  bool torchOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<MachineInBloc, MachineInState>(
          listener: (context , state )async{

          },
          bloc: widget.bloc,
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(
                child: Text(state.error!,
                    style: const TextStyle(color: Colors.red)),
              );
            }

            final products = state.productModelResponse.data ?? [];

            if (products.isEmpty) {
              return const Center(child: Text("No products found"));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Select Product Category",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                DropdownButtonFormField2<int>(
                  value: selectedProductId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  hint: const Text("Choose a category"),
                  buttonStyleData: const ButtonStyleData(height: 20),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 250, // ⬅ LIMIT HEIGHT
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    height: 40, // ⬅ height for each item
                  ),
                  items: products
                      .map((item) => DropdownMenuItem(
                            value: item.id?.toInt(),
                            child: Text(item.name ?? ""),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => selectedProductId = value);
                  },
                ),

                const SizedBox(height: 20),
                // if (selectedProductId != null)
                //   Text("Selected Product ID: $selectedProductId",
                //       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                if (selectedProductId != null)
                  MyPrimaryButton(
                    text: "QR Scanner",
                    onPressed: () {
                      context.push(
                        MyRoutes.scannerScreen,
                        extra: {"bloc": widget.bloc,"isMachineIn":true,"isNew": true,"selectId":selectedProductId},
                      );
                    },
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: Colors.teal,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
