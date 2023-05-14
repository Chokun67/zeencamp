import 'package:flutter/material.dart';

class Shopdetail extends StatelessWidget {
  const Shopdetail({super.key});

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
            decoration: const BoxDecoration(color: Colors.greenAccent),
          ),
          Container(
            width: widthsize,
            height: heightsize * 0.45,
            decoration: const BoxDecoration(color: Colors.amber),
          ),
          Positioned(
              top: heightsize * 0.28,
              child: Container(
                width: widthsize,
                height: heightsize,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(90)),
                  color: Color(0xFF4A4A4A),
                ),
                child: Column(
                  children: [
                    positionShop(widthsize, heightsize),
                    detailMenu(widthsize, heightsize, context)
                  ],
                ),
              )),
          Positioned(
              top: widthsize * 0.077,
              left: widthsize * 0.077,
              child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset('images/back.png')))
        ],
      ),
    ));
  }

  Widget positionShop(widthsize, heightsize) => Container(
        margin: EdgeInsets.only(top: widthsize * 0.1, left: widthsize * 0.1),
        height: heightsize * 0.08,
        width: widthsize * 0.8,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFFFFD600),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  height: heightsize * 0.02,
                ),
                SizedBox(
                  width: widthsize * 0.12,
                  child: Container(
                    height: widthsize * 0.06,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4A4A4A),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: widthsize * 0.48,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ร้านไก่",
                    style: TextStyle(
                        fontSize: heightsize * 0.03,
                        fontWeight: FontWeight.bold),
                  ),
                  Text("id 1804",
                      style: TextStyle(
                          fontSize: heightsize * 0.03,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: heightsize * 0.05,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.location_pin),
                    iconSize: widthsize * 0.08,
                  ),
                ),
                Text("Location",
                    style: TextStyle(
                        fontSize: heightsize * 0.018,
                        fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      );

  Widget detailMenu(widthsize, heightsize, context) => Container(
        margin: EdgeInsets.only(top: heightsize * 0.02),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: const Color(0xFFFFD600),
            border: Border.all(color: const Color(0xFFAD6800), width: 5)),
        height: heightsize * 0.5,
        width: widthsize * 0.8,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                itemCount: 4,
                padding: EdgeInsets.all(widthsize * 0.04),
                physics: const ScrollPhysics(parent: null),
                shrinkWrap: true,
                itemBuilder: (BuildContext buildList, int index) {
                  return Container(
                      margin: EdgeInsets.only(bottom: heightsize * 0.01),
                      color: Colors.amber,
                      height: heightsize * 0.12,
                      child: Row(
                        children: [
                          detailPicture(widthsize, heightsize),
                          SizedBox(
                            width: widthsize * 0.05,
                          ),
                          detailPrice(widthsize, heightsize)
                        ],
                      ));
                },
              ),
            ],
          ),
        ),
      );

  Widget detailPicture(widthsize, heightsize) => Container(
        width: widthsize * 0.3,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: const Color(0xFF000000), width: 4)),
      );

  Widget detailPrice(widthsize, heightsize) => Container(
        padding: EdgeInsets.all(widthsize*0.02),
        height: heightsize * 0.1,
        width: widthsize * 0.34,
        decoration: BoxDecoration(
            color: const Color(0xFFFFF09F),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: const Color(0xFF000000), width: 2)),
        child: Text("ส้มตำไทย\n20 บาท",style: TextStyle(fontWeight: FontWeight.bold,fontSize: heightsize*0.02),),
      );
}
