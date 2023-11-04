import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class PriceCardWidget extends StatelessWidget {
  const PriceCardWidget({
    Key? key,
    required this.price,
    required this.offerPrice,
  }) : super(key: key);
  final int price;
  final int offerPrice;

  @override
  Widget build(BuildContext context) {
    if (offerPrice < 0) {
      return _buildPrice(Utils.formatPrice(price));
    }
    return Row(
      children: [
        _buildPrice(Utils.formatPrice(offerPrice)),
        const SizedBox(width: 10),
        Text(
          Utils.formatPrice(price),
          style: const TextStyle(
            decoration: TextDecoration.lineThrough,
            color: Color(0xff85959E),
            height: 1.5,
            fontSize: 14,
          ),
        )
      ],
    );
  }

  Widget _buildPrice(String price) {
    return Text(
      price,
      style: const TextStyle(
          color: redColor,
          height: 1.5,
          fontSize: 18,
          fontWeight: FontWeight.w600),
    );
  }
}
