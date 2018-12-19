import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const _baseUrl = 'https://api.hgbrasil.com';
const _key = 'ae5c268a';

class HGBrasilService {
  static Future<Map> getDataFinance() async {
    var url = '$_baseUrl/finance?format=json&key=$_key';
    var response = await http.get(url);
    return json.decode(response.body);
  }
}
