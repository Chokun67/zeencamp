import 'package:flutter/material.dart';

import '../../background.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height;
    final widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MyStyle().titleBackground(widthsize, heightsize, context),
            Column(
              children: [
                titleSetting(widthsize, heightsize),
                deTail(widthsize, heightsize, context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget titleSetting(widthsize, heightsize) => SizedBox(
        height: heightsize * 0.175,
        child: Center(
          child:
              Text("การจัดการบัญชี", style: MyStyle().styleTitle(heightsize)),
        ),
      );

  Widget deTail(widthsize, heightsize, context) => Container(
        padding: EdgeInsets.only(top: heightsize * 0.1),
        height: heightsize * 0.7,
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: []),
        ),
      );
}
