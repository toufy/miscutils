import 'package:flutter/material.dart';
import 'package:miscutils/utils/qrcode/qrcode_classes.dart';

class QrCode extends StatefulWidget {
  const QrCode({super.key});
  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  TextEditingController txtControl = TextEditingController();
  String qrData = "";

  void generateQrCode() {
    setState(() {
      qrData = txtControl.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [QrCodeInput(txtControl: txtControl)],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      txtControl.text = "";
                      qrData = "";
                    });
                  },
                  icon: const Icon(Icons.refresh_sharp)),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrCodeImage(
                qrData: qrData,
              )
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                onPressed: generateQrCode,
                label: const Text("generate"),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
