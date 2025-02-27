import 'package:abc/bloc_api/bloc/api_event.dart';
import 'package:abc/bloc_api/bloc/api_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api_service.dart';


class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final ApiService apiService;

  ApiBloc(this.apiService) : super(ApiInitial()) {
    on<FetchCategoriesEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final categories = await apiService.getCategories();
        emit(CategoriesLoaded(categories));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });

    on<FetchSubcategoriesEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final subcategories = await apiService.getSubcategories(event.categoryId);
        emit(SubcategoriesLoaded(subcategories));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });

    on<FetchProductsEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final products = await apiService.getProducts(event.subcategoryId);
        emit(ProductsLoaded(products));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
