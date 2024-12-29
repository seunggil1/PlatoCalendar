import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

class EncryptKey {
  late final Key key;
  late final IV iv;

  EncryptKey(this.key, this.iv);

  EncryptKey.fromString(String keyString) {
    String base64key = keyString.split(':')[0];
    String base64Iv = keyString.split(':')[1];

    key = Key(Uint8List.fromList(base64Url.decode(base64key)));
    iv = IV.fromBase64(base64Iv);
  }

  @override
  String toString() {
    return '${base64UrlEncode(key.bytes.toList())}:${iv.base64}';
  }
}
