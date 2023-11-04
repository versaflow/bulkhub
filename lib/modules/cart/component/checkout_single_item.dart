import 'package:flutter/material.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../model/cart_product_model.dart';

class CheckoutSingleItem extends StatelessWidget {
  const CheckoutSingleItem({Key? key, required this.product}) : super(key: key);

  final CartProductModel product;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: borderColor)),
            ),
            constraints: BoxConstraints(
              maxHeight: 120,
              maxWidth: width / 2.7,
            ),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(4)),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.productDetailsScreen,
                      arguments: product.slug);
                },
                child: CustomImage(
                  path: RemoteUrls.imageUrl(product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Utils.formatPrice(product.price),
                      style: const TextStyle(
                          color: redColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        'x ${product.qty}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  children: product.variants
                      .map(
                        (e) => Text(
                          e.name + ' : ' + e.value + ', ',
                          style: const TextStyle(fontSize: 10),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
