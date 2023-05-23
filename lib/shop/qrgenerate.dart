import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../domain/pvd_data.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  late String token;
  late String dataInput;
  late String idAccount;

  @override
  void initState() {
    super.initState();
    dataInput = "";
  }

  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height;
    final widthsize = MediaQuery.of(context).size.width;
    idAccount = context.read<AppData>().idAccount;
    token = context.read<AppData>().token;
    return Scaffold(
      backgroundColor: AppStyle.primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: QrImageView(
                data: "{\"point\" :$dataInput,\"idstore\" : \"$idAccount\"}",
                backgroundColor: Colors.white,
                version: QrVersions.auto,
                size: heightsize * 0.35,
              ),
            ),
            SizedBox(
              height: heightsize * 0.02,
            ),
            SizedBox(
              width: widthsize * 0.77,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    dataInput = value;
                  });
                },
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "input point",
                  filled: true,
                  fillColor: AppStyle.textInputColor,
                  border: InputBorder.none,
                  errorText:
                      int.tryParse(dataInput) == null ? 'Invalid input' : null,
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            RawMaterialButton(
              onPressed: () {
                setState(() {}); // Generate QR Code
              },
              fillColor: AppStyle.accentColor,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(
                horizontal: 36.0,
                vertical: 16.0,
              ),
              child: const Text(
                "Generate QR Code",
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppStyle {
  static Color primaryColor = const Color(0xFF222222);
  static Color textInputColor = const Color(0xFF404040);
  static Color accentColor = const Color(0xFF4c90d2);
}
