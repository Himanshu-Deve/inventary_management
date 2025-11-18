import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management/navigator/my_routes.dart';
import 'package:inventory_management/widgets/my_primary_button.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vibration/vibration.dart';

class MachineScannerScreen extends StatefulWidget {
  final bloc;
  final bool isMachineIn;
  final bool? isNew;
  final int? selectProduct;
  final int? userId;
  final String? number;

  const MachineScannerScreen(
      {super.key, required this.bloc, required this.isMachineIn,this.isNew = false,this.number="",this.userId=0,this.selectProduct});

  @override
  State<MachineScannerScreen> createState() => _MachineScannerScreenState();
}

class _MachineScannerScreenState extends State<MachineScannerScreen> {
  final MobileScannerController controller = MobileScannerController();
  bool torchOn = false;

  final List<String> scannedList = [];
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// CAMERA SCANNER
          MobileScanner(
            controller: controller,
            onDetect: (capture) async {
              if (isProcessing) return;
              isProcessing = true;

              final code = capture.barcodes.first.rawValue;
              if (code != null) {
                /// Add to list
                if (!scannedList.contains(code)) {
                  setState(() => scannedList.add(code));

                  /// Vibrate device
                  if (await Vibration.hasVibrator() ?? false) {
                    Vibration.vibrate(duration: 200);
                  }

                  debugPrint("SCANNED: $code");
                }
              }

              await Future.delayed(const Duration(milliseconds: 600));
              isProcessing = false;
            },
          ),

          /// BLUE SCAN BOX
          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          /// BOTTOM BUTTONS
          Positioned(
            top: (widget.isNew ?? false) ? 100 : 10,
            left: 0,
            right: 0,
            child: Column(
              children: [
                /// Torch + Scan Text + Camera Switch
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      color: Colors.white,
                      iconSize: 30,
                      icon: Icon(torchOn ? Icons.flash_on : Icons.flash_off),
                      onPressed: () async {
                        await controller.toggleTorch();
                        setState(() => torchOn = !torchOn);
                      },
                    ),
                    Text(
                      "Scanned: ${scannedList.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      color: Colors.white,
                      iconSize: 30,
                      icon: const Icon(Icons.cameraswitch_rounded),
                      onPressed: () => controller.switchCamera(),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                /// LISTING BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 14,
                    ),
                  ),
                  onPressed: () {
                    context.push(
                      MyRoutes.scanListingScreen,
                      extra: {
                        "list": scannedList,
                        "selectId":widget.selectProduct,
                        "onRemove": (String value) {
                          setState(() => scannedList.remove(value));
                        },
                      },
                    );
                  },
                  child: const Text("Listing"),
                ),
              ],
            ),
          ),
          if(widget.isNew??false)
            Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: MyPrimaryButton(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    text: "Back To Machine In", onPressed: () => context.pop()))
        ],
      ),
    );
  }
}

class ScanListingScreen extends StatefulWidget {
  final int? selectId;
  final List<String> list;
  final Function(String) onRemove;

  const ScanListingScreen({
    super.key,
    required this.list,
    required this.onRemove,
    this.selectId,
  });

  @override
  State<ScanListingScreen> createState() => _ScanListingScreenState();
}

class _ScanListingScreenState extends State<ScanListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Scanned Devices",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      /// BODY
      body: widget.list.isEmpty
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

      /// SUBMIT BUTTON FIXED AT BOTTOM
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: MyPrimaryButton(
          text: "Submit",
          width: double.infinity,
          onPressed: () {
            // Handle submit logic here
          },
        ),
      ),
    );
  }
}
