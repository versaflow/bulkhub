import 'package:flutter/material.dart';
import '../model/product_model.dart';
import 'flash_deal_product_card.dart';
import 'section_header.dart';

class FlashDealComponent extends StatelessWidget {
  const FlashDealComponent({
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
    const double listHeight = 170;
    final size = MediaQuery.of(context).size;
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
                color: Colors.white,
              ),
            ),
            Container(
              height: listHeight,
              margin: const EdgeInsets.only(top: 14, bottom: 20),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => FlashDealProductCard(
                    productModel: productList[index],
                    height: listHeight,
                    width: size.width * .773),
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
