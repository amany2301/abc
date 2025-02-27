class ApiEvent{}

class FetchCategoriesEvent extends ApiEvent{
  FetchCategoriesEvent();
}

class FetchSubcategoriesEvent extends ApiEvent{
  final int categoryId;
  FetchSubcategoriesEvent(this.categoryId);
}


class FetchProductsEvent extends ApiEvent{
  final int subcategoryId;
  FetchProductsEvent(this.subcategoryId);
}

