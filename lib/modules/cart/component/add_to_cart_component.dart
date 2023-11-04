import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../controllers/cart/cart_cubit.dart';
import '../model/cart_product_model.dart';

class AddToCartComponent extends StatefulWidget {
  const AddToCartComponent({Key? key, required this.product}) : super(key: key);

  final CartProductModel product;

  @override
  State<AddToCartComponent> createState() => _AddToCartComponentState();
}

class _AddToCartComponentState extends State<AddToCartComponent> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;
    const double height = 120;
    return Container(
      height: height,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
        color: Colors.white,
      ),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.horizontal,
        onDismissed: (s) async {
          context
              .read<CartCubit>()
              .removerCartItem(widget.product.id.toString());
        },
        background: Container(
          decoration: BoxDecoration(
            color: redColor,
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.only(right: 40),
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.delete,
            size: 30,
            color: Colors.white,
          ),
        ),
        child: Row(
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
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RouteNames.productDetailsScreen,
                        arguments: widget.product.slug);
                  },
                  child: CustomImage(
                    path: RemoteUrls.imageUrl(widget.product.image),
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
                    widget.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Text(
                        Utils.formatPrice(widget.product.price),
                        style: const TextStyle(
                            color: redColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 15),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<CartCubit>().incrementQuantity(
                                  widget.product.id.toString());
                            },
                            child: const CircleAvatar(
                              radius: 12,
                              backgroundColor: paragraphColor,
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 9),
                            child: Text(
                              widget.product.qty.toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          InkWell(
                            onTap: widget.product.qty > 1
                                ? () {
                                    context.read<CartCubit>().decrementQuantity(
                                        widget.product.id.toString());
                                  }
                                : null,
                            child: const CircleAvatar(
                              radius: 12,
                              backgroundColor: paragraphColor,
                              child: Icon(Icons.remove, color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Wrap(
                    children: widget.product.variants
                        .map(
                          (e) => Text(
                            e.name + ' : ' + e.value + ', ',
                            style: const TextStyle(fontSize: 10),
                          ),
                        )
                        .toList(),
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
