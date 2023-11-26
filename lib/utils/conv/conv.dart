import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miscutils/utils/conv/conv_classes.dart';
import 'package:miscutils/utils/conv/conv_methods.dart';

class Convert extends StatefulWidget {
  const Convert({super.key});
  @override
  State<Convert> createState() => _ConvertState();
}

class _ConvertState extends State<Convert> {
  // controllers to manipulate the text fields
  TextEditingController encodeControl = TextEditingController();
  TextEditingController decodeControl = TextEditingController();
  String textType = textTypes.first;

  // regex for text filtering
  // returns all characters that don't belong to each group
  String getRegex(String textType) {
    if (textType == "hex") {
      return r"[^a-fA-F0-9]";
    }
    if (textType == 'binary') {
      return r"[^01 ]";
    }
    return r"";
  }

  void updateTextType(String textType) {
    setState(() {
      this.textType = textType;
    });
  }

  void encode() {
    // get the current text
    String txt = decodeControl.text;
    String encoded = muEncode(txt, textType);
    // set the text to the encoded string
    encodeControl.text = encoded;
  }

  // similar to encode
  void decode() {
    // validate the characters, remove any invalid ones
    String txt = encodeControl.text.replaceAll(RegExp(getRegex(textType)), "");
    String decoded = muDecode(txt, textType);
    // update the text (with the removed characters)
    encodeControl.text = txt;
    decodeControl.text = decoded;
  }

  String getTextType() {
    return textType;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // some margins around the edges
        margin: const EdgeInsets.all(2),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // drop-down menu to choose a text type
                ConvMenu(updateTextType: updateTextType),
              ],
            ),
            // space between drop-down menu and input fields
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      // copy to clipboard
                      Clipboard.setData(ClipboardData(text: encodeControl.text));
                      // then send a notification
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("copied encoded text.")));
                    },
                    icon: const Icon(Icons.copy)),
                const Text("encoded text"),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      encodeControl.text = "";
                    },
                    icon: const Icon(Icons.refresh_sharp)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConvInput(
                  inputType: "type text to decode...",
                  // pass the encode controller
                  txtControl: encodeControl,
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: decodeControl.text));
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("copied decoded text.")));
                    },
                    icon: const Icon(Icons.copy)),
                const Text("decoded text"),
                const Spacer(),
                // button to clear the text
                IconButton(
                    onPressed: () {
                      decodeControl.text = "";
                    },
                    icon: const Icon(Icons.refresh_sharp)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConvInput(
                  inputType: "type text to encode...",
                  // pass the decode controller
                  txtControl: decodeControl,
                )
              ],
            ),
            // space between input fields and the buttons
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // these are the buttons for the encode and decode functions respectively
                const Spacer(),
                FloatingActionButton.extended(
                  onPressed: encode,
                  label: const Text("encode"),
                ),
                const Spacer(),
                FloatingActionButton.extended(
                  onPressed: decode,
                  label: const Text("decode"),
                ),
                const Spacer(),
              ],
            ),
            // space between buttons and bottom page
            const Spacer(),
          ],
        ));
  }
}
