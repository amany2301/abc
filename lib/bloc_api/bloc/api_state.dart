import 'package:abc/bloc_api/category_model.dart';
import 'package:abc/bloc_api/product_model.dart';
import 'package:abc/bloc_api/subcategory_model.dart';

abstract class ApiState {}

class ApiInitial extends ApiState {}

class LoadingState extends ApiState {}

class CategoriesLoaded extends ApiState {
  final List<Category> categories;
  CategoriesLoaded(this.categories);
}

class SubcategoriesLoaded extends ApiState {
  final List<Subcategory> subcategories;
  SubcategoriesLoaded(this.subcategories);
}

class ProductsLoaded extends ApiState {
  final List<Product> products;
  ProductsLoaded(this.products);
}

class ErrorState extends ApiState {
  final String message;
  ErrorState(this.message);
}
