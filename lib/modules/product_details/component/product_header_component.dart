import 'package:flutter/material.dart';

import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/favorite_button.dart';
import '../model/product_details_product_model.dart';

class ProductHeaderComponent extends StatefulWidget {
  const ProductHeaderComponent(
    this.product, {
    Key? key,
  }) : super(key: key);

  final ProductDetailsProductModel product;

  @override
  State<ProductHeaderComponent> createState() => _ProductHeaderComponentState();
}

class _ProductHeaderComponentState extends State<ProductHeaderComponent> {
  late String productThumb;

  @override
  void initState() {
    super.initState();
    productThumb = widget.product.thumbImage;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 255,
            decoration: BoxDecoration(
              color: borderColor.withOpacity(.2),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
          ),
          _buildThumbImage(),
          _buildFavBtn(widget.product.id),
          _buildGalleryImage()
        ],
      ),
    );
  }

  Widget _buildGalleryImage() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.product.gallery
            .take(4)
            .map(
              (e) => Container(
                padding: const EdgeInsets.all(8),
                height: 70,
                width: 70,
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: borderColor)),
                child: InkWell(
                  onTap: () {
                    productThumb = e.image;
                    setState(() {});
                  },
                  child: CustomImage(
                    path: RemoteUrls.imageUrl(e.image),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildFavBtn(int id) {
    return Positioned(
      right: 20,
      top: 0,
      child: FavoriteButton(productId: id),
    );
  }

  Widget _buildThumbImage() {
    return Positioned(
      top: 20,
      left: 50,
      right: 60,
      bottom: 35,
      child: CustomImage(
        path: RemoteUrls.imageUrl(productThumb),
        fit: BoxFit.contain,
      ),
    );
  }
}
