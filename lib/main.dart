import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home.dart';

void main() {
  runApp(const MiscUtils());
}

class MiscUtils extends StatelessWidget {
  const MiscUtils({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // force portrait mode
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "miscutils",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
          primary: Colors.amber,
          surface: Colors.blueGrey,
        ),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
