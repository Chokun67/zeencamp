import 'package:flutter/material.dart';
import 'package:zeencamp/Authentication/register.dart';
import 'package:zeencamp/application/accountService/accountservice.dart';
import 'package:zeencamp/domain/pvd_data.dart';
import 'package:zeencamp/menu/menupage.dart';
import 'package:provider/provider.dart';
import 'package:zeencamp/shop/shopmenu.dart';

import '../background.dart';
import '../securestorage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool obscureText = true;
  final _ctrlLogin = TextEditingController();
  final _ctrlPswd = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isvalid = true;
  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height;
    final widthsize = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: widthsize,
          height: heightsize,
          color: const Color(0xFFA6A6A6),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                  height: heightsize * 0.2,
                  width: widthsize * 0.7,
                  child: Image.asset('images/beeicon.png')),
              const SizedBox(height: 10),
              loginbox(heightsize, widthsize, context)
            ]),
          ),
        ),
      ),
    );
  }

  Widget loginbox(double heightsize, double widthsize, BuildContext context) =>
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
                color: const Color(0xFFAD6800),
                width: 7,
                style: BorderStyle.solid),
            color: const Color(0xFFFFD600)),
        height: heightsize * 0.6,
        width: widthsize * 0.8,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: heightsize * 0.01),
              Text(
                "Login",
                style: TextStyle(
                    fontSize: heightsize * 0.03, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: heightsize * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(fontSize: heightsize * 0.015),
                  ),
                ],
              ),
              textFieldUser(heightsize),
              SizedBox(
                height: heightsize * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Password",
                      style: TextStyle(fontSize: heightsize * 0.015)),
                ],
              ),
              textFieldPassword(heightsize),
              pwRemember(),
              SizedBox(height: heightsize * 0.047),
              loginButton(heightsize, widthsize, context),
              createAccButton(heightsize, widthsize, context),
            ],
          ),
        ),
      );

  Widget textFieldUser(heightsize) => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.zero),
        ),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอกค่า';
            } else if (value.length < 8) {
              return 'ต้องมีความยาวมากกว่าเท่ากับ 8 ตัวอักษร';
            }
            return null;
          },
          controller: _ctrlLogin,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: heightsize * 0.02),
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xFFAD6800),
                      width: 2,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.zero)),
              fillColor: Color(0xFF4A4A4A),
              filled: true,
              hintText: "Email"),
        ),
      );

  Widget textFieldPassword(heightsize) => Container(
        width: double.infinity,
        decoration:
            const BoxDecoration(borderRadius: BorderRadius.all(Radius.zero)),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอกค่า';
            } else if (!isvalid) {
              isvalid = true;
              return 'กรุณาตรวจสอบความถูกต้อง';
            }
            return null;
          },
          controller: _ctrlPswd,
          obscureText: obscureText,
          style: TextStyle(fontSize: heightsize * 0.02),
          decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFAD6800), width: 1),
                  borderRadius: BorderRadius.all(Radius.zero)),
              fillColor: const Color(0xFF4A4A4A),
              filled: true,
              hintText: "Password",
              suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off))),
        ),
      );

  Widget pwRemember() => const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("ลืม Password ?"),
        ],
      );

  Widget loginButton(
          double heightsize, double widthsize, BuildContext context) =>
      SizedBox(
        width: widthsize * 0.5,
        height: heightsize * 0.06,
        child: ElevatedButton(
          onPressed: btnlogin,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A4A4A),
              side: const BorderSide(
                color: Color(0xFFAD6800),
                width: 2,
              ),
              shape: const StadiumBorder()),
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );

  void btnlogin() {
    if (_formKey.currentState!.validate()) {
      AccountService().apiLogin(_ctrlLogin.text, _ctrlPswd.text).then((value) =>
          {
            if (value != null)
              {
                if (value.isstore == false)
                  {
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Menu()),
                      ),
                      SecureStorage().write('token', value.accessToken),
                      SecureStorage().write('idAccount', value.idAccount),
                      context.read<AppData>().token = value.accessToken,
                      context.read<AppData>().idAccount = value.idAccount,
                    }
                  }
                else
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ShopMenu()),
                    ),
                    SecureStorage().write('token', value.accessToken),
                    SecureStorage().write('idAccount', value.idAccount),
                    context.read<AppData>().token = value.accessToken,
                    context.read<AppData>().idAccount = value.idAccount,
                  }
              }
            else
              {
                showAlertBox(
                    context, 'แจ้งเตือน', 'ชื่อผู้ใช้หรือรหัสผ่านพิดพลาด'),
                isvalid = false
              }
          });
    }
  }

  Widget createAccButton(
          double heightsize, double widthsize, BuildContext context) =>
      Container(
        width: widthsize * 0.68,
        height: heightsize * 0.05,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black),
          ),
        ),
        child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Registerpage()),
              );
            },
            child: const Text(
              "create Account",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            )),
      );
}
