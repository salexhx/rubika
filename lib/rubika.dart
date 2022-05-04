library rubika;

import 'dart:convert';
import 'dart:math';
import 'package:encrypt/encrypt.dart';
import 'package:http/http.dart' as http;

class encryption {
  static String decode(String encryptedString, String auth) {
    final key = Key.fromUtf8(extractKey(auth));
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: "PKCS7"));
    return encrypter.decrypt64(encryptedString, iv: iv);
  }

  static String encode(String shouldEncrypt, String auth) {
    final key = Key.fromUtf8(extractKey(auth));
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: "PKCS7"));
    return encrypter.encrypt(shouldEncrypt, iv: iv).base64;
  }

  static String extractKey(String auth) {
    String str2 = auth.substring(16, 24) +
        auth.substring(0, 8) +
        auth.substring(24, 32) +
        auth.substring(8, 16);
    String sb = str2;
    for (int i2 = 0; i2 < sb.length; i2++) {
      if (sb[i2].codeUnitAt(0) >= '0'.codeUnitAt(0) &&
          sb[i2].codeUnitAt(0) <= '9'.codeUnitAt(0)) {
        sb = _replaceCharAt(
            sb,
            i2,
            String.fromCharCode(
                ((((str2[i2].codeUnitAt(0) - '0'.codeUnitAt(0)) + 5) % 10) +
                    48)));
      }
      if (sb[i2].codeUnitAt(0) >= 'a'.codeUnitAt(0) &&
          sb[i2].codeUnitAt(0) <= 'z'.codeUnitAt(0)) {
        sb = _replaceCharAt(
            sb,
            i2,
            String.fromCharCode(
                ((((str2[i2].codeUnitAt(0) - 'a'.codeUnitAt(0)) + 9) % 26) +
                    97)));
      }
    }
    return sb;
  }

  static String _replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar.toString() +
        oldString.substring(index + 1);
  }
}

class client {
  var _clientinf = {
    "app_name" : "Main",
    "app_version" : "4.0.4",
    "platform" : "Web",
    "package" : "web.rubika.ir",
    "lang_code" : "fa"
  };
  late String _auth;
  Random _random = Random();
  client(String Auth) {
    _auth = Auth;
  }

  String myAuth() {
    return _auth;
  }

  Future<String> post(String data) async {
    var reqData = json.encode({
      "api_version" : "5",
      "auth" : _auth,
      "data_enc" : encryption.encode(data, _auth)
    });
    var response = await http.post(
        Uri.parse('https://messengerg2c60.iranlms.ir/'),
        body: reqData);
    try {
      return (encryption.decode(json.decode(response.body)["data_enc"], _auth));
    }
    catch (e){
      return (response.body);
    }
  }
  String _makeData(String method, Map input) {
    Map data = {
      "method" : method,
      "input" : input,
      "client" : _clientinf
    };
    return json.encode(data).toString();
  }
  Future<String> sendMessage(String text, String target) async {
    String method = "sendMessage";
    Map input = {
      "object_guid": target,
      "rnd":_random.nextInt(999999),
      "text": text
    };
    return post(_makeData(method, input));
  }
  Future<String> getChats([int startId=0]) async {
    String method = "getChats";
    Map input = {
      "start_id" : startId
    };
    return post(_makeData(method, input));
  }
  Future<String> getChatsUpdates() async {
    int timestamp = int.parse(DateTime.now().millisecondsSinceEpoch.round().toString().substring(0, 10)) - 200;
    String method = "getChatsUpdates";
    Map input = {
      "state" : timestamp
    };
    return post(_makeData(method, input));
  }
}
