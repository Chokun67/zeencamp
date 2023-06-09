import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrReceive extends StatefulWidget {
  const QrReceive({super.key});

  @override
  State<QrReceive> createState() => _QrReceiveState();
}

class _QrReceiveState extends State<QrReceive> {
  @override
  Widget build(BuildContext context) {
    const String id = "1";
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR รับเงิน'),backgroundColor: const Color(0xFF4A4A4A),foregroundColor: 
        const Color(0xFFFFD600),
      ),
      body: Center(
        child: QrImageView(
          data: id,
          version: QrVersions.auto,
           backgroundColor: Colors.white,
          size: 200.0,
        ),
      ),
    );
  }
}
