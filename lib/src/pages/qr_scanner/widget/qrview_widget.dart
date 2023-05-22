// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// class QRViewWidget extends StatefulWidget {
//   QRViewWidget({Key? key, required this.controller, required this.result,required this.qrKey}) : super(key: key);
//   late QRViewController controller;
//   final GlobalKey qrKey;
//   late Barcode result;
//   @override
//   State<QRViewWidget> createState() => _QRViewWidgetState();
// }
//
// class _QRViewWidgetState extends State<QRViewWidget> {
//   @override
//   Widget build(BuildContext context) {
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//         MediaQuery.of(context).size.height < 400)
//         ? 150.0
//         : 300.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: widget.qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }
//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       widget.controller = widget.controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         widget.result = scanData;
//       });
//     });
//   }
//
//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('no Permission')),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     widget.controller?.dispose();
//     super.dispose();
//   }
// }
