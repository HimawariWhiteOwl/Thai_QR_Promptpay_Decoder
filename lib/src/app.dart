import 'package:flutter/material.dart';
import 'package:thai_qr_promptpay_scanner/src/pages/home/home_page.dart';
import 'package:thai_qr_promptpay_scanner/src/config/route.dart' as custom_route;
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: custom_route.Route.getAll(),
      title: "Promptpay Decoder",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      // debugShowCheckedModeBanner: false,
    );
  }
}
