import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rounded_app_bar.dart';
import '../cart/component/address_card_component.dart';
import 'controllers/address/address_cubit.dart';
import 'model/billing_shipping_model.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    Future.microtask(() => context.read<AddressCubit>().getAddress());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Address'),
      body: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state is AddressStateUpdated) {
            context.read<AddressCubit>().getAddress();
          }
        },
        builder: (context, state) {
          log(state.toString(), name: 'address screen');
          if (state is AddressStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AddressStateError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: redColor),
              ),
            );
          } else if (state is AddressStateLoaded) {
            return _LoadedWidget(address: state.address);
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
    required this.address,
  }) : super(key: key);
  final BillingShipingModel address;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        if (address.billing != null) ...[
          AddressCardComponent(addressModel: address.billing!, type: "billing"),
        ] else ...[
          const Text('No Billing Address'),
          PrimaryButton(
            text: 'Add New Address',
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.addAddressScreen,
                  arguments: 'billing');
            },
          ),
        ],
        const SizedBox(height: 18),
        if (address.shipping != null) ...[
          AddressCardComponent(
              addressModel: address.shipping!, type: "shipping"),
        ] else ...[
          const Text('No Shipping Address'),
          PrimaryButton(
            text: 'Add New Address',
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.addAddressScreen,
                  arguments: 'shipping');
            },
          ),
        ],
        const SizedBox(height: 28),
      ],
    );
  }
}
