import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zeencamp/application/tranferService/tranferservice.dart';
import 'package:zeencamp/background.dart';
import 'package:zeencamp/menu/Tranfer/receipt.dart';

import '../../application/accountService/httpmenu.dart';
import '../../domain/pvd_data.dart';

class TranFerQr extends StatefulWidget {
  const TranFerQr({Key? key, required this.point, required this.idstore})
      : super(key: key);
  final int point;
  final String idstore;

  @override
  State<TranFerQr> createState() => _TranFerQrState();
}

class _TranFerQrState extends State<TranFerQr> {
  late Future<Map<String, dynamic>> datapoint;
  var point = 0;
  var pointid = 0;
  var token = "";
  var idAccount = "";
  var idstore = "";
  @override
  void initState() {
    idstore = widget.idstore;
    point = widget.point;
    super.initState();
    token = context.read<AppData>().token;
    idAccount = context.read<AppData>().idAccount;
     AccountDetail().apigetpoint(token).then((value) => setState(() {
          pointid = value.point;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height- MediaQuery.of(context).padding.vertical;
    final widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Stack(
          children: [
            Container(
              width: widthsize,
              height: heightsize,
              color: const Color(0xFF4A4A4A),
              child: Column(
                children: [
                  Container(
                    width: widthsize,
                    height: heightsize * 0.41,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(35)),
                      color: Color(0xFFFFD600),
                    ),
                    child: Column(
                      children: [
                        title(widthsize, heightsize),
                        pointFrom(widthsize, heightsize)
                      ],
                    ),
                  ),
                  formTranFer(widthsize, heightsize),
                ],
              ),
            ),
            Positioned(
                top: widthsize * 0.077,
                left: widthsize * 0.077,
                child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset('images/back.png'))),
            Positioned(
                bottom: widthsize * 0.2,
                right: widthsize * 0.045,
                child: InkWell(
                    onTap: () {
                      showAlertDecide(context,
                          title: 'ยืนยันการโอนบัญชี', content: 'โอนไปยัง $idAccount', okAction: btntranfer);
                    },
                    child: Image.asset('images/correct.png'))),
          ],
        )),
      ),
    );
  }

  void btntranfer() {
    if (pointid > point) {
      TranferService().apiTranfer(idstore, point, token).then((value) => {
            if (value!.code == 200)
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Receipt(
                            idAccount: idAccount,
                            message: value.message,
                            state: value.state,
                            payee: value.payee,
                            date: value.date,
                            point: value.point,
                            balance: value.balance,
                          )),
                )
              }
            else
              {showAlertBox(context, 'แจ้งเตือน', 'ไม่มีไอดีนี้อยู่ในระบบ')}
          });
    } else {
      showAlertBox(context, 'แจ้งเตือน', 'จำนวนเงินไม่เพียงพอ');
    }
  }

  Widget title(widthsize, heightsize) => SizedBox(
      height: heightsize * 0.15,
      child: Column(
        children: [
          SizedBox(
            height: heightsize * 0.045,
          ),
          Text(
            "โอน Point",
            style: TextStyle(
                color: const Color(0xFF4A4A4A),
                fontSize: heightsize * 0.045,
                fontWeight: FontWeight.bold),
          ),
        ],
      ));

  Widget pointFrom(widthsize, heightsize) => Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "   จาก",
            style: TextStyle(
                color: const Color(0xFF4A4A4A),
                fontSize: heightsize * 0.03,
                fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.only(left: 0.1 * widthsize),
            height: heightsize * 0.195,
            width: widthsize * 0.84,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF4A4A4A),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: heightsize * 0.03,
                ),
                Text("USER ID $idAccount",
                    style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontSize: heightsize * 0.025,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: heightsize * 0.04,
                ),
                Text("$pointid Point",
                    style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontSize: heightsize * 0.05,
                        fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      ));

  Widget formTranFer(widthsize, heightsize) => Padding(
        padding: EdgeInsets.all(widthsize * 0.05),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("ไปยัง ID",
              style: TextStyle(
                  color: const Color(0xFFFFFFFF),
                  fontSize: heightsize * 0.03,
                  fontWeight: FontWeight.bold)),
          fieldToID(widthsize, heightsize),
          Text("จำนวน",
              style: TextStyle(
                  color: const Color(0xFFFFFFFF),
                  fontSize: heightsize * 0.03,
                  fontWeight: FontWeight.bold)),
          fieldAmount(widthsize, heightsize),
        ]),
      );

  Widget fieldToID(widthsize, heightsize) => TextField(
        readOnly: true,
        decoration: InputDecoration(
            hintText: idstore,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            fillColor: const Color(0xFFD9D9D9),
            filled: true),
      );

  Widget fieldAmount(widthsize, heightsize) => TextField(
        readOnly: true,
        decoration: InputDecoration(
            hintText: NumberFormat("#,##0").format(point),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            fillColor: const Color(0xFFD9D9D9),
            filled: true),
      );
}
