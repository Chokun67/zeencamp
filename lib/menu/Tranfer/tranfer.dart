import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zeencamp/application/tranferService/tranferservice.dart';
import 'package:zeencamp/background.dart';
import 'package:zeencamp/menu/Tranfer/receipt.dart';

import '../../application/accountService/httpmenu.dart';
import '../../securestorage.dart';

class TranFer extends StatefulWidget {
  const TranFer({super.key});

  @override
  State<TranFer> createState() => _TranFerState();
}

class _TranFerState extends State<TranFer> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlToID = TextEditingController();
  final _ctrlAmount = TextEditingController();
  late Future<Map<String, dynamic>> datapoint;
  var pointid = 0;
  var token = "";
  var idAccount = "";
  @override
  void initState() {
    super.initState();
    getData().then((_) {
      AccountDetail().apigetpoint(token).then((value) => setState(() {
            pointid = value.point;
          }));
    });
  }

  Future<void> getData() async {
    token = await SecureStorage().read("token") as String;
    idAccount = await SecureStorage().read("idAccount") as String;
  }

  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height;
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
                      if (_formKey.currentState!.validate()) {
                        if (int.parse(_ctrlAmount.text) < pointid) {
                          TranferService()
                              .apiValidateTranfer(_ctrlToID.text, token)
                              .then((value) => {
                                    if (value != null)
                                      {
                                        showAlertDecide(context,
                                            title: 'ยืนยันการโอนบัญชี',
                                            content:
                                                'โอนไปยัง ชื่อผู้ใช้ ${value.payee} \n idผู้ใช้ ${_ctrlToID.text}\n จำนวน ${_ctrlAmount.text} Point',
                                            okAction: btntranfer)
                                      }
                                    else
                                      {
                                        showAlertBox(context, 'แจ้งเตือน',
                                            'ไม่มีไอดีนี้ในระบบ')
                                      },
                                  });
                        } else {
                          showAlertBox(
                              context, 'แจ้งเตือน', 'จำนวนเงินไม่เพียงพอ');
                        }
                      }
                    },
                    child: Image.asset('images/correct.png'))),
          ],
        )),
      ),
    );
  }

  void btntranfer() {
    TranferService()
        .apiTranfer(_ctrlToID.text, int.parse(_ctrlAmount.text), token)
        .then((value) => {
              if (value != null)
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
                {showAlertBox(context, 'แจ้งเตือน', 'เกิดข้อผิดพลาดในการโอน')}
            });
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
                Text("${NumberFormat("#,##0").format(pointid)} Point",
                    style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontSize: heightsize * 0.05,
                        fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      ));

  Widget formTranFer(widthsize, heightsize) => Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(widthsize * 0.05),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("ไปยัง ID",
                style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: heightsize * 0.03,
                    fontWeight: FontWeight.bold)),
            SizedBox(
                height: heightsize * 0.1,
                child: fieldToID(widthsize, heightsize)),
            Text("จำนวน",
                style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: heightsize * 0.03,
                    fontWeight: FontWeight.bold)),
            SizedBox(
                height: heightsize * 0.1,
                child: fieldAmount(widthsize, heightsize)),
          ]),
        ),
      );

  Widget fieldToID(widthsize, heightsize) => TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกค่า';
          } else if (
            // value.length != 9 ||
              !RegExp(r'^[0-9]+$').hasMatch(value)) {
            return 'รูปแบบข้อความไม่ถูกต้อง';
          } else if (value == idAccount) {
            return 'ไม่สามารถส่งพ้อยไปยังไอดีต้นทางได้';
          }
          return null;
        },
        keyboardType: TextInputType.number,
        controller: _ctrlToID,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            fillColor: const Color(0xFFD9D9D9),
            filled: true),
      );

  Widget fieldAmount(widthsize, heightsize) => TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกค่า';
          } else if (int.tryParse(value) == null || int.parse(value) <= 0) {
            return 'รูปแบบข้อมูลไม่ถูกต้อง';
          } else if (int.parse(value) > pointid) {
            return 'จำนวนเงินไม่เพียงพอ';
          }
          return null;
        },
        keyboardType: TextInputType.number,
        controller: _ctrlAmount,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            fillColor: const Color(0xFFD9D9D9),
            filled: true),
      );
}
