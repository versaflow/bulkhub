import 'dart:developer';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/toggle_button_component.dart';
import '../cart/controllers/cart/cart_cubit.dart';
import 'component/bottom_sheet_widget.dart';
import 'component/description_component.dart';
import 'component/product_details_component.dart';
import 'component/product_header_component.dart';
import 'component/rating_list_component.dart';
import 'component/related_products_list.dart';
import 'controller/cubit/product_details_cubit.dart';
import 'model/product_details_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    Key? key,
    required this.slug,
  }) : super(key: key);
  final String slug;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<ProductDetailsCubit>().getProductDetails(widget.slug));
  }

  final _className = 'ProductDetailsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsStateLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductDetailsStateError) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(color: redColor),
                ),
              );
            }
            if (state is ProductDetailsStateLoaded) {
              return _buildLoadedPage(state.productDetailsModel);
            }
            log(state.toString(), name: _className);
            return const SizedBox();
          },
        );
      }),
    );
  }

  Widget _buildLoadedPage(ProductDetailsModel productDetailsModel) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: borderColor.withOpacity(.2),
              title: const Text('Products Details'),
            ),
            SliverToBoxAdapter(
                child: ProductHeaderComponent(productDetailsModel.product)),
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            SliverToBoxAdapter(
              child: ProductDetailsComponent(
                detailsModel: productDetailsModel,
                product: productDetailsModel.product,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 25)),
            SliverToBoxAdapter(
              child: ToggleButtonComponent(
                textList: [
                  'Products Description',
                  'Review (${productDetailsModel.productReviews.length})'
                ],
                initialLabelIndex: 0,
                onChange: (int i) {
                  setState(() {
                    selectedIndex = i;
                  });
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: getChild(productDetailsModel)),
            SliverToBoxAdapter(
              child: RelatedProductsList(productDetailsModel.relatedProducts),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 95)),
          ],
        ),
        _buildBottomButtons(productDetailsModel),
      ],
    );
  }

  Widget getChild(ProductDetailsModel productDetailsModel) {
    if (selectedIndex == 0) {
      return DescriptionComponent(productDetailsModel.product.longDescription);
    }
    return ReviewListComponent(productDetailsModel.productReviews);
  }

  Widget _buildBottomButtons(ProductDetailsModel product) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            offset: const Offset(-9, -1),
            blurRadius: 30,
            spreadRadius: 30,
          )
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.cartScreen);
            },
            child: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: paragraphColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                  if (state is CartStateLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is CartStateError) {
                    return const Icon(Icons.error);
                  } else if (state is CartStateLoaded) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.cartScreen);
                      },
                      child: badges.Badge(
                        padding: const EdgeInsets.all(5.0),
                        badgeColor: const Color(0xffFFFFFF),
                        badgeContent: Text(
                          state.cartResponseModel.cartProducts.isNotEmpty
                              ? state.cartResponseModel.cartProducts.length
                                  .toString()
                              : '0',
                          style: const TextStyle(
                              fontSize: 10, color: Colors.black),
                        ),
                        child: const Icon(Icons.shopping_cart_rounded,
                            size: 28, color: Colors.white),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                })),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: PrimaryButton(
              text: 'Add to cart',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => BottomSheetWidget(product: product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
