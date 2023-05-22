import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeencamp/domain/pvd_data.dart';
import 'Authentication/login.dart';
import 'package:flutter/services.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AppData(),
    )
  ], child: const MainApp()));
  // runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Flutter Auth',
        home: Scaffold(
          body: Loginpage(),
        ));
  }
}
