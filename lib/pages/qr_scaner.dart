// ignore_for_file: use_build_context_synchronously

import 'package:aledit_logistica/constants/colors.dart';
import 'package:aledit_logistica/constants/sized_box.dart';
import 'package:aledit_logistica/functions/navigation_functions.dart';
import 'package:aledit_logistica/widgets/common_alert_dailog.dart';
import 'package:aledit_logistica/widgets/custom_appbar.dart';
import 'package:aledit_logistica/widgets/qr_overlay.dart';
import 'package:aledit_logistica/widgets/round_edged_button.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScaner extends StatefulWidget {
  const QRScaner({Key? key}) : super(key: key);

  @override
  State<QRScaner> createState() => _QRScanerState();
}

class _QRScanerState extends State<QRScaner> {
  MobileScannerController cameraController = MobileScannerController();
  ValueNotifier<bool> scanStatus = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
          context,
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off,
                          color: MyColors.blackColor);
                    case TorchState.on:
                      return const Icon(Icons.flash_on,
                          color: MyColors.primaryColor);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state) {
                    case CameraFacing.front:
                      return const Icon(Icons.camera_front,
                          color: MyColors.blackColor);
                    case CameraFacing.back:
                      return const Icon(
                        Icons.camera_rear,
                        color: MyColors.blackColor,
                      );
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.switchCamera(),
            ),
          ],
        ),
        body: MobileScanner(
          controller: cameraController,
          overlay: QRScannerOverlay(
            overlayColour: Colors.black.withOpacity(0.5),
          ),
          onDetect: (BarcodeCapture barcodes) async {
            await cameraController.stop();
            // barcodes.barcodes.map((e) => print('found the qr code id ${e.displayValue}'));
            showCommonAlertDailog(context,
                headingText: 'Successfully Scanned ',
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundEdgedButton(
                        text: "Rescan",
                        color: MyColors.textFeildFillColor,
                        textColor: MyColors.blackColor,
                        width: 100,
                        height: 40,
                        onTap: () {
                          popPage(context: context);
                          cameraController.start();
                        },
                      ),
                      hSizedBox2,
                      RoundEdgedButton(
                        text: "Done",
                        width: 100,
                        height: 40,
                        onTap: () {
                          popPage(context: context);
                          popPage(context: context);
                        },
                      )
                    ],
                  )
                ],
                message:
                    "The Qr Code is that :- ${barcodes.barcodes[0].displayValue} \nThank you");
            // print(
            //     "found the qr code id ${barcodes.barcodes[0].displayValue}");
          },
        ));
  }
}
