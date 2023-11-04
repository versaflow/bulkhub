import 'package:flutter/material.dart';

import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../home/model/product_model.dart';

class BottomSheetProduct extends StatelessWidget {
  const BottomSheetProduct({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    const double height = 120;
    return Container(
      height: height,
      padding: const EdgeInsets.all(15),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(4),
      //   border: Border.all(color: const Color(0xffE8EEF2)),
      //   color: const Color(0xffE8EEF2),
      // ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CustomImage(
              path: RemoteUrls.imageUrl(product.thumbImage),
              fit: BoxFit.cover,
              height: 85,
              width: 85,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      height: 1.5, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Text(
                    product.offerPrice < 0 ?  Utils.formatPrice(product.offerPrice) : Utils.formatPrice(product.price),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: redColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
