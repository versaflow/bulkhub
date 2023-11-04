import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../model/product_details_model.dart';
import '../model/product_details_product_model.dart';

class ProductDetailsComponent extends StatelessWidget {
  const ProductDetailsComponent({
    required this.product,
    required this.detailsModel,
    Key? key,
  }) : super(key: key);

  final ProductDetailsProductModel product;
  final ProductDetailsModel detailsModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _builtPrice(),
          const SizedBox(height: 4),
          Text(
            product.name,
            maxLines: 2,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Text(
            product.shortDescription,
            style: const TextStyle(color: iconGreyColor),
          ),
          const SizedBox(height: 26),
          _builtRating(),
        ],
      ),
    );
  }

  Widget _builtRating() {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: Utils.getRating(detailsModel.productReviews),
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          ignoreGestures: true,
          itemCount: 5,
          itemSize: 20,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
        ),
        Container(
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            height: 24,
            color: borderColor),
        Text(
          Utils.getRating(detailsModel.productReviews).toStringAsFixed(1),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  Widget _builtPrice() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.brand.name,
              style: const TextStyle(fontSize: 16, color: iconGreyColor),
            ),
            const SizedBox(height: 13),
            Row(
              children: [
                Text(
                  product.offerPrice > 0
                      ? Utils.formatPrice(product.offerPrice)
                      : Utils.formatPrice(product.price),
                  style: const TextStyle(
                      color: redColor,
                      height: 1.5,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 6),
                if (product.offerPrice > 0)
                  Text(
                    Utils.formatPrice(product.price),
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Color(0xff85959E),
                      height: 1.5,
                      fontSize: 16,
                    ),
                  )
              ],
            ),
          ],
        ),
        Row(
          children: [
            if (product.offerPrice > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: paragraphColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    Utils.dorpPricePercentage(
                        product.price, product.offerPrice),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            const SizedBox(width: 9),
            Container(
              height: 38,
              width: 38,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Center(
                child: Icon(Icons.redo_outlined),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
