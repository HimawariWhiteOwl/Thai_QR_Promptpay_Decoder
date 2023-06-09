import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:thai_qr_promptpay_scanner/src/pages/decode_page/decode_bot_formate_page.dart';
import 'package:thai_qr_promptpay_scanner/src/pages/decode_page/decode_qr_promptpay_page.dart';
import 'package:thai_qr_promptpay_scanner/src/pages/qr_scanner/widget/scan_qr_code_widget.dart';
import 'package:vibration/vibration.dart';

class QRPage extends StatefulWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  // void initState() {
  //   controller!.resumeCamera();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    controller?.resumeCamera();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: readQR(context),
            ),
          )
        ],
      ),
    );
  }

  Widget readQR(BuildContext context) {
    // controller?.resumeCamera();
    if (result != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigator.pushNamed(context, custom_route.Route.decodePage);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DeCodeQRPromptPay(
                            result: result!,
                            controller: controller,
                          )));
            },
            child: Text("Check Data"),
          ),
          ScanQRCodeWidget(
            controller: controller,
          ),
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text('Scan a code'),
        ScanQRCodeWidget(
          controller: controller,
        ),
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 500.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() async {
        await controller.resumeCamera();
        result = scanData;
        if (result != null) {
          String? QRRawData = result!.code!;
          print(QRRawData);
          print(QRRawData.length);
          Vibration.vibrate();
          await controller.pauseCamera();
          if (QRRawData.length > 62 && QRRawData.substring(0, 6) == "000201") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DeCodeQRPromptPay(result: result!, controller: controller)));
          } else if (QRRawData.length <= 65 &&
              QRRawData.substring(0, 1) == "|") { //lenght include "\r"
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DeCodeNPMSFormate(result: result!, controller: controller)));
          }
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
