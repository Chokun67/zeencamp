import 'package:flutter/material.dart';
import 'package:zeencamp/background.dart';

import 'shopdetail.dart';

class SearchShop extends StatefulWidget {
  const SearchShop({super.key});

  @override
  State<SearchShop> createState() => _SearchShopState();
}

class _SearchShopState extends State<SearchShop> {
  final _ctrlSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height;
    final widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: widthsize,
          height: heightsize,
          color: const Color(0xFF4A4A4A),
          child: Stack(
            children: [
              Column(
                children: [
                  MyStyle().buildBackground(widthsize, heightsize,context),
                  fieldSearchType(widthsize, heightsize),
                  Container(
                      color: const Color(0xFF4A4A4A),
                      width: widthsize,
                      height:
                          heightsize - heightsize * 0.284 - heightsize * 0.1,
                      child: shopName(widthsize, heightsize, context)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldSearchType(widthsize, heightsize) => Container(
        margin:
            EdgeInsets.only(top: heightsize * 0.06, bottom: heightsize * 0.06),
        width: widthsize * 0.8,
        height: heightsize * 0.06,
        child: TextField(
          controller: _ctrlSearch,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFFAD6800), width: 1),
                  borderRadius: BorderRadius.circular(10)),
              fillColor: const Color(0xFFFFFFFF),
              filled: true,
              hintText: "search"),
        ),
      );

  Widget shopName(widthsize, heightsize, context) => SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: 8,
              padding: EdgeInsets.all(widthsize * 0.04),
              physics: const ScrollPhysics(parent: null),
              shrinkWrap: true,
              itemBuilder: (BuildContext buildList, int index) {
                return InkWell(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Shopdetail()))
                  },
                  child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xFFFFFFFF),
                      ),
                      margin: EdgeInsets.only(bottom: widthsize * 0.025),
                      padding: EdgeInsets.all(widthsize * 0.05),
                      // width: widthsize * 0.87,
                      height: heightsize * 0.1,
                      child: Text(
                        "ร้านไก่ย่าง",
                        style: TextStyle(
                            color: const Color(0xFFEB3F3F),
                            fontSize: heightsize * 0.035,
                            fontWeight: FontWeight.bold),
                      )),
                );
              },
            ),
          ],
        ),
      );
}
