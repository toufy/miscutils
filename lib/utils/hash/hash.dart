import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miscutils/utils/hash/hash_classes.dart';
import 'package:miscutils/utils/hash/hash_methods.dart';

class Hash extends StatefulWidget {
  const Hash({super.key});
  @override
  State<Hash> createState() => _HashState();
}

class _HashState extends State<Hash> {
  TextEditingController inputCtrl = TextEditingController();
  TextEditingController outputCtrl = TextEditingController();
  String algo = "md5";

  void updateAlgo(String value) {
    setState(() {
      algo = value;
    });
  }

  void makeHash() {
    String txt = inputCtrl.text;
    String hash = muHash(txt, algo);
    outputCtrl.text = hash;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          // input field
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HashInput(hint: "type text to hash...", lockInput: false, txtControl: inputCtrl),
            ],
          ),
          // output field
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: outputCtrl.text));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("copied $algo hash.")));
                  },
                  icon: const Icon(Icons.copy)),
              const Text("hash:"),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    inputCtrl.text = "";
                    outputCtrl.text = "";
                  },
                  icon: const Icon(Icons.refresh_sharp))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HashInput(hint: "generate a hash...", lockInput: true, txtControl: outputCtrl),
            ],
          ),
          // radio buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [HashRadio(algo: algo, updateAlgo: updateAlgo)],
          ),
          const Spacer(),
          // hash button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                onPressed: makeHash,
                label: Text('hash with $algo'),
              )
            ],
          ),
          const Spacer()
        ],
      ),
    );
  }
}
