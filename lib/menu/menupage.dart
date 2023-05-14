import 'package:flutter/material.dart';
import 'package:zeencamp/application/httpmenu.dart';
// import 'package:provider/provider.dart';
// import 'package:zeencamp/domain/pvd_data.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key,required this.token }):super(key: key);  
  final String token;
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late Future<Map<String, dynamic>> datapoint;
  var pointid;
  // var token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datapoint = apigetpoint(widget.token);
    datapoint.then((value) => setState(() {
          pointid = value['point'];
          print(value['point']);
        }));

    
  }

  @override
  Widget build(BuildContext context) {
    print(widget.token);

    // token = context.read<AppData>().token;
    // var token =
    //     'eyJhbGciOiJIUzUxMiJ9.eyJpZCI6InF2Y1QzSWNCbVlybDFpLW4yazdOIiwicG9zaXRpb24iOiJjdXN0b21lciIsImV4cCI6MTY4NDMyMDc0MSwiaWF0IjoxNjgzMDI0NzQxfQ.CfD_qhIdUF-u4CUq0Y5kfWBgwvdf7yn7CqhOXYrlepWZkSS1MLtpim3z2aRSi8HMoXAompDt8CzGR7RrCmdMIw';
    // datapoint = apigetpoint(widget.token);
    // datapoint.then((value) => setState(() {
    //       pointid = value['point'];
    //       print(value['point']);
    //     }));
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

  Widget circlePoint(heightsize, widthsize) => Container(
      width: heightsize * 0.26,
      height: 300,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF280),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFFF9900),width: 5)
      ),
      child: Center(
          child: Text('$pointid',
              style:
                  const TextStyle(fontSize: 26, fontWeight: FontWeight.bold))));

  Widget settingButton(widthsize, heightsize) => SizedBox(
        width: widthsize * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: heightsize * 0.03,
            ),
            IconButton(
              icon: Icon(Icons.settings, size: widthsize * 0.043),
              onPressed: () {},
            ),
          ],
        ),
      );
}
