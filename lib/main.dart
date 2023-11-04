import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/data/datasources/remote_data_source.dart';
import 'core/data/datasources/local_data_source.dart';
import 'core/router_name.dart';
import 'modules/animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import 'modules/animated_splash_screen/controller/repository/app_setting_repository.dart';
import 'modules/authentication/controller/forgot_password/forgot_password_cubit.dart';
import 'modules/authentication/controller/login/login_bloc.dart';
import 'modules/authentication/controller/sign_up/sign_up_bloc.dart';
import 'modules/authentication/repository/auth_repository.dart';
import 'modules/cart/controllers/cart/add_to_cart/add_to_cart_cubit.dart';
import 'modules/cart/controllers/cart/cart_cubit.dart';
import 'modules/cart/controllers/cart_repository.dart';
import 'modules/cart/controllers/checkout/checkout_cubit.dart';
import 'modules/place_order/controllers/payment_info/payment_info_cubit.dart';
import 'modules/place_order/controllers/payment_repository.dart';
import 'modules/home/controller/cubit/home_controller_cubit.dart';
import 'modules/home/controller/repository/home_repository.dart';
import 'modules/order/controllers/order/order_cubit.dart';
import 'modules/order/repository/order_repository.dart';
import 'modules/place_order/controllers/cash_on_payment/cash_on_payment_cubit.dart';

import 'modules/place_order/controllers/stripe/stripe_cubit.dart';
import 'modules/product_details/controller/cubit/product_details_cubit.dart';
import 'modules/product_details/controller/repository/product_details_repository.dart';
import 'modules/product_details/controller/repository/review_submit_repository.dart';
import 'modules/product_details/controller/review/review_cubit.dart';
import 'modules/profile/controllers/address/address_cubit.dart';
import 'modules/profile/controllers/change_password/change_password_cubit.dart';
import 'modules/profile/controllers/country_state_by_id/country_state_by_id_cubit.dart';
import 'modules/profile/controllers/profile_edit/profile_edit_cubit.dart';
import 'modules/profile/profile_offer/controllers/wish_list/wish_list_cubit.dart';
import 'modules/profile/repository/profile_repository.dart';
import 'modules/search/controllers/search/search_bloc.dart';
import 'modules/search/controllers/search_repository.dart';
import 'modules/setting/controllers/about_us_cubit/about_us_cubit.dart';
import 'modules/setting/controllers/contact_us_cubit/contact_us_cubit.dart';
import 'modules/setting/controllers/contact_us_form_bloc/contact_us_form_bloc.dart';
import 'modules/setting/controllers/faq_cubit/faq_cubit.dart';
import 'modules/setting/controllers/privacy_and_term_condition_cubit/privacy_and_term_condition_cubit.dart';
import 'modules/setting/controllers/repository/setting_repository.dart';
import 'utils/k_strings.dart';
import 'utils/my_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late final SharedPreferences _sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  _sharedPreferences = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        ///network client
        RepositoryProvider<Client>(
          create: (context) => Client(),
        ),
        RepositoryProvider<SharedPreferences>(
          create: (context) => _sharedPreferences,
        ),

        ///data source repository
        RepositoryProvider<RemoteDataSource>(
          create: (context) => RemoteDataSourceImpl(client: context.read()),
        ),

        RepositoryProvider<LocalDataSource>(
          create: (context) =>
              LocalDataSourceImpl(sharedPreferences: context.read()),
        ),

        ///repository
        RepositoryProvider<HomeRepository>(
          create: (context) =>
              HomeRepositoryImp(remoteDataSource: context.read()),
        ),

        RepositoryProvider<SettingRepository>(
          create: (context) =>
              SettingRepositoryImp(remoteDataSource: context.read()),
        ),
        RepositoryProvider<ProductDetailsRepository>(
          create: (context) =>
              ProductDetailsRepositoryImp(remoteDataSource: context.read()),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImp(
            remoteDataSource: context.read(),
            localDataSource: context.read(),
          ),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepositoryImp(
            remoteDataSource: context.read(),
            localDataSource: context.read(),
          ),
        ),
        RepositoryProvider<AppSettingRepository>(
          create: (context) => AppSettingRepositoryImp(
            remoteDataSource: context.read(),
            localDataSource: context.read(),
          ),
        ),
        RepositoryProvider<OrderRepository>(
          create: (context) => OrderRepositoryImp(context.read()),
        ),
        RepositoryProvider<SearchRepository>(
          create: (context) =>
              SearchRepositoryImp(remoteDataSource: context.read()),
        ),
        RepositoryProvider<CartRepository>(
          create: (context) => CartRepositoryImp(context.read()),
        ),
        RepositoryProvider<PaymentRepository>(
          create: (context) => PaymentRepositoryImp(context.read()),
        ),
        RepositoryProvider<SubmitReviewRepository>(
          create: (context) =>
              SubmitReviewRepositoryImp(remoteDataSource: context.read()),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<HomeControllerCubit>(
              create: (BuildContext context) =>
                  HomeControllerCubit(context.read()),
            ),
            BlocProvider<AboutUsCubit>(
              create: (BuildContext context) => AboutUsCubit(context.read()),
            ),
            BlocProvider<FaqCubit>(
              create: (BuildContext context) => FaqCubit(context.read()),
            ),
            BlocProvider<PrivacyAndTermConditionCubit>(
              create: (BuildContext context) =>
                  PrivacyAndTermConditionCubit(context.read()),
            ),
            BlocProvider<ContactUsCubit>(
              create: (BuildContext context) => ContactUsCubit(context.read()),
            ),
            BlocProvider<ContactUsCubit>(
              create: (BuildContext context) => ContactUsCubit(context.read()),
            ),
            BlocProvider<ContactUsFormBloc>(
              create: (BuildContext context) =>
                  ContactUsFormBloc(context.read()),
            ),
            BlocProvider<ProductDetailsCubit>(
              create: (BuildContext context) =>
                  ProductDetailsCubit(context.read()),
            ),
            BlocProvider<LoginBloc>(
              create: (BuildContext context) => LoginBloc(
                profileRepository: context.read(),
                authRepository: context.read(),
              ),
            ),
            BlocProvider<SignUpBloc>(
              create: (BuildContext context) => SignUpBloc(context.read()),
            ),
            BlocProvider<ForgotPasswordCubit>(
              create: (BuildContext context) =>
                  ForgotPasswordCubit(context.read()),
            ),
            BlocProvider<AppSettingCubit>(
              create: (BuildContext context) => AppSettingCubit(context.read()),
            ),
            BlocProvider<ChangePasswordCubit>(
              create: (BuildContext context) => ChangePasswordCubit(
                loginBloc: context.read(),
                profileRepository: context.read(),
              ),
            ),
            BlocProvider<ProfileEditCubit>(
              create: (BuildContext context) => ProfileEditCubit(
                loginBloc: context.read(),
                profileRepository: context.read(),
              ),
              lazy: true,
            ),
            BlocProvider<CountryStateByIdCubit>(
              create: (BuildContext context) => CountryStateByIdCubit(
                loginBloc: context.read(),
                profileRepository: context.read(),
              ),
              lazy: true,
            ),
            BlocProvider<OrderCubit>(
              create: (BuildContext context) => OrderCubit(
                loginBloc: context.read(),
                orderRepository: context.read(),
              ),
              lazy: true,
            ),
            BlocProvider<AddressCubit>(
              create: (BuildContext context) => AddressCubit(
                loginBloc: context.read(),
                profileRepository: context.read(),
              ),
              lazy: true,
            ),
            BlocProvider<WishListCubit>(
              create: (BuildContext context) => WishListCubit(
                loginBloc: context.read(),
                profileRepository: context.read(),
              ),
            ),
            BlocProvider<SearchBloc>(
              create: (context) => SearchBloc(
                searchRepository: context.read(),
              ),
            ),
            BlocProvider<CartCubit>(
              create: (context) => CartCubit(
                cartRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
            BlocProvider<PaymentCubit>(
              create: (context) => PaymentCubit(
                paymentRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
            BlocProvider<SubmitReviewCubit>(
              create: (context) => SubmitReviewCubit(
                repository: context.read(),
                loginBloc: context.read(),
              ),
            ),
            BlocProvider<AddToCartCubit>(
              create: (context) => AddToCartCubit(
                cartRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
            BlocProvider<CheckoutCubit>(
              create: (context) => CheckoutCubit(
                cartRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
            BlocProvider<CashOnPaymentCubit>(
              create: (context) => CashOnPaymentCubit(
                paymentRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
            BlocProvider<StripeCubit>(
              create: (context) => StripeCubit(
                paymentRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Kstrings.appName,
            theme: MyTheme.theme,
            onGenerateRoute: RouteNames.generateRoute,
            initialRoute: RouteNames.animatedSplashScreen,
            onUnknownRoute: (RouteSettings settings) {
              return MaterialPageRoute(
                builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ),
              );
            },
            builder: (context, child) {
              return MediaQuery(
                child: child!,
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              );
            },
          )),
    );
  }
}
