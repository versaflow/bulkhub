import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../cart/controllers/cart/cart_cubit.dart';

class HomeAppBar extends StatelessWidget {
  final double height;
  final String logo;

  const HomeAppBar({
    Key? key,
    required this.logo,
    this.height = 140,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                height: height - 20,
                decoration: const BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImage(path: logo, height: 54, width: 120),
                    // const Text("BULK HUB",textAlign: TextAlign.start, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),

                    Row(
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.pushNamed(
                        //         context, RouteNames.notificationScreen);
                        //   },
                        //   child: Badge(
                        //     badgeColor: const Color(0xff18587A),
                        //     badgeContent: const Text(
                        //       '3',
                        //       style:
                        //           TextStyle(fontSize: 10, color: Colors.white),
                        //     ),
                        //     child: const Icon(Icons.notifications,
                        //         size: 28, color: Colors.white),
                        //   ),
                        // ),
                        // const SizedBox(width: 20),
                        BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                          if (state is CartStateLoading) {
                            return const CircularProgressIndicator();
                          } else if (state is CartStateError) {
                            return const Icon(Icons.error);
                          } else if(state is CartStateLoaded){
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteNames.cartScreen);
                              },
                              child: badges.Badge(
                                padding: const EdgeInsets.all(5.0),
                                badgeColor: const Color(0xff18587A),
                                badgeContent:  Text(
                                 state.cartResponseModel.cartProducts.isNotEmpty ? state.cartResponseModel.cartProducts.length.toString() : '0',
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                                child: const Icon(Icons.shopping_cart_rounded,
                                    size: 28, color: Colors.white),
                              ),
                            );
                          }
                          else {
                            return const SizedBox();
                          }
                        })
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xff333333).withOpacity(.18),
                          blurRadius: 70),
                    ],
                  ),
                  child: TextFormField(
                    onTap: () {
                      Utils.closeKeyBoard(context);
                      Navigator.pushNamed(
                          context, RouteNames.productSearchScreen);
                    },
                    decoration: inputDecorationTheme.copyWith(
                      prefixIcon: const Icon(Icons.search_rounded, size: 26),
                      hintText: 'Search your products',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 11,
                        horizontal: 16,
                      ),
                      suffixIconConstraints:
                          const BoxConstraints(maxHeight: 32, minWidth: 32),
                      // suffixIcon: Container(
                      //   decoration: BoxDecoration(
                      //       color: const Color(0xff18587A),
                      //       borderRadius: BorderRadius.circular(4)),
                      //   margin: const EdgeInsets.only(right: 8),
                      //   height: 32,
                      //   width: 32,
                      //   child: const Icon(
                      //     Icons.menu,
                      //     size: 26,
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
