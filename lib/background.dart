import 'package:flutter/material.dart';

class MyStyle {
  SafeArea buildBackground(
      double widthsize, double heightsize, context, String title) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            width: widthsize,
            height: heightsize * 0.15,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45)),
              color: Color(0xFFFFD600),
            ),
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                  color: const Color(0xFf020202), fontSize: heightsize * 0.05),
            )),
          ),
          Positioned(
              top: widthsize * 0.077,
              left: widthsize * 0.077,
              child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset('images/back.png')))
        ],
      ),
    );
  }

  SafeArea titleBackground(
      double widthsize, double heightsize, BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Container(
          width: widthsize,
          height: heightsize,
          color: const Color(0xFF4A4A4A)),
        Container(
          width: widthsize,
          height: heightsize*0.5,
          color: const Color(0xFFFFD600)),
        Column(
          children: [
            Container(
              height: heightsize * 0.175,
            ),
            Container(
              width: widthsize,
              height: heightsize - heightsize * 0.3,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(90)),
                color: Color(0xFF4A4A4A),
              ),
            )
          ],
        ),
        Positioned(
            top: widthsize * 0.065,
            left: widthsize * 0.065,
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
              height: heightsize * 0.034,
              color: const Color(0xFF4A4A4A),
            ))
      ],
    ));
  }

  TextStyle styleTitle(heightsize) {
    return TextStyle(
        color: const Color(0xFF4A4A4A),
        fontSize: heightsize * 0.05,
        fontWeight: FontWeight.bold);
  }
}

void showAlertBox(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showAlertDecide(BuildContext context,
    {String title = '', String content = '', Function? okAction}) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          ElevatedButton(
            child: const Text('ยกเลิก'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text('ตกลง'),
            onPressed: () {
              Navigator.of(context).pop();
              if (okAction != null) {
                okAction();
              }
            },
          ),
        ],
      );
    },
  );
}
