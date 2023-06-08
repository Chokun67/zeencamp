import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zeencamp/application/accountService/httpmenu.dart';
import 'package:zeencamp/menu/Tranfer/history.dart';
import 'package:zeencamp/menu/Tranfer/tranfer.dart';
import 'package:zeencamp/shop/buypoint.dart';
import 'package:zeencamp/shop/qrgenerate.dart';
import 'package:zeencamp/shop/setting.dart';

import '../background.dart';
import '../securestorage.dart';

class ShopMenu extends StatefulWidget {
  const ShopMenu({super.key});

  @override
  State<ShopMenu> createState() => _ShopMenuState();
}

class _ShopMenuState extends State<ShopMenu> {
  TextStyle styleBlack(heightsize) => TextStyle(
      color: const Color(0xFF4A4A4A),
      fontSize: heightsize * 0.04,
      fontWeight: FontWeight.bold);

  late Future<Map<String, dynamic>> datapoint;
  var pointid = 0;
  var token = "";
  var iduser = "";
  var idname = "";
  var idAccount = "";
  @override
  void initState() {
    super.initState();
    getData().then((_) {
      fetchpoint();
    });
  }
  Future<void> getData() async {
    token = await SecureStorage().read("token") as String;
    idAccount = await SecureStorage().read("idAccount") as String;
  }
  void fetchpoint() => apigetpoint(token).then((value) => setState(() {
        pointid = value.point;
        iduser = value.id;
        idname = value.name;
      }));

  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height;
    final widthsize = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        showAlertDecide(context,
            title: 'แจ้งเตือน',
            content: 'ยืนยันการออกจากระบบ',
            okAction: logOut);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
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
                    height: heightsize * 0.362,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(90)),
                      color: Color(0xFFFFD600),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: widthsize * 0.223,
                        ),
                        circlePoint(heightsize, widthsize),
                        settingButton(heightsize, widthsize),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(widthsize * 0.1),
                    child: Column(
                      children: [
                        buyPoint(widthsize, heightsize),
                        SizedBox(height: heightsize * 0.04),
                        tranFer(widthsize, heightsize),
                        SizedBox(height: heightsize * 0.04),
                        createQR(widthsize, heightsize),
                        SizedBox(height: heightsize * 0.04),
                        historyPoint(widthsize, heightsize)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: widthsize * 0.04,
                left: widthsize * 0.04,
                child: Column(
                  children: [Text("user: $idname\nid: $idAccount ")],
                ))
          ],
        )),
      ),
    );
  }

  Widget circlePoint(heightsize, widthsize) => Container(
      width: heightsize * 0.26,
      height: 300,
      decoration: BoxDecoration(
          color: const Color(0xFFFFF280),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFFF9900), width: 5)),
      child: Center(
          child: Text('${NumberFormat("#,##0").format(pointid)} \nPoint',
              style: TextStyle(
                  fontSize: heightsize * 0.05, fontWeight: FontWeight.bold))));

  Widget settingButton(widthsize, heightsize) => SizedBox(
        width: widthsize * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: heightsize * 0.03,
            ),
            IconButton(
              icon: Icon(Icons.settings, size: widthsize * 0.043),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingShop()));
                fetchpoint();
              },
            ),
          ],
        ),
      );

  Widget buyPoint(widthsize, heightsize) => InkWell(
        onTap: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BuyPoint()));
          fetchpoint();
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color(0xFFFFFFFF),
          ),
          height: heightsize * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: widthsize * 0.18),
              Text(
                "ซื้อ Point",
                style: styleBlack(heightsize),
              ),
              SizedBox(width: widthsize * 0.05),
              Icon(Icons.add_business_outlined, size: heightsize * 0.06)
            ],
          ),
        ),
      );

  Widget tranFer(widthsize, heightsize) => InkWell(
        onTap: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TranFer()));
          fetchpoint();
        },
        child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color(0xFFFFFFFF),
            ),
            height: heightsize * 0.08,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(width: widthsize * 0.18),
              Text("โอน Point", style: styleBlack(heightsize)),
              SizedBox(width: widthsize * 0.05),
              Icon(Icons.import_export, size: heightsize * 0.06)
            ])),
      );

  Widget createQR(widthsize, heightsize) => InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const QRScreen()));
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color(0xFFFFFFFF),
          ),
          height: heightsize * 0.08,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("สร้าง QR รับเงิน", style: styleBlack(heightsize))
          ]),
        ),
      );

  Widget historyPoint(widthsize, heightsize) => InkWell(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HistoryPoint())),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color(0xFFFFFFFF),
          ),
          height: heightsize * 0.08,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Point History", style: styleBlack(heightsize))]),
        ),
      );

  void logOut() {
    SecureStorage().deleteAll();
    Navigator.pop(context);
  }
}
