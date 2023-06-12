import 'package:flutter/material.dart';
import 'package:zeencamp/application/tranferService/tranferservice.dart';
import 'package:zeencamp/background.dart';
import '../securestorage.dart';

class GivePoint extends StatefulWidget {
  const GivePoint({Key? key, required this.idMenu, required this.pointMenu})
      : super(key: key);

  final String idMenu;
  final int pointMenu;

  @override
  State<GivePoint> createState() => _GivePointState();
}

class _GivePointState extends State<GivePoint> {
  var token = "";
  var hash = "";
  @override
  void initState() {
    super.initState();
    getData().then((_) => TranferService()
        .getHashMenuQrCode(token, widget.idMenu, widget.pointMenu)
        .then((value) => hash = value!));
  }

  Future<void> getData() async {
    token = await SecureStorage().read("token") as String;
  }

  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.vertical;
    final widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MyStyle().titleBackground(widthsize, heightsize, context),
            Column(
              children: [
                titleGivePoint(widthsize, heightsize),
                deTail(widthsize, heightsize),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget titleGivePoint(widthsize, heightsize) => SizedBox(
        height: heightsize * 0.175,
        child: Center(
          child: Text("สแกนเพื่อรับ Point",
              style: MyStyle().styleTitle(heightsize)),
        ),
      );

  Widget deTail(widthsize, heightsize) => Container(
      padding: EdgeInsets.all(heightsize * 0.08),
      height: heightsize * 0.5,
      child: Container());
}
