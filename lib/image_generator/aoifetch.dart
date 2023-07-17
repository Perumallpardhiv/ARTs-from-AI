import 'dart:convert';
import 'package:ai_art/constant.dart';
import 'package:http/http.dart' as http;

class apiFetch {
  static final url = Uri.parse(url1);
  static generateImage(String input, String size) async {
    try {
      var responce = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $apiKey"
        },
        body: jsonEncode(
          {
            "prompt": input,
            "n": 1,
            "size": size,
          },
        ),
      );

      if (responce.statusCode == 200) {
        var imglink = jsonDecode(responce.body);
        return imglink['data'][0]['url'].toString();
      } else {
        print("Failed to fetch Image");
      }
    } catch (e) {
      print(e);
    }
  }
}
