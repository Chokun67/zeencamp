import 'package:flutter/material.dart';
import 'package:zeencamp/application/httpregister.dart';
import 'package:zeencamp/menu/menupage.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final _ctrluser = TextEditingController();
  final _ctrlpswd = TextEditingController();
  final _ctrlconfirm = TextEditingController();
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
        height: heightsize * 0.6,
        width: widthsize * 0.8,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: heightsize * 0.01),
            Text("Register",
                style: TextStyle(
                    fontSize: heightsize * 0.03, fontWeight: FontWeight.bold)),
            SizedBox(height: heightsize * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Email"),
                textfielduser(heightsize, widthsize),
                const Text("Password"),
                textfieldpswd(heightsize, widthsize),
                const Text("Confirm Password"),
                textfieldconfirm(heightsize, widthsize),
                Row(children: [
                  const Statetest(),
                  SizedBox(
                    width: widthsize * 0.06,
                  ),
                  const Gender()
                ]),
                SizedBox(height: heightsize * 0.047),
              ],
            ),
            loginButton(heightsize, widthsize, context),
            backToLogin(heightsize, widthsize, context),
          ],
        ),
      );

  Widget textfielduser(heightsize, widthsize) => SizedBox(
        width: widthsize * 0.72,
        height: heightsize * 0.05,
        child: TextField(
          controller: _ctrluser,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFAD6800), width: 1),
                  borderRadius: BorderRadius.all(Radius.zero)),
              fillColor: Colors.white,
              filled: true),
        ),
      );

  Widget textfieldpswd(heightsize, widthsize) => SizedBox(
        width: widthsize * 0.72,
        height: heightsize * 0.05,
        child: TextField(
          controller: _ctrlpswd,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFAD6800), width: 1),
                  borderRadius: BorderRadius.all(Radius.zero)),
              fillColor: Colors.white,
              filled: true),
        ),
      );

  Widget textfieldconfirm(heightsize, widthsize) => SizedBox(
        width: widthsize * 0.72,
        height: heightsize * 0.05,
        child: TextField(
          controller: _ctrlconfirm,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFAD6800), width: 1),
                  borderRadius: BorderRadius.all(Radius.zero)),
              fillColor: Colors.white,
              filled: true),
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
    if (_ctrlpswd.text == _ctrlconfirm.text) {
      var datebirth =
          '$dropdownValueday/$dropdownValuemounth/$dropdownValueyear';
      // late Future<Map<String, dynamic>> futureLogin;
      apiRegister(
              _ctrluser.text, _ctrlpswd.text, datebirth, dropdownValuegender)
          .then((value) => {
                if (value.code == 200)
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Menu()),
                    ),
                    print(value.accessToken)
                  }
              });
    } else {
      print("Error");
    }
  }

  Widget backToLogin(
          double heightsize, double widthsize, BuildContext context) =>
      Container(
        width: widthsize * 0.68,
        height: heightsize * 0.05,
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
} // จุดสิ้นสุด stateful

List<String> listday = <String>[];
List<String> listmounth = <String>[];
List<String> listyear = <String>[];

String dropdownValueday = listday.first;
String dropdownValuemounth = listmounth.first;
String dropdownValueyear = listyear.first;

class Statetest extends StatefulWidget {
  const Statetest({super.key});

  @override
  State<Statetest> createState() => _StatetestState();
}

class _StatetestState extends State<Statetest> {
  @override
  Widget build(BuildContext context) {
    if (listday.isEmpty) {
      for (int i = 0; i < 31; i++) {
        listday.add("${i + 1}");
      }
      for (int i = 0; i < 12; i++) {
        listmounth.add("${i + 1}");
      }
      for (int i = 1973; i < 2023; i++) {
        listyear.add("${i + 1}");
      }
    }
    final heightsize = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("DD/MM/YYYY"),
        Row(
          children: [
            DropdownButton<String>(
              value: dropdownValueday,
              elevation: (heightsize * 32).toInt(),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValueday = value!;
                });
              },
              items: listday.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: dropdownValuemounth,
              elevation: (heightsize * 32).toInt(),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValuemounth = value!;
                });
              },
              items: listmounth.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: dropdownValueyear,
              elevation: (heightsize * 32).toInt(),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValueyear = value!;
                });
              },
              items: listyear.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        )
      ],
    );
  }
}

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
