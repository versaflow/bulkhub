import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../category/component/product_card.dart';
import '../controller/cubit/home_controller_cubit.dart';
import 'time_count_down.dart';

class CountDownOfferAndProduct extends StatelessWidget {
  const CountDownOfferAndProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeModel = context.read<HomeControllerCubit>().homeModel;
    // final campaign = homeModel.campaign;
    // var productList = homeModel.campaignProducts;
    // if (productList.isEmpty) return const SliverToBoxAdapter();

    return MultiSliver(
      children: [
        // SliverToBoxAdapter(child: TimeCountDownComponent(campaign: campaign)),
        // SliverToBoxAdapter(
        //   child: Container(
        //     color: const Color(0xffE8EEF2),
        //     height: 255,
        //     padding: const EdgeInsets.only(bottom: 5),
        //     child: ListView.separated(
        //       separatorBuilder: ((context, index) => const SizedBox(width: 16)),
        //       scrollDirection: Axis.horizontal,
        //       padding: const EdgeInsets.all(20),
        //       itemCount: productList.length,
        //       itemBuilder: (context, index) => ProductCard(
        //           productModel: productList[index].product, width: 180),
        //     ),
        //   ),
        // ),
        const SliverToBoxAdapter(child: SizedBox(height: 5)),
      ],
    );
  }
}
