import 'package:thai_qr_promptpay_scanner/src/pages/decode_page/decode_qr_page.dart';
import 'package:thai_qr_promptpay_scanner/src/pages/home/home_page.dart';
import 'package:thai_qr_promptpay_scanner/src/pages/pages.dart';

import 'package:flutter/cupertino.dart';
import 'package:thai_qr_promptpay_scanner/src/pages/qr_scanner/qr_scanner_page.dart';


class Route{
  static const home = "/home";
  static const qrScanner = "/qr_scanner";
  static const decodePage = "/decodepage";
  static Map<String,WidgetBuilder> getAll()=> _route; //read only

  static final Map<String,WidgetBuilder> _route = {
    home : (context) => HomePage(),
    qrScanner : (context)=>QRPage(),
    decodePage: (context)=>DeCodeQR(result: null,),
  };
}