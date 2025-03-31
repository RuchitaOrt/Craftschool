import 'dart:convert';
import 'package:http/http.dart' as http;

class BitlyService {
  static const String _accessToken = '78b569d1e5a46d0f8bf25a8f5d67363f571274a8';

  static Future<String?> shortenUrl(String longUrl) async {
    final Uri apiUrl = Uri.parse('https://api-ssl.bitly.com/v4/shorten');
   
    final response = await http.post(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "long_url": longUrl,
        "domain": "bit.ly" // Optional, can be customized
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['link']);
     
String shortLink = data['link'];
print("✅ Your short link: $shortLink");
      return data['link'];
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }
}
