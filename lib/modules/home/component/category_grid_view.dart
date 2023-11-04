import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../core/router_name.dart';
import '../../category/component/single_circuler_card.dart';
import '../../category/model/product_categories_model.dart';
import 'section_header.dart';

class CategoryGridView extends StatelessWidget {
  const CategoryGridView({
    Key? key,
    required this.categoryList,
  }) : super(key: key);
  final List<ProductCategoriesModel> categoryList;

  @override
  Widget build(BuildContext context) {
    if (categoryList.isEmpty) return const SliverToBoxAdapter();
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: MultiSliver(
        children: [
          SliverToBoxAdapter(
            child: SectionHeader(
              headerText: 'Categories',
              onTap: () {
                Navigator.pushNamed(context, RouteNames.allCategoryListScreen);
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              mainAxisExtent: 95,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) =>
                  CategoryCircleCard(categoryModel: categoryList[index]),
              childCount: categoryList.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
