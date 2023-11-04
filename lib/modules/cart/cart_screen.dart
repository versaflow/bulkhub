import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/please_signin_widget.dart';
import '../../widgets/rounded_app_bar.dart';
import 'component/add_to_cart_component.dart';
import 'component/panel_widget.dart';
import 'controllers/cart/cart_cubit.dart';
import 'model/cart_response_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CartCubit>().getCartProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Cart'),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (_, state) {
          if (state is CartStateDecIncrementLoading) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            if (state is CartStateDecIncretError) {
              Utils.errorSnackBar(context, state.message);
            }
          }
        },
        builder: (context, state) {
          if (state is CartStateLoading || state is CartStateInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartStateError) {
            if (state.statusCode == 401) {
              return const PleaseSigninWidget();
            }
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: redColor),
              ),
            );
          }
          return const _LoadedWidget();
        },
      ),
    );
  }
}

class _LoadedWidget extends StatefulWidget {
  const _LoadedWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_LoadedWidget> createState() => _LoadedWidgetState();
}

class _LoadedWidgetState extends State<_LoadedWidget> {
  final panelController = PanelController();

  final double height = 95;

  CartResponseModel? cartResponseModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        cartResponseModel = context.read<CartCubit>().cartResponseModel;

        if (cartResponseModel == null) return const SizedBox();

        return SlidingUpPanel(
          controller: panelController,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          panelBuilder: (sc) => PanelComponent(
            controller: sc,
            cartResponseModel: cartResponseModel!,
          ),
          minHeight: height,
          maxHeight: 350,
          backdropEnabled: true,
          backdropTapClosesPanel: true,
          parallaxEnabled: true,
          backdropOpacity: .0,
          collapsed: PannelCollapsComponent(
            height: height,
            cartResponseModel: cartResponseModel!,
          ),
          body: _buildBody(),
        );
      },
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
            child: Row(
              children: [
                const Icon(Icons.shopping_cart_rounded, color: redColor),
                const SizedBox(width: 10),
                Text(
                  _getText(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return AddToCartComponent(
                    product: cartResponseModel!.cartProducts[index]);
              },
              childCount: cartResponseModel!.cartProducts.length,
              addAutomaticKeepAlives: true,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 245)),
      ],
    );
  }

  String _getText() {
    final length = cartResponseModel!.cartProducts.length;
    if (length > 1) {
      return '$length Items in your cart';
    } else {
      return '$length Item in your cart';
    }
  }
}
