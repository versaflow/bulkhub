class RemoteUrls {
  static const String rootUrl = "https://www.bulkhub.co.za/";
  // static const String rootUrl = "https://storestay.com/";
  static const String baseUrl = rootUrl + "api/";
  static const String homeUrl = baseUrl;
  static const String userRegister = baseUrl + 'store-register';
  static const String userLogin = baseUrl + 'store-login';
  static String userLogOut(String token) =>
      baseUrl + 'user/logout?token=$token';
  static const String sendForgetPassword = baseUrl + 'send-forget-password';
  static const String resendRegisterCode = baseUrl + 'resend-register-code';
  static String storeResetPassword(String code) =>
      baseUrl + 'store-reset-password/$code';

  static String userVerification(String code) =>
      baseUrl + 'user-verification/$code';
  static String userProfile(String token) =>
      baseUrl + 'user/my-profile?token=$token';
  static String updateProfile(String token) =>
      baseUrl + 'user/update-profile?token=$token';
  static String changePassword(String token) =>
      baseUrl + 'user/update-password?token=$token';
  static String stateByCountryId(String countryId, String token) =>
      baseUrl + 'user/state-by-country/$countryId?token=$token';
  static String citiesByStateId(String stateId, String token) =>
      baseUrl + 'user/city-by-state/$stateId?token=$token';
  static String orderList(String token) => baseUrl + 'user/order?token=$token';
  static const String aboutUs = baseUrl + 'about-us';
  static const String faq = baseUrl + 'faq';
  static const String termsAndConditions = baseUrl + 'terms-and-conditions';
  static const String privacyPolicy = baseUrl + 'privacy-policy';
  static const String contactUs = baseUrl + 'contact-us';
  static const String sendContactMessage = baseUrl + 'send-contact-message';
  static const String websiteSetup = baseUrl + 'website-setup';
  static String productDetail(String slug) =>
      baseUrl + 'product-detail/' + slug;
  static String address(String token) =>
      baseUrl + 'user/address?token=' + token;
  static String billingAddress(String token) =>
      baseUrl + 'user/update-billing-address?token=' + token;
  static String shippingAddress(String token) =>
      baseUrl + 'user/update-shipping-address?token=' + token;
  static String wishList(String token) =>
      baseUrl + 'user/wishlist?token=' + token;
  static String removeWish(int id, String token) =>
      baseUrl + 'user/remove-wishlist/$id?token=' + token;
  static String addWish(int id, String token) =>
      baseUrl + 'user/add-to-wishlist/$id?token=' + token;
  static const String searchProduct = baseUrl + 'product?';
  static String cartProduct(String token) => baseUrl + "cart?token=$token";

  static String submitReviewUrl(String token) =>
      baseUrl + 'user/store-product-review?token=$token';

  static String cartCheckout(String token) =>
      baseUrl + "user/checkout?token=$token";
  static String cartPaymentInfo(String token, int shippingId) =>
      baseUrl +
      "user/checkout/payment?token=$token&shipping_method=$shippingId";
  static String incrementQuantity(String id, String token) =>
      baseUrl + "cart-update/$id?token=$token";
  static String decrementQuantity(String id, String token) =>
      baseUrl + "cart-decrement/$id?token=$token";
  static String applyCoupon(String coupon, String token) =>
      baseUrl + "apply-coupon?coupon=$coupon&token=$token";
  static String removeCartItem(String id, String token) =>
      baseUrl + "cart-item-remove/$id?token=$token";
  static const String addToCart = baseUrl + 'add-to-cart?';
  static const String cashOnDelivery =
      baseUrl + 'user/checkout/cash-on-delivery?';
  static String payWithStripe(String token) =>
      baseUrl + 'user/checkout/pay-with-stripe?token=$token';
  static String payWithPaypal(String token, String shippingId) =>
      rootUrl +
      'user/checkout/paypal-web-view?token=$token&shipping_method=$shippingId&agree_terms_condition=1';

  static   imageUrl(String imageUrl) => rootUrl + imageUrl;
}
