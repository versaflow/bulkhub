import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/favorite_button.dart';
import '../../cart/controllers/cart/add_to_cart/add_to_cart_cubit.dart';
import '../../cart/model/add_to_cart_model.dart';
import '../../category/component/price_card_widget.dart';
import '../model/product_model.dart';

class FlashDealProductCard extends StatefulWidget {
  final ProductModel productModel;
  const FlashDealProductCard({
    Key? key,
    this.height = 100,
    this.width = 215,
    required this.productModel,
  }) : super(key: key);
  final double height, width;

  @override
  State<FlashDealProductCard> createState() => _FlashDealProductCardState();
}

class _FlashDealProductCardState extends State<FlashDealProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.productDetailsScreen,
          arguments: widget.productModel.slug,
        );
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            const SizedBox(width: 15),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: widget.height - 2,
      width: widget.width / 2.1,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(4)),
            child: CustomImage(
                path: RemoteUrls.imageUrl(widget.productModel.thumbImage),
                fit: BoxFit.cover),
          ),
          // _buildBottomDateTIme()
        ],
      ),
    );
  }

  // Widget _buildBottomDateTIme() {
  //   return Positioned(
  //     bottom: 0,
  //     left: 0,
  //     right: 0,
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: blackColor.withOpacity(.8),
  //         borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(4)),
  //       ),
  //       height: 32,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           _dateAndTime('2', 'Days'),
  //           _dateAndTime('15', 'Hours'),
  //           _dateAndTime('37', 'Min'),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _dateAndTime(String number, String text) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text(
  //         number,
  //         style: const TextStyle(fontSize: 14, height: 1, color: Colors.white),
  //       ),
  //       Text(
  //         text,
  //         style: const TextStyle(
  //             fontSize: 10, height: 1, color: Color(0xffB6C0C5)),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PriceCardWidget(
            offerPrice: widget.productModel.offerPrice,
            price: widget.productModel.price,
          ),
          const SizedBox(height: 5),
          Text(
            widget.productModel.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 14, height: 1),
          ),
          const SizedBox(height: 6),
          Text(
            widget.productModel.category?.name ?? '',
            style:
                const TextStyle(fontSize: 10, color: paragraphColor, height: 1),
          ),
          const SizedBox(height: 6),
          _buildBtns()
        ],
      ),
    );
  }

  Widget _buildBtns() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            final dataModel = AddToCartModel(
              image: widget.productModel.thumbImage,
              productId: widget.productModel.id,
              slug: widget.productModel.slug,
              quantity: 1,
              token: '',
              variantItems: const {},
            );
            context.read<AddToCartCubit>().addToCart(dataModel);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              color: redColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'Add to Cart',
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 6),
        FavoriteButton(productId: widget.productModel.id),
      ],
    );
  }
}
