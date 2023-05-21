import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRCodeWidget extends StatefulWidget {
  const ScanQRCodeWidget({Key? key, required this.controller}) : super(key: key);
  // const ScanQRCodeWidget({Key? key, required this.googleSignIn}) : super(key: key);
  final QRViewController? controller;
  @override
  State<ScanQRCodeWidget> createState() => _ScanQRCodeWidgetState();
}

class _ScanQRCodeWidgetState extends State<ScanQRCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(8),
              child: ElevatedButton(
                  onPressed: () async {
                    await widget.controller?.toggleFlash();
                    setState(() {});
                  },
                  child: FutureBuilder(
                    future: widget.controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      return Text('Flash: ${snapshot.data}');
                    },
                  )),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: ElevatedButton(
                  onPressed: () async {
                    await widget.controller?.flipCamera();
                    setState(() {});
                  },
                  child: FutureBuilder(
                    future: widget.controller?.getCameraInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {

                        return Text(
                            'Camera facing ${describeEnum(snapshot.data!)}');
                      } else {
                        return const Text('loading');
                      }
                    },
                  )),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () async {
                  await widget.controller?.pauseCamera();
                },
                child: const Text('pause',
                    style: TextStyle(fontSize: 20)),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () async {
                  await widget.controller?.resumeCamera();
                },
                child: const Text('resume',
                    style: TextStyle(fontSize: 20)),
              ),
            )
          ],
        ),
      ],
    );
  }
}




//
// Widget buildScanQRcode(){
//   return Column(
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             margin: const EdgeInsets.all(8),
//             child: ElevatedButton(
//                 onPressed: () async {
//                   await controller?.toggleFlash();
//                   setState(() {});
//                 },
//                 child: FutureBuilder(
//                   future: controller?.getFlashStatus(),
//                   builder: (context, snapshot) {
//                     return Text('Flash: ${snapshot.data}');
//                   },
//                 )),
//           ),
//           Container(
//             margin: const EdgeInsets.all(8),
//             child: ElevatedButton(
//                 onPressed: () async {
//                   await controller?.flipCamera();
//                   setState(() {});
//                 },
//                 child: FutureBuilder(
//                   future: controller?.getCameraInfo(),
//                   builder: (context, snapshot) {
//                     if (snapshot.data != null) {
//                       return Text(
//                           'Camera facing ${describeEnum(snapshot.data!)}');
//                     } else {
//                       return const Text('loading');
//                     }
//                   },
//                 )),
//           )
//         ],
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             margin: const EdgeInsets.all(8),
//             child: ElevatedButton(
//               onPressed: () async {
//                 await controller?.pauseCamera();
//               },
//               child: const Text('pause',
//                   style: TextStyle(fontSize: 20)),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.all(8),
//             child: ElevatedButton(
//               onPressed: () async {
//                 await controller?.resumeCamera();
//               },
//               child: const Text('resume',
//                   style: TextStyle(fontSize: 20)),
//             ),
//           )
//         ],
//       ),
//     ],
//   );
// }