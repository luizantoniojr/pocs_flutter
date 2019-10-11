import 'dart:convert';
import 'package:http/http.dart' as http;

class GiphyService {
  static String _baseURL = "https://api.giphy.com/v1/gifs";
  static String _apiKey = "hmBN2VqHYwr8CyvNWGVzHf9R9BOyMPf5";

  static Future<Map> getGifs(String search, int offSet) {
    if (search == null)
      return getGifsTrending();
    else
      return getGifsBySearch(search, offSet);
  }

  static Future<Map> getGifsBySearch(String search, int offSet) async {
    var url =
        "$_baseURL/search?api_key=$_apiKey&q=$search&limit=19&offset=$offSet&rating=G&lang=pt";
    var response = await http.get(url);
    return json.decode(response.body);
  }

  static Future<Map> getGifsTrending() async {
    var url = "$_baseURL/trending?api_key=$_apiKey&limit=20&rating=G";
    var response = await http.get(url);
    return json.decode(response.body);
  }
}
