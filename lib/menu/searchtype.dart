import 'package:flutter/material.dart';
import 'package:zeencamp/background.dart';
import 'package:zeencamp/menu/searchshop.dart';

class SearchType extends StatefulWidget {
  const SearchType({super.key});

  @override
  State<SearchType> createState() => _SearchTypeState();
}

class _SearchTypeState extends State<SearchType> {
  final _ctrlSearch = TextEditingController();
  Color graycolor = const Color(0xffD9D9D9);
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
                MyStyle().buildBackground(widthsize, heightsize,context,"ร้านค้า"),
                fieldSearchType(widthsize, heightsize),
                GridView.count(
                  crossAxisSpacing: widthsize * 0.02,
                  mainAxisSpacing: widthsize * 0.04,
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(widthsize * 0.05),
                  children: [
                    typeFood(widthsize),
                    typeDrink(widthsize),
                    typeSweets(widthsize)
                  ],
                )
              ],
            ),
          ],
        ),
      )),
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

  Widget typeFood(widthsize) => InkWell(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            color: graycolor,
          ),
          child: Center(
            child: Text(
              "อาหาร",
              style: TextStyle(fontSize: widthsize * 0.08),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SearchShop()));
        },
      );

  Widget typeDrink(widthsize) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          color: graycolor,
        ),
        child: Center(
          child: Text(
            "เครื่องดื่ม",
            style: TextStyle(fontSize: widthsize * 0.08),
          ),
        ),
      );

  Widget typeSweets(widthsize) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          color: graycolor,
        ),
        child: Center(
          child: Text(
            "ขนม",
            style: TextStyle(fontSize: widthsize * 0.08),
          ),
        ),
      );


}
