import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/profile/profile_offer/controllers/wish_list/wish_list_cubit.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({Key? key, required this.productId}) : super(key: key);
  final int productId;
  final double height = 28;
  final bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result =
            await context.read<WishListCubit>().addWishList(productId);

        result.fold(
          (failure) {
            Utils.errorSnackBar(context, failure.message);
          },
          (success) {
            Utils.showSnackBar(context, success);
          },
        );
      },
      child: Container(
        height: height,
        width: height,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: borderColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: FittedBox(
            child: Icon(isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? redColor : Colors.white)),
      ),
    );
  }
}
