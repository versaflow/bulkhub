import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/rounded_app_bar.dart';
import '../home/controller/cubit/home_controller_cubit.dart';
import 'component/single_circuler_card.dart';
import 'model/product_categories_model.dart';

class AllCategoryListScreen extends StatelessWidget {
  const AllCategoryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categorieslist =
        context.read<HomeControllerCubit>().homeModel.productCategories;
    return Scaffold(
      appBar: RoundedAppBar(
        titleText: 'Cart',
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: categorieslist.isEmpty
          ? const Center(child: Text("No Item"))
          : _buildGrid(categorieslist),
    );
  }

  Widget _buildGrid(List<ProductCategoriesModel> categorieslist) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        mainAxisExtent: 95,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      itemCount: categorieslist.length,
      itemBuilder: (context, index) {
        return CategoryCircleCard(categoryModel: categorieslist[index]);
      },
    );
  }
}
