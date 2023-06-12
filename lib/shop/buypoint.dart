import 'package:flutter/material.dart';
import 'package:zeencamp/background.dart';

class BuyPoint extends StatelessWidget {
  const BuyPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height- MediaQuery.of(context).padding.vertical;
    final widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MyStyle().titleBackground(widthsize, heightsize, context),
            Column(
              children: [
                titleBuyPoint(widthsize, heightsize),
                deTail(widthsize, heightsize),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget titleBuyPoint(widthsize, heightsize) => SizedBox(
        height: heightsize * 0.175,
        child: Center(
          child: Text("ซื้อ Point", style: MyStyle().styleTitle(heightsize)),
        ),
      );

  Widget deTail(widthsize, heightsize) => Container(
        padding: EdgeInsets.all(heightsize*0.08),
        height: heightsize*0.5,
        child: Center(child: Text("ติดต่อไลน์ Zeenbootcamp เพื่อซื้อ Point เพิ่ม",style: TextStyle(color: const Color(0xFFFFFFFF),fontSize: heightsize*0.04),),),
      );
}
