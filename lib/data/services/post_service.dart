import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_app/data/endpoints.dart';
import 'package:test_app/data/model/post_response.dart';

// the post's service endpoint
class PostService {
  static List<String>? item;

  static Future<List<PostResponse>> getPost() async {
    try {
      const endpoint = Endpoints.postUrl;
      final Uri url = Uri.parse(endpoint);
      final response = await get(url);
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
      print(data is List<Map>);

        return postResponseFromJson(response.body);
      } else {
        throw Exception;
      }
    } catch (e) {
      // print("errors $e");

      throw Exception;
    }
  }
}
