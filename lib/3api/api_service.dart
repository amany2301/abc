
import 'dart:convert';

import 'package:abc/3api/product_model.dart';
import 'package:abc/3api/subcategory_model.dart';
import 'package:http/http.dart' as http;

import 'category_model.dart';

class ApiService {


  // Future<ListCategory>> getCategory(int userId) async{
  //   final response  = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users?userId=$userId"));
  //   if(response.statusCode==200){
  //     List Data = jsonDecode(response.body);
  //     return Data.map((item) => Category.fromJson(item)).toList();
  //   }
  //   else{
  //     throw Exception('Failed to load categories');
  //   }
  // }


  // Get Categories
  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Category.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Get Subcategories
  Future<List<Subcategory>> getSubcategories(int categoryId) async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?userId=$categoryId'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Subcategory.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load subcategories');
    }
  }

  // Get Products
  Future<List<Product>> getProducts(int subcategoryId) async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments?postId=$subcategoryId'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
