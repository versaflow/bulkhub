import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../controllers/cart/cart_cubit.dart';
import '../model/cart_response_model.dart';

class PannelCollapsComponent extends StatelessWidget {
  const PannelCollapsComponent({
    Key? key,
    required this.height,
    required this.cartResponseModel,
  }) : super(key: key);

  final CartResponseModel cartResponseModel;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
            height: 4,
            width: 60,
          ),
          // const SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Order Amount',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                Utils.formatPriceIcon(cartResponseModel.totalAmount,
                    cartResponseModel.setting.currencyIcon),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 40,
            child: PrimaryButton(
              text: 'Checkout',
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.checkoutScreen);
              },
            ),
          )
        ],
      ),
    );
  }
}

class PanelComponent extends StatefulWidget {
  const PanelComponent({
    Key? key,
    this.controller,
    required this.cartResponseModel,
  }) : super(key: key);

  final CartResponseModel cartResponseModel;

  final ScrollController? controller;

  @override
  State<PanelComponent> createState() => _PanelComponentState();
}

class _PanelComponentState extends State<PanelComponent> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.controller,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      children: [
        const Text('Apply Promo Code'),
        const SizedBox(height: 7),
        _buildTextField(),
        const SizedBox(height: 8),
        const Text(
          'Bill Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Subtotal',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              Utils.formatPriceIcon(widget.cartResponseModel.subTotalAmount,
                  widget.cartResponseModel.setting.currencyIcon),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Vat',
              style: TextStyle(fontSize: 16, color: redColor),
            ),
            Text(
              Utils.formatPriceIcon(widget.cartResponseModel.taxAmount,
                  widget.cartResponseModel.setting.currencyIcon),
              style: const TextStyle(fontSize: 16, color: redColor),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Coupon discount',
              style: TextStyle(fontSize: 16, color: redColor),
            ),
            Text(
              Utils.formatPriceIcon(widget.cartResponseModel.couponAmount,
                  widget.cartResponseModel.setting.currencyIcon),
              style: const TextStyle(fontSize: 16, color: redColor),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 1,
          color: borderColor,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              Utils.formatPriceIcon(widget.cartResponseModel.totalAmount,
                  widget.cartResponseModel.setting.currencyIcon),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 40,
          child: PrimaryButton(
            text: 'Checkout',
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.checkoutScreen);
            },
          ),
        )
      ],
    );
  }

  Widget _buildTextField() {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        hintText: 'promo code',
        // contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        isDense: true,
        suffixIconConstraints:
            const BoxConstraints(maxHeight: 55, maxWidth: 85),
        suffixIcon: _buildSubmit(),
      ),
    );
  }

  Widget _buildSubmit() {
    return Container(
      width: 85,
      height: 54,
      decoration: const BoxDecoration(
        color: paragraphColor,
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(4),
        ),
      ),
      child: InkWell(
        onTap: () {
          // textController.clear();

          if (textController.text.isEmpty) return;
          Utils.closeKeyBoard(context);
          context.read<CartCubit>().applyCoupon(textController.text.trim());
        },
        child: const Center(
          child: Text(
            'Submit',
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
