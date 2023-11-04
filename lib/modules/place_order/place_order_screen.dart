import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/remote_urls.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widgets/rounded_app_bar.dart';
import '../authentication/controller/login/login_bloc.dart';
import 'controllers/cash_on_payment/cash_on_payment_cubit.dart';
import 'controllers/payment_info/payment_info_cubit.dart';
import 'controllers/stripe/stripe_cubit.dart';
import 'model/payment_info_model.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({
    Key? key,
    required this.shippingMethodId,
  }) : super(key: key);

  final int shippingMethodId;

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PaymentCubit>().getPaymentInfo(widget.shippingMethodId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Place Order'),
      body: BlocBuilder<PaymentCubit, PaymentInfoState>(
        builder: (context, state) {
          if (state is PaymentInfoLoading || state is PaymentInfoInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PaymentInfoError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: redColor),
              ),
            );
          } else if (state is PaymentInfoLoaded) {
            return _LoadedWidget(
                shippingMethodId: widget.shippingMethodId,
                paymentInfoModel: state.paymentInfoModel);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _LoadedWidget extends StatelessWidget {
  const _LoadedWidget({
    Key? key,
    required this.shippingMethodId,
    required this.paymentInfoModel,
  }) : super(key: key);

  final int shippingMethodId;
  final PaymentInfoModel paymentInfoModel;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CashOnPaymentCubit, CashPaymentState>(
          listener: (context, state) {
            if (state is CashPaymentStateLoading) {
              Utils.loadingDialog(context);
            } else {
              Utils.closeDialog(context);
              if (state is CashPaymentStateLoaded) {
                Utils.showSnackBar(context, state.message);
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.orderScreen, (route) {
                  if (route.settings.name == RouteNames.mainPage) {
                    return true;
                  }
                  return false;
                });
              } else if (state is CashPaymentStateError) {
                Utils.errorSnackBar(context, state.message);
              }
            }
          },
        ),
        BlocListener<StripeCubit, StripeState>(
          listener: (context, state) {
            if (state is StripeLoading) {
              Utils.loadingDialog(context);
            } else {
              Utils.closeDialog(context);
              if (state is StripeLoaded) {
                Utils.showSnackBar(context, state.message);
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.orderScreen, (route) {
                  if (route.settings.name == RouteNames.mainPage) {
                    return true;
                  }
                  return false;
                });
              }
              if (state is StripeError) {
                Utils.errorSnackBar(context, state.message);
              }
            }
          },
        ),
        // BlocListener<PaymentCubit, PaymentState>(
        //   listener: (context, state) {
        //     if (state is PaymentLoading) {
        //       Utils.loadingDialog(context);
        //     } else {
        //       Utils.closeDialog(context);
        //       if (state is PaymentLoaded) {
        //         Utils.showSnackBar(context, state.transactionResponse.message!);
        //       } else if (state is PaymentError) {
        //         Utils.errorSnackBar(context, state.message);
        //       }
        //     }
        //   },
        // ),
      ],
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  "Payment Method",
                  style: TextStyle(fontSize: 16, color: redColor),
                ),
                const SizedBox(height: 10),
                // InkWell(
                //   onTap: () {
                //     showAlertDialog(context);
                //   },
                //   child: const Padding(
                //     padding: EdgeInsets.all(8.0),
                //     child: Text(
                //       "Cash on Delivery",
                //       style: TextStyle(fontWeight: FontWeight.w600),
                //     ),
                //   ),
                // ),
                PaymentCard(
                  title: "Cash On Delivery",
                  icon: Kimages.codIcon,
                  press: () {
                    showAlertDialog(context);
                  }
                ),
                ...payMethodButton(paymentInfoModel.paymentInfo, context),
              ],
            ),
          ),
          _bottomBtn(),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Sure"),
      onPressed: () {
        context.read<CashOnPaymentCubit>().cashOnDelivery();
        Navigator.pop(context);
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Order Confirm"),
      content: const Text("Are you sure, you want to confirm your order"),
      actions: [cancelButton, okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }

  Widget _bottomBtn() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            "Total: ${Utils.formatPrice(paymentInfoModel.totalAmount)} ",
            style: const TextStyle(
                color: redColor, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const Text(
            '+ shipping charge',
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }

  List<Widget> payMethodButton(List<String> payMethod, BuildContext context) {
    List<Widget> child = [];

    for (var element in payMethod) {
      if (element.contains('paypal')) {
        child.add(
          PaymentCard(
            title: "Pay With Paypal",
            icon: Kimages.paypalIcon,
            press: () {
              final token = context.read<LoginBloc>().userInfo!.accessToken;
              Navigator.pushNamed(context, RouteNames.paypalScreen,
                  arguments:
                      RemoteUrls.payWithPaypal(token, "$shippingMethodId"));
            },
          ),
        );
      } else if (element.contains('stripe')) {
        child.add(
          PaymentCard(
            title: "Pay With Card",
            icon: Kimages.stripeIcon,
            press: () {
              Navigator.pushNamed(context, RouteNames.stripeScreen,
                  arguments: "$shippingMethodId");
              // context.read<PaymentCubit>().makePayment(200);
            },
          ),
        );
      }
    }

    return child;
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    Key? key,
    this.title,
    this.icon,
    this.press,
  }) : super(key: key);

  final String? title;
  final String? icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            color: redColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: redColor.withOpacity(0.1),
              width: 1,
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: SvgPicture.asset(icon!)),
            Expanded(
              flex: 3,
              child: Text(
                title!,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
