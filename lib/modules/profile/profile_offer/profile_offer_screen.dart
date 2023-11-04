import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/rounded_app_bar.dart';
import '../../home/component/hot_deal_banner.dart';
import '../../home/controller/cubit/home_controller_cubit.dart';

class ProfileOfferScreen extends StatelessWidget {
  const ProfileOfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final banners = context.read<HomeControllerCubit>().homeModel.banners;
    return Scaffold(
      appBar: RoundedAppBar(titleText: "My Offers"),
      body: ListView.separated(
        separatorBuilder: (_, __) {
          return const SizedBox(height: 16);
        },
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
        itemBuilder: (context, index) {
          return HotDealBanner(
            banner: banners[index],
            height: 150,
          );
        },
        itemCount: banners.length,
      ),
    );
  }
}
