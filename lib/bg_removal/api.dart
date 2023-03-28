import 'dart:convert';
import 'package:ai_art/constant.dart';
import 'package:http/http.dart' as http;

class Api {
  static final url = Uri.parse(url_removebg);

  static removebg(String path) async {
    var request = http.MultipartRequest("POST", url);

    request.headers.addAll({"X-API-KEY": removeBg_apiKey});
    request.files.add(await http.MultipartFile.fromPath("image_file", path));
    final res = await request.send();

    if (res.statusCode == 200) {
      http.Response img = await http.Response.fromStream(res);
      return img.bodyBytes;
    } else {
      print("Failed to fetch data");
      return null;
    }
  }
}
