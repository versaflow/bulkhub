import 'package:flutter/material.dart';
import '../modules/authentication/authentication_screen.dart';
import '../modules/authentication/forgot_screen.dart';
import '../modules/authentication/setpassword_screen.dart';
import '../modules/authentication/verification_code_screen.dart';
import '../modules/category/all_category_list_screen.dart';
import '../modules/category/all_flash_deal_product_screen.dart';
import '../modules/category/model/product_categories_model.dart';
import '../modules/home/model/product_model.dart';
import '../modules/main_page/main_page.dart';
import '../modules/onboarding/onboarding_screen.dart';
import '../modules/order/model/product_order_model.dart';
import '../modules/order/order_screen.dart';
import '../modules/place_order/paypal_screen.dart';
import '../modules/place_order/place_order_screen.dart';
import '../modules/place_order/stripe_screen.dart';
import '../modules/product_details/model/details_product_reviews_model.dart';
import '../modules/product_details/review_list_screen.dart';
import '../modules/product_details/submit_feedback_screen.dart';
import '../modules/profile/address_screen.dart';
import '../modules/profile/change_password_screen.dart';
import '../modules/profile/payments_screen.dart';
import '../modules/search/product_search_screen.dart';
import '../modules/setting/about_us_screen.dart';
import '../modules/animated_splash_screen/animated_splash_screen.dart';
import '../modules/cart/cart_screen.dart';
import '../modules/cart/checkout_screen.dart';
import '../modules/category/all_populer_product_screen.dart';
import '../modules/category/signle_category_product_screen.dart';
import '../modules/home/home_screen.dart';
import '../modules/message/chat_list_screen.dart';
import '../modules/message/message_screen.dart';
import '../modules/notification/notigication_screen.dart';
import '../modules/product_details/product_details_screen.dart';
import '../modules/profile/profile_edit_screen.dart';
import '../modules/profile/profile_offer/profile_offer_screen.dart';
import '../modules/profile/profile_offer/wishlist_offer_screen.dart';
import '../modules/setting/add_address_screen.dart';
import '../modules/setting/add_new_payment_card_screen.dart';
import '../modules/setting/contact_us_screen.dart';
import '../modules/setting/faq_screen.dart';
import '../modules/setting/privacy_policy_screen.dart';
import '../modules/setting/setting_screen.dart';
import '../modules/setting/terms_condition_screen.dart';

class RouteNames {
  static const String onboardingScreen = '/onboardingScreen';
  static const String animatedSplashScreen = '/';
  static const String mainPage = '/mainPage';
  static const String homeScreen = '/homeScreen';
  static const String authenticationScreen = '/authenticationScreen';
  static const String forgotScreen = '/forgotScreen';
  static const String verificationCodeScreen = '/verificationCodeScreen';
  static const String setpasswordScreen = '/setpasswordScreen';
  static const String allCategoryListScreen = '/allCategoryListScreen';
  static const String allPopulerProductScreen = '/allPopulerProductScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String messageScreen = '/messageScreen';
  static const String chatListScreen = '/chatListScreen';
  static const String singleCategoryProductScreen =
      '/singleCategoryProductScreen';
  static const String orderScreen = '/orderScreen';
  static const String settingScreen = '/settingScreen';
  static const String termsConditionScreen = '/termsConditionScreen';
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String faqScreen = '/faqScreen';
  static const String aboutUsScreen = '/aboutUsScreen';
  static const String contactUsScreen = '/contactUsScreen';
  static const String profileEditScreen = '/profileEditScreen';
  static const String profileOfferScreen = '/profileOfferScreen';
  static const String wishlistOfferScreen = '/wishlistOfferScreen';
  static const String addAddressScreen = '/addAddressScreen';
  static const String addNewPaymentCardScreen = '/addNewPaymentCardScreen';
  static const String cartScreen = '/cartScreen';
  static const String checkoutScreen = '/checkoutScreen';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String submitFeedBackScreen = '/submitFeedBackScreen';
  static const String addressScreen = '/addressScreen';
  static const String paymentsScreen = '/paymentsScreen';
  static const String productSearchScreen = '/productSearchScreen';
  static const String allFlashDealProductScreen = '/allFlashDealProductScreen';
  static const String reviewListScreen = '/reviewListScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String placeOrderScreen = '/placeOrderScreen';
  static const String paypalScreen = '/paypalScreen';
  static const String stripeScreen = '/stripeScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onboardingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OnboardingScreen());
      case RouteNames.changePasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ChangePasswordScreen());
      case RouteNames.productSearchScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProductSearchScreen());

      case RouteNames.mainPage:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MainPage());
      case RouteNames.homeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
      case RouteNames.animatedSplashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AnimatedSplashScreen());
      case RouteNames.authenticationScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AuthenticationScreen());
      case RouteNames.forgotScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ForgotScreen());
      case RouteNames.verificationCodeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const VerificationCodeScreen());
      case RouteNames.setpasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SetpasswordScreen());

      case RouteNames.allCategoryListScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AllCategoryListScreen());
      case RouteNames.allPopulerProductScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const AllPopulerProductScreen());
      case RouteNames.singleCategoryProductScreen:
        final category = settings.arguments as ProductCategoriesModel;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SingleCategoryProductScreen(categoryModel: category),
        );
      case RouteNames.allFlashDealProductScreen:
        final products = settings.arguments as List<ProductModel>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AllFlashDealProductScreen(products: products),
        );
      case RouteNames.notificationScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const NotificationScreen());
      case RouteNames.messageScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MessageScreen());
      case RouteNames.chatListScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ChatListScreen());
      case RouteNames.orderScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OrderScreen());
      case RouteNames.settingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SettingScreen());
      case RouteNames.termsConditionScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const TermsConditionScreen());
      case RouteNames.privacyPolicyScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PrivacyPolicyScreen());
      case RouteNames.faqScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const FaqScreen());
      case RouteNames.aboutUsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AboutUsScreen());
      case RouteNames.contactUsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ContactUsScreen());
      case RouteNames.profileEditScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProfileEditScreen());
      case RouteNames.profileOfferScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProfileOfferScreen());
      case RouteNames.wishlistOfferScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const WishlistOfferScreen());
      case RouteNames.paymentsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PaymentsScreen());
      case RouteNames.addressScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AddressScreen());
      case RouteNames.addAddressScreen:
        final type = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => AddAddressScreen(type: type));
      case RouteNames.addNewPaymentCardScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const AddNewPaymentCardScreen());
      case RouteNames.cartScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CartScreen());
      case RouteNames.checkoutScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CheckoutScreen());
      case RouteNames.productDetailsScreen:
        final slug = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ProductDetailsScreen(slug: slug));
      case RouteNames.reviewListScreen:
        final productReviews =
            settings.arguments as List<DetailsProductReviewModel>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SeelAllReviewsScreen(productReviews: productReviews),
        );

      case RouteNames.submitFeedBackScreen:
        final orderItem = settings.arguments as OrderedProductModel;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SubmitFeedBackScreen(orderItem: orderItem),
        );

      case RouteNames.placeOrderScreen:
        final shippingMethod = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => PlaceOrderScreen(shippingMethodId: shippingMethod),
        );
      case RouteNames.paypalScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => PaypalScreen(url: paypalUrl),
        );
      case RouteNames.stripeScreen:
        final shippingId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => StripeScreen(shippingMethodId: shippingId),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
