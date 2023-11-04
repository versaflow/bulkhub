import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/constants.dart';
import '../../widgets/app_bar_leading.dart';
import 'component/faq_app_bar.dart';
import 'component/faq_list_widget.dart';
import 'controllers/faq_cubit/faq_cubit.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double appBarHeight = 120;
    context.read<FaqCubit>().getFaqList();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: appBarHeight,
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: redColor),
            title: Text(
              'FAQ',
              style: TextStyle(color: Colors.white),
            ),
            titleSpacing: 0,
            leading: AppbarLeading(),
            flexibleSpace: FaqAppBar(height: appBarHeight),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
          BlocBuilder<FaqCubit, FaqCubitState>(
            builder: (context, state) {
              if (state is FaqCubitStateLoaded) {
                return FaqListWidget(faqList: state.faqList);
              } else if (state is FaqCubitStateLoading) {
                return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
              } else if (state is FaqCubitStateError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: redColor),
                    ),
                  ),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox());
            },
          ),
        ],
      ),
    );
  }
}
