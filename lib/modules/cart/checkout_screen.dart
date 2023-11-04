import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rounded_app_bar.dart';
import 'component/address_card_component.dart';
import 'component/checkout_single_item.dart';
import 'component/shiping_method_list.dart';
import 'controllers/checkout/checkout_cubit.dart';
import 'model/checkout_response_model.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CheckoutCubit>().getCheckOutData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Checkout'),
      body: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutStateLoading || state is CheckoutStateInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CheckoutStateError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: redColor),
              ),
            );
          } else if (state is CheckoutStateLoaded) {
            return _LoadedWidget(
                checkoutResponseModel: state.checkoutResponseModel);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _LoadedWidget extends StatefulWidget {
  const _LoadedWidget({
    Key? key,
    required this.checkoutResponseModel,
  }) : super(key: key);

  final CheckoutResponseModel checkoutResponseModel;

  @override
  State<_LoadedWidget> createState() => _LoadedWidgetState();
}

class _LoadedWidgetState extends State<_LoadedWidget> {
  final double height = 140;

  final headerStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  late CheckoutResponseModel checkoutResponseModel;

  int shippingMethod = 0;
  int agreeTermsCondition = 1;
  @override
  void initState() {
    super.initState();
    checkoutResponseModel = widget.checkoutResponseModel;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildProductNumber()),
              _buildProductList(),
              SliverToBoxAdapter(child: _buildAddress()),

              SliverToBoxAdapter(
                child: ShippingMethodList(
                  shippingMethods: checkoutResponseModel.shippingMethods,
                  onChange: (int id) {
                    shippingMethod = id;
                  },
                ),
              ),
              // SliverToBoxAdapter(child: _buildPaymentList(context)),
              SliverToBoxAdapter(
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text("Agree with terms condition"),
                  value: agreeTermsCondition == 1 ? true : false,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  activeColor: redColor,
                  onChanged: (v) {
                    if (v != null) {
                      agreeTermsCondition = agreeTermsCondition == 1 ? 0 : 1;
                      setState(() {});
                    }
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
            ],
          ),
        ),
        _bottomBtn(),
      ],
    );
  }

  Widget _bottomBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total: ${Utils.formatPrice(checkoutResponseModel.totalAmount)} ",
                style: const TextStyle(color: redColor),
              ),
              const Text(
                " +shipping cost",
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Flexible(
            child: PrimaryButton(
              text: 'Place to Order',
              onPressed: () {
                if (agreeTermsCondition != 1) {
                  Utils.errorSnackBar(context, 'Please agree terms condition');
                  return;
                }
                if (checkoutResponseModel.billing == null) {
                  Utils.errorSnackBar(
                      context, 'Please add your billing address');
                  return;
                }
                if (checkoutResponseModel.shipping == null) {
                  Utils.errorSnackBar(
                      context, 'Please add your shipping address');
                  return;
                }
                Navigator.pushNamed(context, RouteNames.placeOrderScreen,
                    arguments: shippingMethod);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddress() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Address", style: headerStyle),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.addressScreen);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 22,
                  decoration: BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Center(
                    child: Text(
                      "Update Address",
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 9),
        if (checkoutResponseModel.shipping != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AddressCardComponent(
              addressModel: checkoutResponseModel.shipping!,
              type: 'shipping',
              pwidth: MediaQuery.of(context).size.width,
            ),
          ),
        ],
        const SizedBox(height: 8),
        if (checkoutResponseModel.billing != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AddressCardComponent(
              addressModel: checkoutResponseModel.billing!,
              type: 'billing',
              pwidth: MediaQuery.of(context).size.width,
            ),
          ),
        ]
      ],
    );
  }

  SliverPadding _buildProductList() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CheckoutSingleItem(
                product: checkoutResponseModel.cartProducts[index]);
          },
          childCount: checkoutResponseModel.cartProducts.length,
          addAutomaticKeepAlives: true,
        ),
      ),
    );
  }

  Widget _buildProductNumber() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
      child: Row(
        children: [
          const Icon(Icons.shopping_cart_rounded, color: redColor),
          const SizedBox(width: 10),
          Text(
            "${checkoutResponseModel.cartProducts.length} Products",
            style: headerStyle,
          ),
        ],
      ),
    );
  }
}
