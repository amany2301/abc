
import 'package:abc/3api/api_service.dart';
import 'package:abc/3api/product_model.dart';
import 'package:abc/3api/subcategory_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'category_model.dart';

class CascadingApiExample extends StatefulWidget {
  @override
  _CascadingApiExampleState createState() => _CascadingApiExampleState();
}

class _CascadingApiExampleState extends State<CascadingApiExample> {
  final ApiService _apiService = ApiService();

  List<Category> categories = [];
  List<Subcategory> subcategories = [];
  List<Product> products = [];

  Category? selectedCategory;
  Subcategory? selectedSubcategory;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  // Load Categories
  void _loadCategories() async {
    categories = await _apiService.getCategories();
    setState(() {});
  }

  // Load Subcategories
  void _loadSubcategories(int categoryId) async {
    subcategories = await _apiService.getSubcategories(categoryId);
    selectedSubcategory = null;
    products = [];
    setState(() {});
  }

  // Load Products
  void _loadProducts(int subcategoryId) async {
    products = await _apiService.getProducts(subcategoryId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cascading API Calls')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Category Dropdown
            DropdownButton<Category>(
              value: selectedCategory,
              hint: Text('Select Categ'
                  'ory'),
              isExpanded: true,
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
                _loadSubcategories(value!.id);
              },
            ),
            SizedBox(height: 20),

            // Subcategory Dropdown
            DropdownButton<Subcategory>(
              value: selectedSubcategory,
              hint: Text('Select Subcategory'),
              isExpanded: true,
              items: subcategories.map((subcat) {
                return DropdownMenuItem(
                  value: subcat,
                  child: Text(subcat.title),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSubcategory = value;
                });
                _loadProducts(value!.id);
              },
            ),
            SizedBox(height: 20),

            // Product List
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(products[index].name),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
