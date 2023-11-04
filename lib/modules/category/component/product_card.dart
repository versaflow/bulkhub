import 'package:flutter/material.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/favorite_button.dart';
import '../../home/model/product_model.dart';
import 'price_card_widget.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;
  final double? width;
  const ProductCard({
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
          Navigator.pushNamed(context, RouteNames.productDetailsScreen,
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
          PriceCardWidget(
            price: productModel.price,
            offerPrice: productModel.offerPrice,
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
          _buildOfferInPercentage(),
          Positioned(
            top: 8,
            left: 8,
            child: FavoriteButton(productId: productModel.id),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferInPercentage() {
    if (productModel.offerPrice < -1) {
      return const Positioned(
        top: 8,
        right: 8,
        child: SizedBox(),
      );
    }

    final percentage =
        Utils.dorpPricePercentage(productModel.price, productModel.offerPrice);

    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        height: 22,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: const Color(0xff18587A),
            borderRadius: BorderRadius.circular(2)),
        child: Text(
          percentage,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }
}
