import 'package:flutter/material.dart';
import 'package:zeencamp/menu/menupage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height;
    final widthsize = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        width: widthsize,
        height: heightsize,
        color: const Color(0xFFA6A6A6),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
                height: heightsize * 0.2,
                width: widthsize * 0.7,
                child: Image.asset('images/beeicon.png')),
            const SizedBox(height: 10),
            loginbox(heightsize, widthsize,context)
          ]),
        ),
      ),
    );
  }
}

Widget loginbox(double heightsize, double widthsize,BuildContext context) => Container(
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
          textfielduser(),
          const SizedBox(height: 20),
          textfielduser(),
          pwRemember(),
          SizedBox(height: heightsize * 0.047),
          loginButton(heightsize, widthsize,context),
          createAccButton(heightsize, widthsize),
        ],
      ),
    );

Widget textfielduser() => const TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFAD6800), width: 1),
              borderRadius: BorderRadius.all(Radius.zero)),
          fillColor: Color.fromARGB(255, 78, 75, 75),
          filled: true),
    );

Widget pwRemember() => Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text("ลืม Password ?"),
      ],
    );

Widget loginButton(double heightsize, double widthsize,BuildContext ctx) => SizedBox(
      width: widthsize * 0.5,
      height: heightsize * 0.06,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            ctx,
            MaterialPageRoute(
              builder: (context) {
                return const Menu();
              },
            ),
          );
        },
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

Widget createAccButton(double heightsize, double widthsize) => Container(
      width: widthsize * 0.68,
      height: heightsize * 0.05,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: TextButton(
          onPressed: () {},
          child: const Text(
            "create Account",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          )),
    );
