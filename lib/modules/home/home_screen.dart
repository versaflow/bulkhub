import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../core/remote_urls.dart';
import '../../utils/utils.dart';
import '../cart/controllers/cart/add_to_cart/add_to_cart_cubit.dart';
import 'component/category_grid_view.dart';
import 'component/count_down_offer_and_product.dart';
import 'component/category_and_list_component.dart';
import 'component/flash_deal_component.dart';
import 'component/home_app_bar.dart';
import 'component/hot_deal_banner_slider.dart';
import 'component/new_arrival_component.dart';
import 'component/offer_banner_slider.dart';
import 'component/sponsor_component.dart';
import 'controller/cubit/home_controller_cubit.dart';
import 'model/home_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  final _className = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToCartCubit, AddToCartState>(
      listenWhen: (previous, current) => true,
      listener: (context, state) {
        if (state is AddToCartStateLoading) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (state is AddToCartStateAdded) {
            Utils.showSnackBar(context, state.message);
          } else if (state is AddToCartStateError) {
            Utils.errorSnackBar(context, state.message);
          }
        }
      },
      child: Scaffold(
        body: BlocBuilder<HomeControllerCubit, HomeControllerState>(
          builder: (context, state) {
            log(state.toString(), name: _className);
            if (state is HomeControllerLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeControllerError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage,
                      style: const TextStyle(color: redColor),
                    ),
                    const SizedBox(height: 10),
                    IconButton(
                      onPressed: () {
                        context.read<HomeControllerCubit>().getHomeData();
                      },
                      icon: const Icon(Icons.refresh_outlined),
                    ),
                  ],
                ),
              );
            }

            if (state is HomeControllerLoaded) {
              return _LoadedHomePage(homeModel: state.homeModel);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _LoadedHomePage extends StatelessWidget {
  const _LoadedHomePage({
    Key? key,
    required this.homeModel,
  }) : super(key: key);

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name ?? '';
    const double appBarHeight = 140;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: appBarHeight,
          automaticallyImplyLeading: routeName != RouteNames.mainPage,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: redColor),
          flexibleSpace: const HomeAppBar(
            height: appBarHeight,
            logo: "assets/icons/icn.png",
          ),
        ),
        SliverToBoxAdapter(
          child: OfferBannerSlider(sliders: homeModel.sliders),
        ),

        //// dumy data list categoryList

        CategoryGridView(
          categoryList: homeModel.productCategories.take(12).toList(),
        ),

        SliverToBoxAdapter(
          child: SponsorComponent(brands: homeModel.brands),
        ),

        const CountDownOfferAndProduct(),

        CategoryAndListComponent(
          productList: homeModel.topProducts,
          category: "Popular",
          onTap: () {
            Navigator.pushNamed(context, RouteNames.allPopulerProductScreen);
          },
        ),

        SliverToBoxAdapter(
          child: HotDealBannerSlider(
            banners: homeModel.banners.take(5).toList(),
          ),
        ),

        FlashDealComponent(
          productList: homeModel.flashDealProducts,
          category: "Flash Deal",
          bgColor: const Color(0xff18587A),
          onTap: () {
            Navigator.pushNamed(context, RouteNames.allFlashDealProductScreen,
                arguments: homeModel.flashDealProducts);
          },
        ),
///
        CategoryAndListComponent(
          productList: homeModel.firstCategory.products,
          category: homeModel.firstCategory.name,
          onTap: () {
            Navigator.pushNamed(context, RouteNames.singleCategoryProductScreen,
                arguments: homeModel.firstCategory);
          },
        ),
        CategoryAndListComponent(
          productList: homeModel.secondCategory.products,
          category: homeModel.secondCategory.name,
          bgColor: const Color(0xffF1F5F7),
          onTap: () {
            Navigator.pushNamed(context, RouteNames.singleCategoryProductScreen,
                arguments: homeModel.secondCategory);
          },
        ),
        CategoryAndListComponent(
          productList: homeModel.thirdCategory.products,
          category: homeModel.thirdCategory.name,
          onTap: () {
            Navigator.pushNamed(context, RouteNames.singleCategoryProductScreen,
                arguments: homeModel.thirdCategory);
          },
        ),
        CategoryAndListComponent(
          productList: homeModel.fourthCategory.products,
          category: homeModel.fourthCategory.name,
          onTap: () {
            Navigator.pushNamed(context, RouteNames.singleCategoryProductScreen,
                arguments: homeModel.fourthCategory);
          },
        ),

        // NewArrivalComponent(productList: homeModel.newProducts),

        const SliverToBoxAdapter(child: SizedBox(height: 65)),
      ],
    );
  }
}

///
// mobile, bike, men's fashion, women, home and life style, babies and toys, electronics accessories, vehicle & accessories,