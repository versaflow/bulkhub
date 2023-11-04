import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/remote_urls.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/please_signin_widget.dart';
import '../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../authentication/controller/login/login_bloc.dart';
import 'component/profile_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final _className = 'ProfileScreen';

  @override
  Widget build(BuildContext context) {
    final userData = context.read<LoginBloc>().userInfo;
    final settingModel = context.read<AppSettingCubit>().settingModel;
    const double appBarHeight = 180;
    final routeName = ModalRoute.of(context)?.settings.name ?? '';

    if (userData == null) {
      return const PleaseSigninWidget();
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: const IconThemeData(color: primaryColor),
            automaticallyImplyLeading: routeName != RouteNames.mainPage,
            expandedHeight: appBarHeight,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: redColor,
            ),
            flexibleSpace: ProfileAppBar(
                height: appBarHeight,
                logo: "assets/icons/icn.png",
                userData: userData),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          _buildProfileOptions(context),
          const SliverToBoxAdapter(child: SizedBox(height: 65)),
        ],
      ),
    );
  }

  SliverPadding _buildProfileOptions(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.addressScreen);
              },
              contentPadding: EdgeInsets.zero,
              leading: const CustomImage(path: Kimages.profileLocationIcon, color: redColor,),
              title:  Text('Your Address', style: textStyle()),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.allCategoryListScreen);
              },
              contentPadding: EdgeInsets.zero,
              leading: const CustomImage(path: Kimages.profileCategoryIcon, color: redColor),
              title:  Text('All Categories', style: textStyle()),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.notificationScreen);
              },
              contentPadding: EdgeInsets.zero,
              leading: const CustomImage(path: Kimages.profileNotificationIcon, color: redColor),
              title:  Text('Notifications', style: textStyle()),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.chatListScreen);
              },
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              leading: const CustomImage(path: Kimages.profileChatIcon, color: redColor),
              title:  Text('Chats', style: textStyle()),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.paymentsScreen);
              },
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              leading: const CustomImage(path: Kimages.paymentIcon, color: redColor),
              title:
                   Text('Payment Methods', style: textStyle()),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.changePasswordScreen);
              },
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.password_outlined, color: redColor),
              title:
                   Text('Change password', style: textStyle()),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.settingScreen);
              },
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              leading: const CustomImage(path: Kimages.profileSettingIcon, color: redColor),
              title:  Text('Settings', style: textStyle()),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.termsConditionScreen);
              },
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              leading:
                  const CustomImage(path: Kimages.profileTermsConditionIcon, color: redColor),
              title:  Text('Terms & Condition',
                  style: textStyle()),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.privacyPolicyScreen);
              },
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              leading: const CustomImage(path: Kimages.profilePrivacyIcon, color: redColor),
              title:
                   Text('Privacy Policy', style: textStyle()),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.faqScreen);
              },
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              leading: const CustomImage(path: Kimages.profileFaqIcon, color: redColor),
              title:  Text('FAQ', style: textStyle()),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.aboutUsScreen);
              },
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              leading: const CustomImage(path: Kimages.profileAboutUsIcon, color: redColor),
              title:  Text('About Us', style: textStyle()),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.contactUsScreen);
              },
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              leading: const CustomImage(path: Kimages.profileContactIcon, color: redColor),
              title:  Text('Contact Us', style: textStyle()),
            ),
             ListTile(
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              leading: const CustomImage(path: Kimages.profileAppInfoIcon, color: redColor),
              title: Text('App Info', style: textStyle()),
            ),
            BlocBuilder<LoginBloc, LoginModelState>(builder: (context, state) {
              if (state.state is LoginStateLogOutLoading) {
                const CircularProgressIndicator();
              }
              return ListTile(
                minLeadingWidth: 0,
                contentPadding: EdgeInsets.zero,
                leading: const CustomImage(path: Kimages.profileLogOutIcon, color: redColor),
                title:  Text('Sign Out', style: textStyle()),
                onTap: () {
                  context.read<LoginBloc>().add(const LoginEventLogout());
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  TextStyle textStyle() => TextStyle(fontSize: 16, color: grayColor);
}
