import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/router_name.dart';
import '../../utils/utils.dart';
import '../authentication/controller/login/login_bloc.dart';
import '../cart/controllers/cart/cart_cubit.dart';
import '../home/controller/cubit/home_controller_cubit.dart';
import '../home/home_screen.dart';
import '../order/order_screen.dart';
import '../profile/profile_screen.dart';
import 'component/bottom_navigation_bar.dart';
import 'main_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _homeController = MainController();

  late List<Widget> pageList;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<LoginBloc>().add(const LoginEventCheckProfile());
      context.read<HomeControllerCubit>().getHomeData();
      context.read<CartCubit>().getCartProducts();
    });

    pageList = [
      const HomeScreen(),
      // const ChatListScreen(),
      const OrderScreen(),
      const ProfileScreen(),
    ];
  }

  final _className = "MainPage";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      initialData: 0,
      stream: _homeController.naveListener.stream,
      builder: (context, AsyncSnapshot<int> snapshot) {
        int index = snapshot.data ?? 0;

        return BlocListener<LoginBloc, LoginModelState>(
          key: UniqueKey(),
          listener: (context, state) {
            log(state.state.toString(), name: _className);
            if (state.state is LoginStateLogOut) {
              Utils.closeDialog(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.authenticationScreen, (route) => false);
            } else if (state.state is LoginStateLogOutLoading) {
              Utils.loadingDialog(context);
            } else if (state.state is LoginStateSignOutError) {
              final currentState = state.state as LoginStateSignOutError;
              Utils.closeDialog(context);
              Utils.errorSnackBar(context, currentState.errorMsg);
            }
          },
          child: Scaffold(
            extendBody: true,
            key: UniqueKey(),
            body: IndexedStack(
              index: index,
              children: pageList,
            ),
            bottomNavigationBar: MyBottomNavigationBar(
                mainController: _homeController, selectedIndex: index),
          ),
        );
      },
    );
  }
}
