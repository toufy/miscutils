import 'dart:convert';

import 'package:bcrypt/bcrypt.dart';
import 'package:crypto/crypto.dart';

String md5Hash(String text) {
  // get bytes
  List<int> bytes = utf8.encode(text);
  // convert into hex
  Digest digets = md5.convert(bytes);
  // return string
  return digets.toString();
}

// same as md5
String sha256Hash(String text) {
  List<int> bytes = utf8.encode(text);
  Digest digest = sha256.convert(bytes);
  return digest.toString();
}

String bcryptHash(String text) {
  // generate hash and salt value
  // bcrypt stores the salt value as part of the hash itself
  // so the hash is validated correctly regardless of the salt value
  String hashed = BCrypt.hashpw(text, BCrypt.gensalt());
  return hashed;
}

String muHash(String text, String algo) {
  switch (algo) {
    case "md5":
      return md5Hash(text);
    case "sha256":
      return sha256Hash(text);
    case "bcrypt":
      return bcryptHash(text);
    default:
      return "invalid algorithm";
  }
}
