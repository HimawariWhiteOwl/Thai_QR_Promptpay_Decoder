import 'package:flutter/material.dart';
import 'package:thai_qr_promptpay_scanner/src/qr_scanner/qr_scanner_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page QR Decoder')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QRPage(),
            ));
          },
          child: const Text('Promptpay'),
        ),
      ),
    );
  }
}
