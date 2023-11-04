import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../widgets/custom_image.dart';
import '../authentication/controller/login/login_bloc.dart';
import 'controller/app_setting_cubit/app_setting_cubit.dart';
import 'widgets/setting_error_widget.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  final _className = '_SplashScreenState';
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() {
      if (mounted) setState(() {});
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final appSettinBloc = context.read<AppSettingCubit>();
    final loginBloc = context.read<LoginBloc>();
    return Scaffold(
      body: BlocConsumer<AppSettingCubit, AppSettingState>(
        listener: (context, state) {

          log("listener $state", name: _className);
          if (state is AppSettingStateLoaded) {
            if (loginBloc.isLogedIn) {
              Navigator.pushReplacementNamed(context, RouteNames.mainPage);
            } else if (appSettinBloc.isOnBoardingShown) {
              Navigator.pushReplacementNamed(
                  context, RouteNames.authenticationScreen);
            } else {
              Navigator.pushReplacementNamed(
                  context, RouteNames.onboardingScreen);
            }
          }
        },
        builder: (context, state) {
          if (state is AppSettingStateError) {
            return SettingErrorWidget(message: state.meg);
          }
          return AnimationWidget(animation: animation);
        },
      ),
    );
  }
}

class AnimationWidget extends StatelessWidget {
  const AnimationWidget({
    Key? key,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [blackColor, blackColor],
            ),
          ),
          child: const CustomImage(path: Kimages.backgroundShape),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomImage(
              path: Kimages.logoIconBulk,
              width: animation.value * 250,
              height: animation.value * 250,
            ),
            const SizedBox(height: 50),
            const Center(child: CircularProgressIndicator())
          ],
        ),
      ],
    );
  }
}
