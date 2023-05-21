import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeencamp/application/httpmenu.dart';
import 'package:zeencamp/application/tranferService/tranferservice.dart';
import 'package:zeencamp/domain/historydm.dart';
import 'package:zeencamp/menu/detailtranfer.dart';

import '../domain/pvd_data.dart';

class HistoryPoint extends StatefulWidget {
  const HistoryPoint({super.key});

  @override
  State<HistoryPoint> createState() => _HistoryPointState();
}

class _HistoryPointState extends State<HistoryPoint> {
  List<DepositModel> history = [];
  late Future<Map<String, dynamic>> datapoint;
  var token;
  var pointid;
  var idAccount;
  @override
  void initState() {
    super.initState();
    idAccount = context.read<AppData>().idAccount;
    token = context.read<AppData>().token;
    apigetpoint(token).then((value) => setState(() {
          pointid = value.point;
        }));
    fetchData();
  }

  void fetchData() async {
    token = context.read<AppData>().token;
    List<DepositModel> fetchedStores = await TranferService().getTranfer(token);
    setState(() {
      history = fetchedStores;
    });
  }

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
                    child: historyPointTitle(widthsize, heightsize)),
                Container(
                    color: const Color(0xFF4A4A4A),
                    width: widthsize,
                    height: heightsize - heightsize * 0.284 - heightsize * 0.2,
                    child: historyPointTranfer(widthsize, heightsize, context)),
              ],
            ),
          ),
          Positioned(
              top: widthsize * 0.055,
              left: widthsize * 0.055,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
                iconSize: 30,
              )),
          Positioned(
              bottom: 0,
              child: Container(
                width: widthsize,
                height: heightsize * 0.03,
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
            height: heightsize * 0.166,
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
                    Text("$pointid",
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

  Widget historyPointTitle(widthsize, heightsize) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("HistoryPoint",
              style: TextStyle(
                  color: const Color(0xFFFFFFFF),
                  fontSize: heightsize * 0.05,
                  fontWeight: FontWeight.bold)),
        ],
      );

  Widget historyPointTranfer(widthsize, heightsize, context) =>
      SingleChildScrollView(
        child: Column(children: [
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
            itemCount: history.length,
            padding: EdgeInsets.all(widthsize * 0.04),
            physics: const ScrollPhysics(parent: null),
            shrinkWrap: true,
            itemBuilder: (BuildContext buildList, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailTranfer(
                              idAccount: idAccount,
                              state: history[index].state,
                              payee: history[index].opposite,
                              date: "${history[index].date}",
                              point: history[index].point)));
                },
                child: Container(
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
                  height: heightsize * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${history[index].date}",
                              style: TextStyle(fontSize: heightsize * 0.02)),
                          Text(
                            isDeposit(history, index)
                                ? "ได้รับ Point"
                                : "โอน Point",
                            style: TextStyle(
                                fontSize: heightsize * 0.03,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Text(
                        isDeposit(history, index)
                            ? "+${history[index].point}"
                            : "${history[index].point}",
                        style: TextStyle(
                            color: isDeposit(history, index)
                                ? const Color(0xFF2CC14D)
                                : const Color(0xFFEB3F3F),
                            fontSize: heightsize * 0.04,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );

  bool isDeposit(List history, int index) {
    return history[index].state == "deposit";
  }
}
