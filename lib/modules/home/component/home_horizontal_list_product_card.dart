import 'package:flutter/material.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_image.dart';
import '../../category/component/price_card_widget.dart';
import '../model/product_model.dart';

class HomeHorizontalListProductCard extends StatelessWidget {
  final ProductModel productModel;
  const HomeHorizontalListProductCard({
    Key? key,
    this.height = 100,
    this.width = 215,
    required this.productModel,
  }) : super(key: key);
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteNames.productDetailsScreen,
              arguments: productModel.slug);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: borderColor)),
              ),
              height: height - 2,
              width: width / 2.7,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(4)),
                child: CustomImage(
                  path: RemoteUrls.imageUrl(productModel.thumbImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Row(
                  //   children: const [
                  //     Icon(
                  //       Icons.star,
                  //       size: 14,
                  //       color: Color(0xffF6D060),
                  //     ),
                  //     // Text(
                  //     //   '${productModel.rating}',
                  //     //   style: const TextStyle(fontSize: 14),
                  //     // ),
                  //   ],
                  // ),
                  // const SizedBox(height: 5),
                  Text(
                    productModel.category?.name ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: blackColor.withOpacity(.5),
                        height: 1),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    productModel.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14, height: 1),
                  ),
                  const SizedBox(height: 6),
                  PriceCardWidget(
                    offerPrice: productModel.offerPrice,
                    price: productModel.price,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
