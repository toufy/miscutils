import 'package:flutter/material.dart';
import 'package:miscutils/utils/hash/hash.dart';
import 'package:miscutils/utils/qrcode/qrcode.dart';

import 'utils/conv/conv.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // controller for the tab bar
    return DefaultTabController(
        // has 3 tabs
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
              bottom: const TabBar(
                tabs: [
                  // icons for each tab
                  Tab(icon: Icon(Icons.handyman)),
                  Tab(icon: Icon(Icons.security)),
                  Tab(icon: Icon(Icons.qr_code_2_sharp)),
                ],
              ),
            ),
          ),
          body: const TabBarView(
              // controller/body for each tab
              children: [
                // conversion tab
                Convert(),
                // hashing tab
                Hash(),
                // qr generator tab
                QrCode(),
              ]),
        ));
  }
}
