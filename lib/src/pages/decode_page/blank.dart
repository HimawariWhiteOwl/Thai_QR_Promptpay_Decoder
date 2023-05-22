import 'package:flutter/material.dart';
import 'package:thai_qr_promptpay_scanner/src/pages/qr_scanner/qr_scanner_page.dart';

class BlankPage extends StatefulWidget {
  const BlankPage({Key? key}) : super(key: key);

  @override
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blank Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QRPage(),
            ));
          },
          child: const Text('Balnk'),
        ),
      ),
    );
  }
}
