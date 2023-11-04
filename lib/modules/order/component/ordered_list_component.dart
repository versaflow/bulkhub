import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../model/order_model.dart';
import 'single_order_details_component.dart';

class OrderedListComponent extends StatelessWidget {
  const OrderedListComponent({Key? key, required this.orderedItem})
      : super(key: key);

  final OrderModel orderedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        color: redColor.withOpacity(.06),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          _buildOrderNumber(),
          const SizedBox(height: 8),
          _buildTrackingNumber(),
          const SizedBox(height: 8),
          ...orderedItem.orderProducts.map((e) => SingleOrderDetailsComponent(
              orderItem: e, isOrdered: orderedItem.orderStatus == 3)),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _totalItem(),
              Text(
                Utils.orderStatus(orderedItem.orderStatus.toString()),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color:
                        orderedItem.orderStatus.toString() == '4' ? redColor : greenColor),
              )
            ],
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _totalItem() {
    int i = orderedItem.orderProducts.length;
    String s = 'Item: ${i.toString()}';
    if (i > 1) s = 'Items: ${i.toString()}';

    final total =
        Utils.formatPriceIcon(orderedItem.subTotal, orderedItem.currencyIcon);

    return Text(
      s + ', Total: ' + total,
      style: const TextStyle(fontSize: 16),
    );
  }

  Widget _buildOrderNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            text: "Order No: ",
            style: const TextStyle(fontSize: 16, height: 1),
            children: [
              TextSpan(
                text: orderedItem.orderId,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        Text(
          Utils.formatDate(orderedItem.createdAt),
          style: const TextStyle(color: Color(0xff85959E)),
        )
      ],
    );
  }

  Widget _buildTrackingNumber() {
    return Text.rich(
      TextSpan(
        text: "Tracking number:",
        style: const TextStyle(
            fontSize: 14,
            color: iconGreyColor,
            decoration: TextDecoration.underline,
            height: 1),
        children: [
          TextSpan(
            text: ' ' + orderedItem.orderId,
            style: const TextStyle(
                color: blackColor,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
