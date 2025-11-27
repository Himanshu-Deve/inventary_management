
import 'package:flutter/material.dart';
import 'package:inventory_management/screens/inScreen/bloc/machine_in_bloc.dart';
import 'package:inventory_management/screens/outScreen/bloc/machine_out_bloc.dart';
import 'package:inventory_management/widgets/my_primary_button.dart';
import 'package:inventory_management/widgets/my_primary_textfield.dart';

class ScanListingScreen extends StatefulWidget {
  final bloc;
  final int? selectId;
  final bool? isNew;
  final List<String> list;
  final int? userId;
  final Function(String) onRemove;

  const ScanListingScreen({
    super.key,
    required this.bloc,
    required this.list,
    required this.onRemove,
    this.userId,
    this.isNew,
    this.selectId,
  });

  @override
  State<ScanListingScreen> createState() => _ScanListingScreenState();
}

class _ScanListingScreenState extends State<ScanListingScreen> {
  final TextEditingController searchController = TextEditingController();

  final String hintText = "Enter serial number";
// Inside _ScanListingScreenState
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    // Keep the field focused after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    searchController.dispose();
    super.dispose();
  }
  void _addItem(String value) {
    final trimmed = value.trim();
    if (trimmed.isNotEmpty && !widget.list.contains(trimmed)) {
      setState(() {
        widget.list.insert(0, trimmed);  // NEWEST FIRST
        searchController.clear();
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Scanned Devices",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      body: Column(
        children: [
          // MyPrimaryTextField with Enter key handling
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: MyPrimaryTextField(
              controller: searchController,
              focusNode: _focusNode,
              readOnly: false,
              onTap: () {
                _focusNode.requestFocus(); // keep focus on tap
              },
              onSubmitted: (value) {
                _addItem(value);
              },
              hintText: hintText,
              prefixIcon: Icons.qr_code_scanner,
              keyboardType: TextInputType.none,
            ),
          ),


          Expanded(
            child: widget.list.isEmpty
                ? const Center(
              child: Text(
                "No items scanned yet",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              itemCount: widget.list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = widget.list[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.blue.shade50,
                      child: Text(
                        "${index + 1}",   // COUNTING
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    title: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        widget.onRemove(item);
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: MyPrimaryButton(
          text: "Submit",
          width: double.infinity,
          onPressed: () async {
            if (widget.userId != null && widget.isNew == true) {
              await widget.bloc.add(SaveDataOutEvent(
                userId: widget.userId ?? 0,
                item: widget.list.toList(),
              ));
            } else if (widget.userId == null && widget.isNew == false) {
              await widget.bloc.add(SaveDataInExistEvent(
                item: widget.list.toList(),
              ));
            } else {
              final baseItem = {
                "part": widget.selectId,
                "quantity": 1,
                "location": 7,
                "status": 10,
                "purchase_price_currency": "INR",
              };

              final items = widget.list.map((serial) {
                return {
                  ...baseItem,
                  "serial": serial,
                };
              }).toList();

              await widget.bloc.add(SaveDataInNewEvent(items: items));
            }
            widget.list.clear();
            setState(() {});
          },
        ),
      ),
    );
  }
}
