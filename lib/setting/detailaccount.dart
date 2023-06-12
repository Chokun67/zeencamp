import 'package:flutter/material.dart';
import 'package:zeencamp/application/accountService/accountservice.dart';

import '../Authentication/login.dart';
import '../background.dart';
import '../securestorage.dart';

class DetailAccount extends StatefulWidget {
  const DetailAccount({super.key});

  @override
  State<DetailAccount> createState() => _DetailAccountState();
}

class _DetailAccountState extends State<DetailAccount> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlname = TextEditingController();
  final _ctrlusername = TextEditingController();

  var token = "";
  var iduser = "";
  var idname = "";
  var birthday = "";
  var sex = "";
  var idAccount = "";
  var age = 0;

  @override
  void initState() {
    super.initState();
    getData().then((_) {
      AccountService().apigetpersonal(token).then((value) => {
            if (value != null)
              {
                setState(() {
                  idname = value.name;
                  iduser = value.username;
                  birthday = value.birthday;
                  sex = value.sex;
                  age = value.age;
                })
              }
            else
              {idname = "dont have"}
          });
    });
  }

  Future<void> getData() async {
    token = await SecureStorage().read("token") as String;
    idAccount = await SecureStorage().read("idAccount") as String;
  }

  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.vertical;
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("name", style: styletype(heightsize)),
            textfieldName(heightsize, widthsize),
            SizedBox(height: heightsize * 0.02),
            Text("usrname", style: styletype(heightsize)),
            textfieldusername(heightsize, widthsize),
            SizedBox(height: heightsize * 0.02),
            Text("birthday", style: styletype(heightsize)),
            textfieldbirthday(heightsize, widthsize),
            SizedBox(height: heightsize * 0.02),
            Text("sex", style: styletype(heightsize)),
            textfieldsex(heightsize, widthsize),
            SizedBox(height: heightsize * 0.03),
            editButton(heightsize, widthsize, context),
            deleteButton(heightsize, widthsize)
          ]),
        ),
      );

  Widget textfieldName(heightsize, widthsize) => SizedBox(
        width: widthsize * 0.72,
        height: heightsize * 0.06,
        child: TextFormField(
          readOnly: true,
          style: TextStyle(fontSize: heightsize * 0.02),
          controller: _ctrlname,
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอกค่า';
            } else if (value.length < 8) {
              return 'ต้องมีความยาวมากกว่าเท่ากับ 8 ตัวอักษร';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "name : $idname",
            fillColor: const Color(0xFFA6A6A6),
            filled: true,
          ),
        ),
      );

  Widget textfieldusername(heightsize, widthsize) => SizedBox(
        width: widthsize * 0.72,
        height: heightsize * 0.06,
        child: TextFormField(
          readOnly: true,
          style: TextStyle(fontSize: heightsize * 0.02),
          controller: _ctrlusername,
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอกค่า';
            } else if (value.length < 8) {
              return 'ต้องมีความยาวมากกว่าเท่ากับ 8 ตัวอักษร';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "email : $iduser",
            fillColor: const Color(0xFFA6A6A6),
            filled: true,
          ),
        ),
      );

  Widget textfieldbirthday(heightsize, widthsize) => SizedBox(
        width: widthsize * 0.72,
        height: heightsize * 0.06,
        child: TextFormField(
          readOnly: true,
          style: TextStyle(fontSize: heightsize * 0.02),
          controller: _ctrlname,
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอกค่า';
            } else if (value.length < 8) {
              return 'ต้องมีความยาวมากกว่าเท่ากับ 8 ตัวอักษร';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "birthday : $birthday",
            fillColor: const Color(0xFFA6A6A6),
            filled: true,
          ),
        ),
      );

  Widget textfieldsex(heightsize, widthsize) => SizedBox(
        width: widthsize * 0.72,
        height: heightsize * 0.06,
        child: TextFormField(
          readOnly: true,
          style: TextStyle(fontSize: heightsize * 0.02),
          controller: _ctrlname,
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอกค่า';
            } else if (value.length < 8) {
              return 'ต้องมีความยาวมากกว่าเท่ากับ 8 ตัวอักษร';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Gender : $sex",
            fillColor: const Color(0xFFA6A6A6),
            filled: true,
          ),
        ),
      );

  Widget editButton(
          double heightsize, double widthsize, BuildContext context) =>
      SizedBox(
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
            "แก้ไขรายละเอียด",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: heightsize * 0.025),
          ),
        ),
      );

  Widget deleteButton(double heightsize, double widthsize) => SizedBox(
        width: widthsize * 0.4,
        height: heightsize * 0.07,
        child: ElevatedButton(
          onPressed: (){
            showAlertDecide(context,
              title: 'แจ้งเตือน', content: 'คุณกำลังจะลบฐัญชีใช่หรือไม่', okAction: () {
            deleteAccount(context);
          });
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A4A4A),
              side: const BorderSide(
                color: Color(0xFFAD6800),
                width: 2,
              ),
              shape: const StadiumBorder()),
          child: Text(
            "ลบบัญชี",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: heightsize * 0.025),
          ),
        ),
      );

  TextStyle styletype(heightsize) {
    return TextStyle(
        fontSize: heightsize * 0.02,
        color: Colors.white,
        fontWeight: FontWeight.bold);
  }

  void deleteAccount(context) {
    AccountService().deleteAccount(token);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Loginpage()),
      (route) => false,
    );
  }
}
