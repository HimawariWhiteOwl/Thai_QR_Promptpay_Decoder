import 'package:flutter/material.dart';
import 'package:thai_qr_promptpay_scanner/src/config/route.dart' as custom_route;
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
            Navigator.pushNamed(context, custom_route.Route.qrScanner);
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => const QRPage(),
            // ));
          },
          child: const Text('Promptpay'),
        ),
      ),
    );
  }

}
