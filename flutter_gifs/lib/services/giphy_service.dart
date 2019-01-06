import 'dart:convert';
import 'package:http/http.dart' as http;

class GiphyService {
  static String _baseURL = "https://api.giphy.com/v1/gifs";
  static String _apiKey = "hmBN2VqHYwr8CyvNWGVzHf9R9BOyMPf5";

  static Future<Map> getGifsBySearch(String search) async {
    int offSet = 0;
    var url =
        "$_baseURL/search?api_key=$_apiKey&q=$search&limit=20&offset=$offSet&rating=G&lang=pt";
    var response = await http.get(url);
    return json.decode(response.body);
  }

  static Future<Map> getGigsTrending() async {
    var url =
        "$_baseURL/trending?api_key=$_apiKey&limit=20&rating=G";
    var response = await http.get(url);
    return json.decode(response.body);
  }
}
