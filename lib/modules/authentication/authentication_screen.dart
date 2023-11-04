import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/remote_urls.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_image.dart';
import '../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import 'controller/login/login_bloc.dart';
import 'controller/sign_up/sign_up_bloc.dart';
import 'widgets/sign_in_form.dart';
import 'widgets/sign_up_form.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
    //   if (context.read<LoginBloc>().isLogedIn) {
    //     Navigator.pushReplacementNamed(context, RouteNames.mainPage);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final appSetting = context.read<AppSettingCubit>();
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginModelState>(
          listenWhen: (previous, current) => previous.state != current.state,
          listener: (context, state) {
            if (state.state is LoginStateError) {
              final status = state.state as LoginStateError;

              if (status.statusCode == 402) {
                Utils.showSnackBarWithAction(
                  context,
                  status.errorMsg,
                  () {
                    context
                        .read<LoginBloc>()
                        .add(const SentAccountActivateCodeSubmit());
                    Navigator.pushNamed(
                        context, RouteNames.verificationCodeScreen);
                  },
                );
              } else {
                Utils.errorSnackBar(context, status.errorMsg);
              }
            } else if (state.state is LoginStateLoaded) {
              Navigator.pushReplacementNamed(context, RouteNames.mainPage);
            } else if (state.state is SendAccountCodeSuccess) {
              final messageState = state.state as SendAccountCodeSuccess;
              Utils.showSnackBar(context, messageState.msg);
            } else if (state.state is AccountActivateSuccess) {
              final messageState = state.state as AccountActivateSuccess;
              Utils.showSnackBar(context, messageState.msg);
              Navigator.pop(context);
            }
          },
        ),
        BlocListener<SignUpBloc, SignUpModelState>(
          listenWhen: (previous, current) {
            return previous.state != current.state;
          },
          listener: (context, state) {
            if (state.state is SignUpStateLoadedError) {
              final status = state.state as SignUpStateLoadedError;
              Utils.errorSnackBar(context, status.errorMsg);
            } else if (state.state is SignUpStateFormError) {
              final status = state.state as SignUpStateFormError;
              Utils.showSnackBar(context, status.errorMsg);
            } else if (state.state is SignUpStateLoaded) {
              final loadedData = state.state as SignUpStateLoaded;
              Navigator.pushNamed(context, RouteNames.verificationCodeScreen);
              Utils.showSnackBar(context, loadedData.msg);
            }
          },
        ),
      ],
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xffFFEFE7)],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // CustomImage(
                    //   path: RemoteUrls.imageUrl(appSetting.settingModel!.logo),
                    //   width: 280,
                    //   height: 110,
                    // ),
                    const SizedBox(height: 30),
                    _buildHeader(),
                    const SizedBox(height: 15),
                    _buildTabText(),
                    SizedBox(
                      height: 520,
                      child: PageView(
                        physics: const ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: const [SigninForm(), SignUpForm()],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.topLeft,
      duration: kDuration,
      child: Text(
        _currentPage == 0 ? 'Welcome back!' : 'Create Aceount',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
    );
  }

  Widget _buildTabText() {
    const tabunSelectedtextColor = Color(0xff797979);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              _pageController.animateToPage(0,
                  duration: kDuration, curve: Curves.bounceInOut);
            },
            child: Text(
              'Sign In',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color:
                      _currentPage == 0 ? blackColor : tabunSelectedtextColor),
            ),
          ),
          Container(
            color: borderColor,
            width: 1,
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          InkWell(
            onTap: () {
              _pageController.animateToPage(1,
                  duration: kDuration, curve: Curves.bounceInOut);
            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color:
                      _currentPage == 1 ? blackColor : tabunSelectedtextColor),
            ),
          ),
        ],
      ),
    );
  }
}
