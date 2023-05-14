import 'package:flutter/material.dart';
import 'package:zeencamp/menu/searchtype.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
            color: const Color(0xFFFFD600),
            child: Column(
              children: [
                titleMoney(widthsize, heightsize),
                Container(
                    width: widthsize,
                    height: heightsize * 0.1,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(90)),
                      color: Color(0xFF4A4A4A),
                    ),
                    child: historyTitle(widthsize, heightsize)),
                Container(
                    color: const Color(0xFF4A4A4A),
                    width: widthsize,
                    height: heightsize - heightsize * 0.284 - heightsize * 0.15,
                    child: historyTranfer(widthsize, heightsize, context)),
                Container(
                  color: const Color(0xFF4A4A4A),
                )
              ],
            ),
          ),
          Positioned(
              top: widthsize * 0.055,
              left: widthsize * 0.055,
              child: IconButton(
                onPressed: () {  Navigator.pop(context);},
                icon: const Icon(Icons.arrow_back_ios),
                iconSize: 30,
              )),
          Positioned(
              bottom: 0,
              child: Container(
                width: widthsize,
                height: heightsize * 0.01,
                color: const Color(0xFF4A4A4A),
              ))
        ],
      )),
    );
  }

  Widget titleMoney(widthsize, heightsize) => SizedBox(
      height: heightsize * 0.284,
      child: Column(
        children: [
          SizedBox(
            height: heightsize * 0.09,
          ),
          Container(
            padding: EdgeInsets.all(widthsize * 0.05),
            width: widthsize * 0.843,
            height: heightsize * 0.164,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Color(0xFF4A4A4A),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "จำนวน Point ที่มี",
                  style: TextStyle(
                      color: const Color(0xFFFFD600),
                      fontSize: heightsize * 0.025,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: heightsize * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("5000",
                        style: TextStyle(
                            color: const Color(0xFFFFD600),
                            fontSize: heightsize * 0.06,
                            fontWeight: FontWeight.bold)),
                    Text("P",
                        style: TextStyle(
                            color: const Color(0xFFFFD600),
                            fontSize: heightsize * 0.06,
                            fontWeight: FontWeight.bold))
                  ],
                )
              ],
            ),
          )
        ],
      ));

  Widget historyTitle(widthsize, heightsize) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("History",
              style: TextStyle(
                  color: const Color(0xFFFFFFFF),
                  fontSize: heightsize * 0.05,
                  fontWeight: FontWeight.bold)),
        ],
      );
  int number = 1;
  int money = 10;
  bool mark = true;
  Widget historyTranfer(widthsize, heightsize, context) =>
      SingleChildScrollView(
        child: Column(children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SearchType()));
              },
              child: const Text("Testseach")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  mark = mark ? false : true;
                });
              },
              child: const Text("Login")),
          Column(
            children: [
              buildList(widthsize, heightsize, context),
            ],
          )
        ]),
      );

  Widget buildList(widthsize, heightsize, context) => Column(
        children: [
          ListView.builder(
            itemCount: 7,
            padding: EdgeInsets.all(widthsize * 0.04),
            physics: const ScrollPhysics(parent: null),
            shrinkWrap: true,
            itemBuilder: (BuildContext buildList, int index) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFFFFFFF),
                ),
                margin: EdgeInsets.only(bottom: widthsize * 0.025),
                padding: EdgeInsets.only(
                    bottom: widthsize * 0.02,
                    top: widthsize * 0.02,
                    left: widthsize * 0.07,
                    right: widthsize * 0.06),
                // width: widthsize * 0.87,
                height: heightsize * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("29 เมษ 66 ,17:15",
                            style: TextStyle(fontSize: heightsize * 0.02)),
                        Text(
                          mark ? "ได้รับ Point" : "โอน Point",
                          style: TextStyle(
                              fontSize: heightsize * 0.03,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Text(
                      mark ? "+$money" : "-$money",
                      style: TextStyle(
                          color: mark
                              ? const Color(0xFF2CC14D)
                              : const Color(0xFFEB3F3F),
                          fontSize: heightsize * 0.04,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      );
}
