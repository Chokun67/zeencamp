import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zeencamp/application/accountService/accountservice.dart';
import 'package:zeencamp/background.dart';
// import 'package:zeencamp/application/httpregister.dart';
import 'package:zeencamp/menu/menupage.dart';

import '../domain/pvd_data.dart';
import '../securestorage.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final _formKey = GlobalKey<FormState>();
  bool obscureText1 = true;
  bool obscureText2 = true;
  final _ctrluser = TextEditingController();
  final _ctrlusername = TextEditingController();
  final _ctrlpswd = TextEditingController();
  final _ctrlconfirm = TextEditingController();
  DateTime selectedDate = DateTime.now();
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
              registorbox(heightsize, widthsize, context),
            ]),
          ),
        ),
      ),
    );
  }

  Widget registorbox(
    double heightsize,
    double widthsize,
    BuildContext context,
  ) =>
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
                color: const Color(0xFFAD6800),
                width: 7,
                style: BorderStyle.solid),
            color: const Color(0xFFFFD600)),
        height: heightsize * 0.72,
        width: widthsize * 0.8,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: heightsize * 0.01),
            Text("Register",
                style: TextStyle(
                    fontSize: heightsize * 0.03, fontWeight: FontWeight.bold)),
            SizedBox(height: heightsize * 0.01),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Email"),
                  textfielduser(heightsize, widthsize),
                  const Text("username"),
                  textfieldusername(heightsize, widthsize),
                  const Text("Password"),
                  textfieldpswd(heightsize, widthsize),
                  const Text("Confirm Password"),
                  textfieldconfirm(heightsize, widthsize),
                  Row(children: [
                    dateSelect(heightsize, widthsize, context),
                    SizedBox(
                      width: widthsize * 0.06,
                    ),
                    const Gender()
                  ]),
                  SizedBox(height: heightsize * 0.005),
                ],
              ),
            ),
            loginButton(heightsize, widthsize, context),
            backToLogin(heightsize, widthsize, context),
          ],
        ),
      );

  Widget textfielduser(heightsize, widthsize) => SizedBox(
        width: widthsize * 0.72,
        height: heightsize * 0.075,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: _ctrluser,
          style: TextStyle(fontSize: heightsize * 0.02),
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณาป้อนอีเมล';
            } else if (value.length < 8) {
              return 'ต้องมีความยาวมากกว่าเท่ากับ 8 ตัวอักษร';
            } else if (!value.contains("@")) {
              return 'รูปแบบอีเมลไม่ถูกต้อง';
            }
            return null;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFAD6800), width: 1),
                borderRadius: BorderRadius.all(Radius.zero)),
            fillColor: Color(0xFF4A4A4A),
            filled: true,
          ),
        ),
      );

  Widget textfieldusername(heightsize, widthsize) => SizedBox(
        width: widthsize * 0.72,
        height: heightsize * 0.075,
        child: TextFormField(
          controller: _ctrlusername,
          style: TextStyle(fontSize: heightsize * 0.02),
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอกค่า';
            } else if (value.length < 8) {
              return 'ต้องมีความยาวมากกว่าเท่ากับ 8 ตัวอักษร';
            }
            return null;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFAD6800), width: 1),
                borderRadius: BorderRadius.all(Radius.zero)),
            fillColor: Color(0xFF4A4A4A),
            filled: true,
          ),
        ),
      );

  Widget textfieldpswd(heightsize, widthsize) => SizedBox(
        width: widthsize * 0.72,
        height: heightsize * 0.075,
        child: TextFormField(
          obscureText: obscureText1,
          style: TextStyle(fontSize: heightsize * 0.02),
          controller: _ctrlpswd,
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอกค่า';
            } else if (value.length < 8) {
              return 'ต้องมีความยาวมากกว่าเท่ากับ 8 ตัวอักษร';
            }
            return null;
          },
          decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFAD6800), width: 1),
                  borderRadius: BorderRadius.all(Radius.zero)),
              fillColor: const Color(0xFF4A4A4A),
              filled: true,
              suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText1 = !obscureText1;
                    });
                  },
                  child: Icon(
                      obscureText1 ? Icons.visibility : Icons.visibility_off))),
        ),
      );

  Widget textfieldconfirm(heightsize, widthsize) => SizedBox(
        width: widthsize * 0.72,
        height: heightsize * 0.075,
        child: TextFormField(
          obscureText: obscureText2,
          style: TextStyle(fontSize: heightsize * 0.02),
          controller: _ctrlconfirm,
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอกค่า';
            } else if (value.length < 8) {
              return 'ต้องมีความยาวมากกว่าเท่ากับ 8 ตัวอักษร';
            }
            return null;
          },
          decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFAD6800), width: 1),
                  borderRadius: BorderRadius.all(Radius.zero)),
              fillColor: const Color(0xFF4A4A4A),
              filled: true,
              suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText2 = !obscureText2;
                    });
                  },
                  child: Icon(
                      obscureText2 ? Icons.visibility : Icons.visibility_off))),
        ),
      );

  Widget loginButton(
          double heightsize, double widthsize, BuildContext context) =>
      SizedBox(
        width: widthsize * 0.5,
        height: heightsize * 0.06,
        child: ElevatedButton(
          onPressed: btnregister,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A4A4A),
              side: const BorderSide(
                color: Color(0xFFAD6800),
                width: 2,
              ),
              shape: const StadiumBorder()),
          child: const Text(
            "Registor",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );

  void btnregister() {
    if (_formKey.currentState!.validate()) {
      if (_ctrlpswd.text == _ctrlconfirm.text) {
        AccountService()
            .apiRegister(_ctrluser.text, _ctrlusername.text, _ctrlpswd.text,
                DateFormat('yyyy-MM-dd').format(selectedDate), dropdownValuegender)
            .then((value) => {
                  if (value != null)
                    {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Menu()),
                      ),
                    SecureStorage().write('token', value.accessToken),
                    SecureStorage().write('idAccount', value.idAccount),
                    context.read<AppData>().token = value.accessToken,
                    context.read<AppData>().idAccount = value.idAccount,
                    }
                });
      } else {
        showAlertBox(context, 'แจ้งเตือน', 'โปรดตรวจสอบรหัสผ่าน');
      }
    }
  }

  Widget backToLogin(
          double heightsize, double widthsize, BuildContext context) =>
      Container(
        width: widthsize * 0.68,
        height: heightsize * 0.04,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already  have an account?"),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Color(0xFF1A7B23),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      );

  Widget dateSelect(heightsize, widthsize, context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Select birthday"),
        ElevatedButton(
            onPressed: () async {
              final DateTime? dateTime = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(1940),
                  lastDate: DateTime.now());
              if (dateTime != null) {
                setState(() {
                  selectedDate = dateTime;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A4A4A),
              ),
            child: const Text("choose Date"),
            )
      ]);
} // จุดสิ้นสุด stateful

List<String> listgender = <String>['ชาย', 'หญิง', 'อื่นๆ'];
String dropdownValuegender = listgender.first;

class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("Gender"),
      Row(children: [
        DropdownButton<String>(
          value: dropdownValuegender,
          elevation: (heightsize * 32).toInt(),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValuegender = value!;
            });
          },
          items: listgender.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ])
    ]);
  }
}
