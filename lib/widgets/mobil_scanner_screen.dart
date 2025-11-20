import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management/navigator/my_routes.dart';
import 'package:inventory_management/screens/inScreen/bloc/machine_in_bloc.dart';
import 'package:inventory_management/screens/outScreen/bloc/machine_out_bloc.dart';
import 'package:inventory_management/widgets/my_primary_button.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vibration/vibration.dart';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CustomScannerView extends StatefulWidget {
  final Function(String code) onDetect;
  final bool isNew;

  const CustomScannerView({super.key, required this.onDetect,required this.isNew});

  @override
  State<CustomScannerView> createState() => _CustomScannerViewState();
}

class _CustomScannerViewState extends State<CustomScannerView> {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  double zoomValue = 0.0;
  Offset? tapPosition;

  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// CAMERA PREVIEW + TAP FOCUS
        GestureDetector(
          onTapDown: (details) {
            setState(() => tapPosition = details.localPosition);

            /// 🔍 Tap-to-focus simulation using zoom
            controller.setZoomScale(0.5);
            Future.delayed(const Duration(milliseconds: 500), () {
              controller.setZoomScale(zoomValue);
            });
          },
          child: MobileScanner(
            controller: controller,
            onDetect: (capture) async {
              if (isProcessing) return;
              isProcessing = true;

              String? finalCode;
              final barcodes = capture.barcodes;

              /// PRIORITY 1 → ALL NON-QR BARCODES
              for (final b in barcodes) {
                if (b.format != BarcodeFormat.qrCode && b.rawValue != null) {
                  finalCode = b.rawValue;
                  break;
                }
              }

              /// PRIORITY 2 → QR CODE (if nothing found)
              finalCode ??= barcodes
                  .where((b) => b.rawValue != null)
                  .map((e) => e.rawValue!)
                  .firstOrNull;

              if (finalCode != null) {
                widget.onDetect(finalCode);
              }

              await Future.delayed(const Duration(milliseconds: 600));
              isProcessing = false;
            },
          ),
        ),

        /// TAP FOCUS CIRCLE INDICATOR
        if (tapPosition != null)
          Positioned(
            left: tapPosition!.dx - 20,
            top: tapPosition!.dy - 20,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 2),
                shape: BoxShape.circle,
              ),
            ),
          ),

        /// ZOOM SLIDER UI
        Positioned(
          bottom: widget.isNew ?? false ? 170 : 40,
          left: 20,
          right: 20,
          child: Card(
            color: Colors.white.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Zoom", style: TextStyle(color: Colors.white)),
                  Slider(
                    min: 0.0,
                    max: 1.0,
                    value: zoomValue,
                    onChanged: (v) {
                      setState(() => zoomValue = v);
                      controller.setZoomScale(v);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class MachineScannerScreen extends StatefulWidget {
  final bloc;
  final bool isMachineIn;
  final bool? isNew;
  final int? selectProduct;
  final int? userId;
  final String? number;

  const MachineScannerScreen({
    super.key,
    required this.bloc,
    required this.isMachineIn,
    this.isNew = false,
    this.number = "",
    this.userId = 0,
    this.selectProduct,
  });

  @override
  State<MachineScannerScreen> createState() => _MachineScannerScreenState();
}

class _MachineScannerScreenState extends State<MachineScannerScreen> {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool torchOn = false;
  final List<String> scannedList = [];
  bool isProcessing = false;

  double zoomValue = 0.0; // 🔍 added

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// CAMERA VIEW
          CustomScannerView(
            isNew:widget.isNew??false,
            onDetect: (capture) async {
              // If STILL null → nothing detected properly
              if (!scannedList.contains(capture)) {
                setState(() => scannedList.add(capture));

                if (await Vibration.hasVibrator() ?? false) {
                  Vibration.vibrate(duration: 150);
                }

                debugPrint("SCANNED CODE: $capture");
              }

              await Future.delayed(const Duration(milliseconds: 600));
              isProcessing = false;
            },

          ),

          /// BLUE BOX
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          /// TOP BUTTONS
          Positioned(
            top: (widget.isNew ?? false) ? 100 : 10,
            left: 0,
            right: 0,
            child: Column(
              children: [
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
                        "selectId": widget.selectProduct,
                        "onRemove": (String value) {
                          setState(() => scannedList.remove(value));
                        },
                        "userId": widget.userId,
                        "bloc": widget.bloc,
                        "isNew": widget.isNew,
                        "isMachineIn": widget.isMachineIn,
                      },
                    );
                  },
                  child: const Text("Listing"),
                ),
              ],
            ),
          ),


          /// BACK BUTTON WHEN isNew = TRUE
          if (widget.isNew ?? false)
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: MyPrimaryButton(
                margin: EdgeInsets.symmetric(horizontal: 20),
                text: "Back To Machine In/Out",
                onPressed: () => context.pop(),
              ),
            ),
        ],
      ),
    );
  }
}

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
          onPressed: ()async {
            if(widget.userId!=null && widget.isNew==true) {
              final items = widget.list.map((serial) {
                return serial;
              }).toList();
              await widget.bloc.add(SaveDataOutEvent(userId: widget.userId??0,item: items));
            }else if(widget.userId==null && widget.isNew==false){
              final items = widget.list.map((serial) {
                return serial;
              }).toList();
                await widget.bloc.add(SaveDataInExistEvent(item: items));
            }else{
              final baseItem = {
                "part": widget.selectId,
                "quantity": 1,
                "location": 7,
                "status": 10,
                "purchase_price_currency": "INR",
                };

              final items = widget.list.map((serial) {
                return {
                  ...baseItem,      // copy all fields
                  "serial": serial, // replace serial only
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
