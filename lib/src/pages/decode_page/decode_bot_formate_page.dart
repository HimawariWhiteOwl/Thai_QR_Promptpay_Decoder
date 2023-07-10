import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:intl/intl.dart';
class DeCodeNPMSFormate extends StatefulWidget {
  const DeCodeNPMSFormate({Key? key, required this.result, required this.controller})
      : super(key: key);
  final Barcode? result;
  final QRViewController? controller;

  @override
  State<DeCodeNPMSFormate> createState() => _DeCodeNPMSFormateState();
}

class _DeCodeNPMSFormateState extends State<DeCodeNPMSFormate> {
  @override
  Widget build(BuildContext context) {
    // widget.controller!.pauseCamera();
    String QRRawData = widget.result!.code!;
    List<String> TagStringList = ["Prefix", "BillerId", "Reference No.1", "Reference No.2", "Total Amount", "Amount Format"];
    // List<String> LenList = [];
    List<String> DataList = QRRawData.split("\r");
    DataList[0] =  DataList[0].replaceAll("|", "");
    String Amount = "${DataList.last.substring(0,DataList.last.length-2)}.${DataList.last.substring(DataList.last.length-2,DataList.last.length)}";
    // print(Amount);
    DataList.add(NumberFormat.decimalPatternDigits(decimalDigits: 2).format(double.parse(Amount)));
    DataList.insert(0, "|");

    // print(TagIdList);
    // print(LenList);
    // print(DataList);
    // print("Formate: ${widget.result!.format} Code: ${widget.result!.code}");
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Decode BOT Formate'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                widget.controller!.resumeCamera();
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Center(
            child: Card(
              child: Scrollbar(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          // leading: Text(TagIdList[index]),//Icon(Icons.album),
                          title: Text("${TagStringList[index]}"),
                          //${TagIdList[index]}
                          subtitle: Text("lenght: ${DataList[index].length}"),
                          trailing: Text("${DataList[index]}"),
                        ),
                      ],
                    );
                  },
                  itemCount: DataList.length == 0 ? 0 : DataList.length,
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          widget.controller!.resumeCamera();
          return true;
        });
  }
}
