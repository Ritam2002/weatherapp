import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper(this.city);
  final String city;

  Future call_api() async {
    String url = "https://weatherapi-com.p.rapidapi.com/current.json?q=${city}";
    Map<String, String> headers = {
      "X-RapidAPI-Key": "557a03a323msh8e25e160aefa158p1031afjsnfbf3104b049b",
      "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
    };
    http.Response res = await http.get(Uri.parse(url), headers: headers);
    if (res.statusCode == 200) {
      print(res.body);
      return jsonDecode(res.body);
    } else
      return {'error': true};
  }
}
