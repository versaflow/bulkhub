import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../../cart/controllers/cart/add_to_cart/add_to_cart_cubit.dart';
import '../../cart/model/add_to_cart_model.dart';
import '../../home/model/product_model.dart';
import '../model/product_details_model.dart';
import '../model/product_variant_model.dart';
import '../model/variant_items_model.dart';
import 'bottom_seet_product.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductDetailsModel product;

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  Set<ProductVariantModel> variantItems = {};

  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _valientInit();
  }

  void _valientInit() {
    for (var element in widget.product.productVariants) {
      final item = element.variantItems.first;
      variantItems.add(element.copyWith(variantItems: [item]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetProduct(
              product: ProductModel.fromMap(widget.product.product.toMap())),
          Container(
            color: const Color(0xffD9D9D9),
            height: 1,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 15),
          ),
          _VarientItemsWidget(
            productVariants: widget.product.productVariants,
            variantItems: variantItems,
            onChange: (item) {
              for (var element in variantItems.toList()) {
                if (element.id == item.id) {
                  variantItems.remove(element);
                }
              }
              variantItems.add(item);
              setState(() {});
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  'Quantity',
                  style: TextStyle(
                      fontSize: 18,
                      color: redColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () {
                  quantity++;
                  setState(() {});
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
                  quantity.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () {
                  if (quantity > 1) {
                    quantity--;
                    setState(() {});
                  }
                },
                child: const CircleAvatar(
                  radius: 12,
                  backgroundColor: paragraphColor,
                  child: Icon(Icons.remove, color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Total Price : " + totalPrice(),
                style: const TextStyle(color: redColor),
              ),
            ],
          ),
          PrimaryButton(
            text: 'Add to cart',
            onPressed: () {
              Navigator.pop(context);
              final dataModel = AddToCartModel(
                image: widget.product.product.thumbImage,
                productId: widget.product.product.id,
                slug: widget.product.product.slug,
                quantity: quantity,
                token: '',
                variantItems: variantItems,
              );
              context.read<AddToCartCubit>().addToCart(dataModel);

            },
          ),
        ],
      ),
    );
  }

  String totalPrice() {
    double price = 0.0;
    if (widget.product.product.offerPrice > 0) {
      price = widget.product.product.offerPrice.toDouble() * quantity;
    } else {
      price = widget.product.product.price.toDouble() * quantity;
    }

    for (var element in variantItems) {
      if (element.variantItems.isNotEmpty) {
        price += element.variantItems.first.price.toDouble();
      }
    }
    return Utils.formatPrice(price);
  }
}

class _VarientItemsWidget extends StatelessWidget {
  const _VarientItemsWidget({
    Key? key,
    required this.productVariants,
    required this.variantItems,
    required this.onChange,
  }) : super(key: key);

  final List<ProductVariantModel> productVariants;
  final Set<ProductVariantModel> variantItems;

  final ValueChanged<ProductVariantModel> onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: productVariants.map(_buildSIngleVarient).toList(),
    );
  }

  Widget _buildSIngleVarient(ProductVariantModel singleVarient) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(singleVarient.name),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Wrap(
              children: singleVarient.variantItems.map(
                (itemModel) {
                  return _buildVarientItemBox(singleVarient, itemModel);
                },
              ).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildVarientItemBox(
    ProductVariantModel singleVarient,
    VariantItemModel itemModel,
  ) {
    final varient = singleVarient.copyWith(variantItems: [itemModel]);
    return InkWell(
      onTap: () => onChange(varient),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: variantItems.contains(varient) ? redColor : null,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          itemModel.name,
          style: TextStyle(
            color:
                variantItems.contains(varient) ? Colors.white : paragraphColor,
          ),
        ),
      ),
    );
  }
}
