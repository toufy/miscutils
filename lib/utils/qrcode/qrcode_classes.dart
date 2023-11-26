import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

// qrcode image
class QrCodeImage extends StatefulWidget {
  const QrCodeImage({required this.qrData, super.key});
  final String qrData;
  @override
  State<QrCodeImage> createState() => _QrCodeImageState();
}

class _QrCodeImageState extends State<QrCodeImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          // square area for the qr code
          width: MediaQuery.of(context).size.width * 0.94,
          height: MediaQuery.of(context).size.width * 0.94,
          // qr code widget
          child: Scaffold(
            // provided by third party package
            body: QrImageView(
              // update data according to widget
              data: widget.qrData,
              backgroundColor: Colors.white,
              // fixed size
              size: MediaQuery.of(context).size.width * 0.94,
            ),
          ),
        ),
      ],
    );
  }
}

// input field
class QrCodeInput extends StatefulWidget {
  const QrCodeInput({required this.txtControl, super.key});
  final TextEditingController txtControl;
  @override
  State<QrCodeInput> createState() => _QrCodeInputState();
}

class _QrCodeInputState extends State<QrCodeInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.94,
      child: TextFormField(
        controller: widget.txtControl,
        autocorrect: false,
        keyboardType: TextInputType.multiline,
        maxLines: 2,
        minLines: 2,
        decoration: const InputDecoration(
          filled: true,
          border: OutlineInputBorder(),
          hintText: "type something to generate...",
        ),
      ),
    );
  }
}
