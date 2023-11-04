import 'package:flutter/material.dart';
import '../../widgets/rounded_app_bar.dart';
import 'component/product_card.dart';
import 'model/product_categories_model.dart';

class SingleCategoryProductScreen extends StatelessWidget {
  const SingleCategoryProductScreen({
    Key? key,
    required this.categoryModel,
  }) : super(key: key);
  final ProductCategoriesModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        titleText: categoryModel.name,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: categoryModel.products.isEmpty
          ? const Center(child: Text("No Item"))
          : _buildProductGrid(),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        mainAxisExtent: 210,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      itemCount: categoryModel.products.length,
      itemBuilder: (context, index) =>
          ProductCard(productModel: categoryModel.products[index]),
    );
  }
}
