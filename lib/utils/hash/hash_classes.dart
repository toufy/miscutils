import 'package:flutter/material.dart';

// input fields
class HashInput extends StatefulWidget {
  const HashInput(
      {required this.hint, required this.lockInput, required this.txtControl, super.key});
  final TextEditingController txtControl;
  final bool lockInput;
  final String hint;
  @override
  State<HashInput> createState() => _HashInputState();
}

class _HashInputState extends State<HashInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.94,
      child: TextFormField(
        controller: widget.txtControl,
        autocorrect: false,
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        minLines: 5,
        decoration: InputDecoration(
          filled: widget.lockInput,
          border: const OutlineInputBorder(),
          hintText: widget.hint,
        ),
        // lock input if this is the output field
        readOnly: widget.lockInput,
      ),
    );
  }
}

// radio buttons
class HashRadio extends StatefulWidget {
  const HashRadio({required this.algo, required this.updateAlgo, super.key});
  final Function(String) updateAlgo;
  final String algo;
  @override
  State<HashRadio> createState() => _HashRadioState();
}

class _HashRadioState extends State<HashRadio> {
  String algo = "md5";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Column(
              children: [
                Radio(
                    value: "md5",
                    groupValue: widget.algo,
                    onChanged: (value) {
                      setState(() {
                        algo = value as String;
                        widget.updateAlgo(algo);
                      });
                    }),
                const Text("md5"),
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              children: [
                Radio(
                    value: "sha256",
                    groupValue: algo,
                    onChanged: (value) {
                      setState(() {
                        algo = value as String;
                        widget.updateAlgo(algo);
                      });
                    }),
                const Text('sha256'),
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              children: [
                Radio(
                    value: "bcrypt",
                    groupValue: algo,
                    onChanged: (value) {
                      setState(() {
                        algo = value as String;
                        widget.updateAlgo(algo);
                      });
                    }),
                const Text('bcrypt'),
              ],
            ),
          ],
        )
      ],
    );
  }
}
