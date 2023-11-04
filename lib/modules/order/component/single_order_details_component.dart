import 'package:flutter/material.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../model/product_order_model.dart';

class SingleOrderDetailsComponent extends StatelessWidget {
  const SingleOrderDetailsComponent({
    Key? key,
    required this.orderItem,
    this.isOrdered = false,
  }) : super(key: key);

  final bool isOrdered;

  final OrderedProductModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: blackColor.withOpacity(.05),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteNames.productDetailsScreen,
              arguments: orderItem.slug);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImage(
              path: RemoteUrls.imageUrl(orderItem.thumbImage),
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderItem.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        height: 1.3, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'X ' + orderItem.qty.toString(),
                    style: TextStyle(color: blackColor.withOpacity(.6)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Utils.formatPrice(orderItem.unitPrice)),
                      if (isOrdered)
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.submitFeedBackScreen,
                                arguments: orderItem);
                          },
                          child: const Text(
                            "Review",
                            style: TextStyle(color: redColor),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
