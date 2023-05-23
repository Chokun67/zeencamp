import 'package:flutter/material.dart';
import 'package:zeencamp/Authentication/login.dart';
import 'package:zeencamp/background.dart';

class SettingShop extends StatelessWidget {
  const SettingShop({super.key});

  TextStyle styleSetting(heightsize) => TextStyle(
            color: const Color(0xFFFFFFFF),
            fontSize: heightsize * 0.035,
            fontWeight: FontWeight.bold,
          );

  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height;
    final widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MyStyle().titleBackground(widthsize, heightsize, context),
            Column(
              children: [
                titleSetting(widthsize, heightsize),
                deTail(widthsize, heightsize,context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget titleSetting(widthsize, heightsize) => SizedBox(
        height: heightsize * 0.175,
        child: Center(
          child: Text("การตั้งค่า", style: MyStyle().styleTitle(heightsize)),
        ),
      );

  Widget deTail(widthsize, heightsize,context) => Container(
        padding: EdgeInsets.only(top: heightsize * 0.1),
        height: heightsize * 0.5,
        child: Column(children: [
          detailAccount(widthsize, heightsize),
          detailPolicy(widthsize, heightsize),
          detailLogout(widthsize, heightsize,context)
        ]),
      );

  Widget detailAccount(widthsize, heightsize) => InkWell(
    onTap: (){},
    child: Container(
          padding: EdgeInsets.only(left: widthsize * 0.1),
          alignment: Alignment.centerLeft,
          width: widthsize,
          height: heightsize * 0.1,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.black),
              bottom: BorderSide(color: Colors.black),
            ),
          ),
          child: Text(
            "การจัดการบัญชี",
            style: styleSetting(heightsize),
          ),
        ),
  );

  Widget detailPolicy(widthsize, heightsize) => InkWell(
    onTap: (){},
    child: Container(
          padding: EdgeInsets.only(left: widthsize * 0.1),
          alignment: Alignment.centerLeft,
          width: widthsize,
          height: heightsize * 0.1,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black),
            ),
          ),
          child: Text(
            "ข้อกำหนดและนโยบาย",
            style: styleSetting(heightsize),
          ),
        ),
  );

  Widget detailLogout(widthsize, heightsize,context) => InkWell(
    onTap: (){Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Loginpage()),
      (route) => false,
    );},
    child: Container(
          padding: EdgeInsets.only(left: widthsize * 0.1),
          alignment: Alignment.centerLeft,
          width: widthsize,
          height: heightsize * 0.1,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black),
            ),
          ),
          child: Text(
            "ออกจากระบบ",
            style: styleSetting(heightsize),
          ),
        ),
  );
}
