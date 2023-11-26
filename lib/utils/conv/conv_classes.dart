import 'package:flutter/material.dart';

// text input/output type
List<String> textTypes = [
  "base64",
  "hex",
  "binary",
];

// custom drop-down menu
class ConvMenu extends StatefulWidget {
  const ConvMenu({required this.updateTextType, super.key});
  final Function(String) updateTextType;
  @override
  State<ConvMenu> createState() => _ConvMenu();
}

class _ConvMenu extends State<ConvMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        // use 98% of the screen width
        width: MediaQuery.of(context).size.width * 0.94,
        initialSelection: textTypes[0],
        onSelected: (textType) {
          setState(() {
            widget.updateTextType(textType as String);
          });
        },
        // map the strings to menu entries
        dropdownMenuEntries: textTypes.map<DropdownMenuEntry<String>>((String textType) {
          return DropdownMenuEntry(value: textType, label: textType);
        }).toList());
  }
}

// custom input fields
class ConvInput extends StatefulWidget {
  const ConvInput({required this.inputType, required this.txtControl, super.key});
  // this is for the hint text
  final String inputType;
  // controller to manage text field
  final TextEditingController txtControl;

  @override
  State<ConvInput> createState() => _ConvInput();
}

class _ConvInput extends State<ConvInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.94,
      child: TextFormField(
        // controller to manipulate text from another widget
        controller: widget.txtControl,
        autocorrect: false,
        // multi-line input
        keyboardType: TextInputType.multiline,
        // limit the number of lines (use scroll)
        maxLines: 2,
        // looks better with max lines as starting point
        minLines: 2,
        decoration: InputDecoration(
          filled: true,
          border: const OutlineInputBorder(),
          // shows whether it's a "decode" or "encode" input
          hintText: widget.inputType,
        ),
      ),
    );
  }
}
