import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/rounded_app_bar.dart';
import '../home/controller/cubit/home_controller_cubit.dart';
import 'component/populer_product_card.dart';

class AllPopulerProductScreen extends StatelessWidget {
  const AllPopulerProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final populerProductList =
        context.read<HomeControllerCubit>().homeModel.topProducts;
    return Scaffold(
      appBar: RoundedAppBar(
        titleText: "All Populer",
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemCount: populerProductList.length,

        ///dummy data list populerProductList
        itemBuilder: (context, index) =>
            PopulerProductCard(productModel: populerProductList[index]),
      ),
    );
  }
}
