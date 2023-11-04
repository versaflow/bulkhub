import 'package:flutter/material.dart';
import '../model/product_model.dart';
import 'home_horizontal_list_product_card.dart';
import 'section_header.dart';

class CategoryAndListComponent extends StatelessWidget {
  const CategoryAndListComponent({
    Key? key,
    required this.productList,
    required this.category,
    this.bgColor,
    this.onTap,
  }) : super(key: key);
  final List<ProductModel> productList;
  final String category;
  final Color? bgColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (productList.isEmpty) return const SliverToBoxAdapter();

    return SliverToBoxAdapter(
      child: Container(
        color: bgColor,
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SectionHeader(
                headerText: category,
                onTap: onTap,
              ),
            ),
            Container(
              height: 100,
              margin: const EdgeInsets.only(top: 14, bottom: 20),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => HomeHorizontalListProductCard(
                  productModel: productList[index],
                  height: 100,
                  width: 215,
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: productList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
