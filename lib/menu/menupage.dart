import 'package:flutter/material.dart';
import 'package:zeencamp/application/httpmenu.dart';
import 'package:zeencamp/menu/history.dart';
import 'package:zeencamp/menu/qrscaner.dart';
import 'package:zeencamp/menu/searchtype.dart';
import 'package:zeencamp/menu/tranfer.dart';
import 'package:provider/provider.dart';
import 'package:zeencamp/domain/pvd_data.dart';
import 'package:zeencamp/shop/setting.dart';

class Menu extends StatefulWidget {
  // const Menu({Key? key, required this.token}) : super(key: key); ตรงนี้
  const Menu({super.key});
  // final String token; ตรงนี้
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late Future<Map<String, dynamic>> datapoint;
  var pointid = 0;
  var token = "";
  var iduser = "";
  var idname = "";
  var idAccount = "";
  @override
  void initState() {
    super.initState();
    token = context.read<AppData>().token;
    idAccount = context.read<AppData>().idAccount;
    apigetpoint(token).then((value) => setState(() {
          pointid = value.point;
          iduser = value.id;
          idname = value.name;
        }));
  }

  List widgetOptions = [
    const Menu(),
    const TranFer(),
    const HistoryPoint(),
    const SearchType(),
    const QrScaner()
  ];
  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height;
    final widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userinfo(heightsize, widthsize),
                      circlePoint(heightsize, widthsize),
                      settingButton(heightsize, widthsize),
                    ],
                  ),
                )
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: heightsize * 0.018,
        selectedFontSize: heightsize * 0.018,
        iconSize: heightsize * 0.04,
        backgroundColor: const Color(0xFF4A4A4A),
        unselectedItemColor: const Color(0xFFFFD600),
        selectedItemColor: const Color(0xFFFF9900),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'เมนู'),
          BottomNavigationBarItem(
              icon: Icon(Icons.import_export), label: 'โอนพ้อย'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'ประวัติ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.store), label: 'ร้านค้าต่างๆ'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'แสกน QR'),
        ],
        currentIndex: 0,
        onTap: (index) async {
          if (index != 0) {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => widgetOptions[index]));
            setState(() {
              apigetpoint(token).then((value) => setState(() {
                    pointid = value.point;
                  }));
            });
          }
        },
      ),
    );
  }

  Widget userinfo(heightsize, widthsize) => SizedBox(width: widthsize * 0.223);

  Widget circlePoint(heightsize, widthsize) => Container(
      width: heightsize * 0.26,
      height: 300,
      decoration: BoxDecoration(
          color: const Color(0xFFFFF280),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFFF9900), width: 5)),
      child: Center(
          child: Text('$pointid \nPoint',
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingShop()));
              },
            ),
          ],
        ),
      );
}
