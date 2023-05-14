import 'package:flutter/material.dart';

class Tranfer extends StatefulWidget {
  const Tranfer({super.key});

  @override
  State<Tranfer> createState() => _TranferState();
}

class _TranferState extends State<Tranfer> {
  final _ctrlToID = TextEditingController();
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
                  formTranfer(widthsize, heightsize),
                ],
              ),
            ),
            Positioned(
                top: widthsize * 0.077,
                left: widthsize * 0.077,
                child: InkWell(
                    onTap: () =>Navigator.pop(context),
                    child: Image.asset('images/back.png'))),
            Positioned(
                bottom: widthsize * 0.2,
                right: widthsize * 0.045,
                child: Image.asset('images/correct.png')),
          ],
        )),
      ),
    );
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
                Text("USER ID 3104",
                    style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontSize: heightsize * 0.025,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: heightsize * 0.04,
                ),
                Text("25 Point",
                    style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontSize: heightsize * 0.05,
                        fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      ));

  Widget formTranfer(widthsize, heightsize) => Padding(
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
        controller: _ctrlToID,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            fillColor: const Color(0xFFD9D9D9),
            filled: true),
      );

  Widget fieldAmount(widthsize, heightsize) => TextField(
        controller: _ctrlToID,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            fillColor: const Color(0xFFD9D9D9),
            filled: true),
      );
}
