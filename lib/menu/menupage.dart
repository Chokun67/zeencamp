import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
        child: Column(
          children: [
            Container(
              width: widthsize,
              height: heightsize * 0.362,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90)),
                color: Color(0xFFFFD600),
              ),
              child: Row(
                children: [
                  Container(
                    width: widthsize * 0.223,
                  ),
                  circlePoint(heightsize, widthsize),
                  settingButton(heightsize, widthsize),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

Widget circlePoint(heightsize, widthsize) => Container(
    width: heightsize * 0.26,
    height: 300,
    decoration: const BoxDecoration(
      color: Color(0xFFFFF280),
      shape: BoxShape.circle,
    ));

Widget settingButton(widthsize, heightsize) => SizedBox(
      width: widthsize * 0.223,
      height: heightsize * 0.362,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: heightsize * 0.03,
          ),
          IconButton(
            icon: Icon(Icons.settings, size: widthsize * 0.087),
            onPressed: () {},
          ),
        ],
      ),
    );
