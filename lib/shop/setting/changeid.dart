import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../background.dart';

class ChangeId extends StatefulWidget {
  const ChangeId({super.key});

  @override
  State<ChangeId> createState() => _ChangeIdState();
}

class _ChangeIdState extends State<ChangeId> {
  final _formKey = GlobalKey<FormState>();
  
  late String bit;
  File? file;
  ImagePicker image = ImagePicker();
  getImage() async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.gallery);
    if (img?.path != null) {
      setState(() {
        file = File(img!.path);
      });
      bit = base64.encode(await file!.readAsBytes());
    }
  }
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
              Text("เข้าร่วมร้านค้า", style: MyStyle().styleTitle(heightsize)),
        ),
      );

  Widget deTail(widthsize, heightsize, context) => Container(
        padding: EdgeInsets.only(top: heightsize * 0.1),
        height: heightsize * 0.7,
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
                imageHere(widthsize),
                iconPickPicture(widthsize),
                btnChangeID(heightsize,widthsize)
              ]),
        ),
      );

  Widget imageHere(widthsize) => SizedBox(
        height: widthsize * 0.5,
        width: widthsize * 0.5,
        child: file == null
            ? Icon(
                Icons.image,
                size: widthsize * 0.5,
              )
            : Image.file(
                file!,
                fit: BoxFit.fill,
              ),
      );

  Widget iconPickPicture(widthsize) => IconButton(
      onPressed: () {
        getImage();
      },
      icon: Icon(
        Icons.photo_album_outlined,
        size: 0.05 * widthsize,
      ));

  Widget btnChangeID(heightsize,widthsize) => SizedBox(
        width: widthsize * 0.6,
        height: heightsize * 0.07,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A4A4A),
              side: const BorderSide(
                color: Color(0xFFAD6800),
                width: 2,
              ),
              shape: const StadiumBorder()),
          child: Text(
            "เปลี่ยนเป็นไอดีร้านค้า",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: heightsize * 0.025),
          ),
        ),
      );
}
