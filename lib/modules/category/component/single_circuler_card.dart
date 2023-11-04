import 'package:flutter/material.dart';
import 'package:flutter_font_awesome_web_names/flutter_font_awesome.dart';
import '../../../core/router_name.dart';
import '../model/product_categories_model.dart';

class CategoryCircleCard extends StatelessWidget {
  const CategoryCircleCard({
    Key? key,
    required this.categoryModel,
  }) : super(key: key);

  final ProductCategoriesModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.singleCategoryProductScreen,
            arguments: categoryModel);
      },
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffE8EEF2),
            ),
            child: Center(child: FaIcon(categoryModel.icon,color: Colors.black,)),
          ),
          const SizedBox(height: 3),
          Text(
            categoryModel.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
