import 'package:get/get.dart';
import 'api_service_movie_getx.dart';

class MovieController extends GetxController {
  final ApiService apiService = ApiService();
  var movies = [].obs;
  var isLoading = false.obs;
  var errorMessage = "".obs;

  void searchMovies(String query) async {
    isLoading.value = true;
    errorMessage.value = "";

    try {
      movies.value = await apiService.fetchMovies(query);
    } catch (e) {
      errorMessage.value = e.toString();
    }

    isLoading.value = false;
  }
}
