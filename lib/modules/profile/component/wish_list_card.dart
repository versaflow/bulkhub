import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/custom_radio_button.dart';
import '../profile_offer/controllers/wish_list/wish_list_cubit.dart';
import '../profile_offer/model/wish_list_model.dart';

class WishListCard extends StatefulWidget {
  const WishListCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final WishListModel product;

  @override
  State<WishListCard> createState() => _WishListCardState();
}

class _WishListCardState extends State<WishListCard> {
  @override
  Widget build(BuildContext context) {
    final wishListCubit = context.read<WishListCubit>();

    bool isSelected = wishListCubit.selectedId.contains(widget.product.id);

    final width = MediaQuery.of(context).size.width - 40;
    const double height = 100;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.productDetailsScreen,
            arguments: widget.product.slug);
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: borderColor),
          color: isSelected ? const Color(0xffE7F3FF) : Colors.white,
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
                child: CustomImage(
                  path: RemoteUrls.imageUrl(widget.product.thumbImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  widget.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  Utils.formatPrice(widget.product.price),
                  style: const TextStyle(
                      color: redColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CustomRadioButton(
              isSelected: isSelected,
              onTap: () {
                if (!isSelected) {
                  wishListCubit.selectedId.add(widget.product.id);
                } else {
                  wishListCubit.selectedId.remove(widget.product.id);
                }
                setState(() {});
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
