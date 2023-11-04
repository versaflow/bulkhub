import 'package:flutter/material.dart';
import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/favorite_button.dart';
import '../../home/model/product_model.dart';

class PopulerProductCard extends StatelessWidget {
  final ProductModel productModel;
  const PopulerProductCard({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double height = 125;
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(height),
          const SizedBox(width: 14),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildImage(double height) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: borderColor)),
      ),
      height: height,
      width: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(4)),
            child: CustomImage(
              path: RemoteUrls.imageUrl(productModel.thumbImage),
              fit: BoxFit.cover,
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

  Widget _buildContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: const [
              Icon(
                Icons.star,
                size: 16,
                color: Color(0xffF6D060),
              ),
              // Text('${productModel.rating}'),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            productModel.category?.name ?? '',
            style: TextStyle(
                fontSize: 13, height: 1.5, color: blackColor.withOpacity(.5)),
          ),
          const SizedBox(height: 6),
          Text(
            productModel.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                Utils.formatPrice(productModel.price),
                style: const TextStyle(
                    color: redColor,
                    height: 1.5,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 6),
              Text(
                Utils.formatPrice(productModel.offerPrice),
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
}
