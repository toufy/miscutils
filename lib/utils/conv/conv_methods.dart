import 'dart:convert';

import 'package:convert/convert.dart';

// base64
String _base64enc(String text) {
  // generate encoded string
  List<int> bytes = utf8.encode(text);
  // convert to base64
  String b64 = base64.encode(bytes);
  return b64;
}

String _base64dec(String text) {
  // extract integer values
  List<int> bytes = base64.decode(text);
  // convert from base64
  String str = utf8.decode(bytes);
  return str;
}

// hex
// same process as base64, but for hex
String _hexenc(String text) {
  List<int> bytes = utf8.encode(text);
  String h16 = hex.encode(bytes);
  return h16;
}

String _hexdec(String text) {
  List<int> bytes = hex.decode(text);
  String str = utf8.decode(bytes);
  return str;
}

// binary
// similar process to the previous ones, a little more nuanced
String _binenc(String text) {
  List<int> bytes = utf8.encode(text);
  // convert every integer value to its binary string
  Iterable<String> binItter = bytes.map((int str) => str.toRadixString(2).padLeft(8, '0'));
  // convert the iterable into a string
  String bin = binItter.join(" ");
  return bin.replaceAll(RegExp(r"[(,)]"), "");
}

String _bindec(String text) {
  // remove spaces
  String txt = text.replaceAll(" ", "");
  // holds all the bytes
  List<String> bytes = [];
  for (int i = 0; i < txt.length; i += 8) {
    String byte;
    try {
      byte = txt.substring(i, i + 8);
      // any exception here is an out of bounds error
      // pad the last element to be 8 characters long
    } catch (e) {
      byte = txt.substring(i, txt.length).padLeft(8, "0");
    }
    bytes.add(byte);
  }
  // map bytes into characters (integer values of corresponding chars)
  Iterable<int> chars = bytes.map((byte) => int.parse(byte, radix: 2));
  // convert the iterable into string
  String str = String.fromCharCodes(chars);
  return str;
}

// wrapper classes for abstraction
// encode
String muEncode(String text, String textType) {
  switch (textType) {
    case "base64":
      return _base64enc(text);
    case "hex":
      return _hexenc(text);
    case "binary":
      return _binenc(text);
    // this is practically impossible to happen
    // only here so dart doesn't complain
    default:
      return "not a known standard";
  }
}

// decode
String muDecode(String text, String textType) {
  switch (textType) {
    case "base64":
      return _base64dec(text);
    case "hex":
      return _hexdec(text);
    case "binary":
      return _bindec(text);
    default:
      return "not a known standard";
  }
}
