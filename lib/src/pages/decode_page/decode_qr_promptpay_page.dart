import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:thai_qr_promptpay_scanner/src/pages/decode_page/EMVCo-Merchant-Presented-QR-Specification.dart';
class DeCodeQRPromptPay extends StatefulWidget {
  const DeCodeQRPromptPay({Key? key, required this.result, required this.controller})
      : super(key: key);
  final Barcode? result;
  final QRViewController? controller;

  @override
  State<DeCodeQRPromptPay> createState() => _DeCodeQRPromptPayState();
}

class _DeCodeQRPromptPayState extends State<DeCodeQRPromptPay> {
  @override
  Widget build(BuildContext context) {
    // widget.controller!.pauseCamera();
    String QRRawData = widget.result!.code!;
    var TagName = TagMap;
    int index = 0;
    List<String> TagIdList = [];
    List<String> TagStringList = [];
    List<String> LenList = [];
    List<String> DataList = [];
    while (index < QRRawData.length) {
      String TagId = QRRawData.substring(index, index + 2);
      index += 2;
      String StrQRdatalen = QRRawData.substring(index, index + 2);
      index += 2;
      int QRdatalen = int.parse(StrQRdatalen);
      String data = QRRawData.substring(index, index + QRdatalen);
      index += QRdatalen;

      if (TagId == "29" || TagId == "30" || TagId == "31") {
        print("=============== Start Tag ${TagId} ===============");
        // TagIdList.add(TagId);
        // LenList.add(StrQRdatalen);
        // DataList.add(data);
        // TagStringList.add(TagName[TagId]!);
        int indexv2 = 0;
        while (indexv2 < data.length) {
          String TagIdV2 = data.substring(indexv2, indexv2 + 2);
          indexv2 += 2;
          String StrQRdatalen2 = data.substring(indexv2, indexv2 + 2);
          indexv2 += 2;
          int QRdatalen2 = int.parse(StrQRdatalen2);
          String data2 = data.substring(indexv2, indexv2 + QRdatalen2);
          indexv2 += QRdatalen2;
          print("${TagIdV2} ${StrQRdatalen2} ${data2}");
          TagIdList.add("$TagId:$TagIdV2");
          LenList.add(StrQRdatalen2);
          DataList.add(data2);
          if (TagId == "29"){
            TagStringList.add(Tag29Map[TagIdV2]!);
          }
          if(TagId == "30"){
            TagStringList.add(Tag30Map[TagIdV2]!);
          }
          if(TagId == "31"){
            TagStringList.add(Tag31Map[TagIdV2]!);
          }
        }
        print("=============== END Tag ${TagId} ===============");
      } else {
        print("${TagId} ${StrQRdatalen} ${data}");
        TagIdList.add(TagId);
        LenList.add(StrQRdatalen);
        DataList.add(data);
        TagStringList.add(TagName[TagId]!);
      }
    }
    // print(TagIdList);
    // print(LenList);
    // print(DataList);
    // print("Formate: ${widget.result!.format} Code: ${widget.result!.code}");
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Decode QR PromptPay'),
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
                          leading: Text(TagIdList[index]),//Icon(Icons.album),
                          title: Text("${TagStringList[index]}"),
                          //${TagIdList[index]}
                          subtitle: Text("lenght: ${LenList[index]}"),
                          trailing: Text("${DataList[index]}"),
                        ),
                      ],
                    );
                  },
                  itemCount: TagIdList.length == 0 ? 0 : TagIdList.length,
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
