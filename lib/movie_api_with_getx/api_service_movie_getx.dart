import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = "https://www.omdbapi.com/";
  final String _apiKey = "ac02810c"; // Replace with your API Key


  Future<List<dynamic>> fetchMovies(String query) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          "s": query,
          "apikey": _apiKey,
        },
      );

      if (response.statusCode == 200 && response.data["Response"] == "True") {
        return response.data["Search"];
      } else {
        throw Exception(response.data["Error"]);
      }
    } catch (e) {
      throw Exception("Failed to fetch movies: $e");
    }
  }
}
