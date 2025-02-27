import 'dart:convert';

import 'package:abc/api_call_demo1/post_model.dart';
import 'package:http/http.dart' as http;

class ApiService{
  final String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPosts({int? userId}) async {
    Uri uri  = Uri.parse('$_baseUrl/posts?userId=$userId');
    // final response = await http.get(Uri.parse('$_baseUrl/posts'));
    final response = await http.get(uri);

    if (response.statusCode==200){
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((post) => Post.fromJson(post)).toList();
    }else{
      throw Exception('Failed to load posts');
    }

  }

}