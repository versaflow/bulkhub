import 'package:flutter/material.dart';

import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/favorite_button.dart';
import '../model/product_details_product_model.dart';

class RelatedSingleProductCard extends StatelessWidget {
  final ProductDetailsProductModel productModel;
  final double? width;
  const RelatedSingleProductCard({
    Key? key,
    required this.productModel,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(
              context, RouteNames.productDetailsScreen,
              arguments: productModel.slug);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            const SizedBox(height: 8),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  productModel.shortName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: blackColor.withOpacity(.5),
                  ),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.star,
                size: 14,
                color: Color(0xffF6D060),
              ),
              // Text('${productModel.rating}'),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            productModel.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600, height: 1),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                Utils.formatPrice(productModel.offerPrice),
                style: const TextStyle(
                    color: redColor,
                    height: 1.5,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 10),
              Text(
                Utils.formatPrice(productModel.price),
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Color(0xff85959E),
                  height: 1.5,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      height: 118,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            child: CustomImage(
                path: RemoteUrls.imageUrl(productModel.thumbImage),
                fit: BoxFit.cover),
          ),
          if(productModel.offerPrice < -1)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              height: 22,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: const Color(0xff18587A),
                  borderRadius: BorderRadius.circular(2)),
              child: Text(
                Utils.dorpPricePercentage(
                      productModel.price, productModel.offerPrice),
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: FavoriteButton(productId: productModel.id),
          ),
        ],
      ),
    );
  }
}
