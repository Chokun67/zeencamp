import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Receipt extends StatelessWidget {
  // const Receipt({super.key});
  const Receipt(
      {Key? key,
      required this.idAccount,
      required this.message,
      required this.state,
      required this.payee,
      required this.date,
      required this.point,
      required this.balance})
      : super(key: key);
  final String idAccount;
  final String message;
  final String state;
  final String payee;
  final String date;
  final int point;
  final int balance;

  TextStyle stylewhite(heightsize) => TextStyle(
      color: const Color(0xFFFFFFFF),
      fontSize: heightsize * 0.02,
      fontWeight: FontWeight.w500);
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
                  height: heightsize * 0.36,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35)),
                    color: Color(0xFFFFD600),
                  ),
                  child: Column(
                    children: [
                      title(widthsize, heightsize),
                      titleReceipt(widthsize, heightsize),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: widthsize * 0.06,
                      top: widthsize * 0.06,
                      right: widthsize * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dateHistory(widthsize, heightsize),
                      getOrGive(widthsize, heightsize),
                      detailTrandfer(widthsize, heightsize),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: widthsize * 0.066,
              left: widthsize * 0.066,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
                iconSize: 30,
              )),
        ],
      )),
    );
  }

  Widget title(widthsize, heightsize) => SizedBox(
      height: heightsize * 0.14,
      child: Column(
        children: [
          SizedBox(
            height: heightsize * 0.045,
          ),
          Text(
            "ใบเสร็จ",
            style: TextStyle(
                color: const Color(0xFF4A4A4A),
                fontSize: heightsize * 0.045,
                fontWeight: FontWeight.bold),
          ),
        ],
      ));

  Widget titleReceipt(widthsize, heightsize) => Container(
        padding: EdgeInsets.only(
            left: 0.06 * widthsize,
            top: 0.05 * widthsize,
            right: 0.04 * widthsize),
        height: heightsize * 0.195,
        width: widthsize * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF4A4A4A),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("USER ID $idAccount",
                style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: heightsize * 0.03,
                    fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("การทำรายการ",
                    style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontSize: heightsize * 0.025,
                        fontWeight: FontWeight.bold)),
                Text(isDeposit(state)?"+${point.toString()}":point.toString(),
                    style: TextStyle(
                        color: isDeposit(state)?const Color(0xFF2CC14D):const Color(0xFFEB3F3F),
                        fontSize: heightsize * 0.03,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("ยอดคงเหลือ",
                    style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontSize: heightsize * 0.025,
                        fontWeight: FontWeight.bold)),
                Text(NumberFormat("#,##0").format(balance),
                    style: TextStyle(
                        color: const Color(0xFF2CC14D),
                        fontSize: heightsize * 0.03,
                        fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      );

  Widget dateHistory(widthsize, heightsize) => Container(
      padding: EdgeInsets.only(left: widthsize * 0.05),
      child: Text(
        date,
        style: const TextStyle(color: Color(0xFFFFFFFF)),
      ));

  Widget getOrGive(widthsize, heightsize) => Container(
        padding: EdgeInsets.only(
            left: widthsize * 0.05,
            bottom: widthsize * 0.02,
            top: widthsize * 0.03),
        child: Text(isDeposit(state)?"รับ Point":"โอน Point",
            style: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontSize: heightsize * 0.03,
                fontWeight: FontWeight.bold)),
      );

  Widget detailTrandfer(widthsize, heightsize) => Container(
        height: heightsize * 0.4,
        width: widthsize * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFA6A6A6),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(widthsize * 0.04),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "จากบัญชี",
                      style: stylewhite(heightsize),
                    ),
                    Text(
                      "USER ID $idAccount",
                      style: stylewhite(heightsize),
                    )
                  ]),
            ),
            Container(
              padding: EdgeInsets.all(widthsize * 0.04),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ไปยัง",
                      style: stylewhite(heightsize),
                    ),
                    Text(
                      payee,
                      style: stylewhite(heightsize),
                    )
                  ]),
            ),
            Container(
              width: widthsize * 0.78,
              margin: EdgeInsets.only(
                  top: widthsize * 0.04, bottom: widthsize * 0.04),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(widthsize * 0.04),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "จำนวนเงิน",
                      style: stylewhite(heightsize),
                    ),
                    Text(
                      NumberFormat("#,##0").format(point),
                      style: stylewhite(heightsize),
                    )
                  ]),
            )
          ],
        ),
      );

  bool isDeposit(String state) {
    return state == "deposit";
  }
}
