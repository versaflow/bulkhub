import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../modules/authentication/models/set_password_model.dart';
import '../../../modules/authentication/models/user_login_response_model.dart';
import '../../../modules/cart/model/cart_response_model.dart';
import '../../../modules/cart/model/checkout_response_model.dart';
import '../../../modules/home/model/home_model.dart';
import '../../../modules/home/model/setting_model.dart';
import '../../../modules/order/model/order_model.dart';
import '../../../modules/cart/model/add_to_cart_model.dart';
import '../../../modules/place_order/model/payment_info_model.dart';
import '../../../modules/product_details/model/product_details_model.dart';
import '../../../modules/product_details/model/submit_review_response.dart';
import '../../../modules/profile/controllers/change_password/change_password_cubit.dart';
import '../../../modules/profile/controllers/profile_edit/profile_edit_cubit.dart';
import '../../../modules/profile/model/billing_shipping_model.dart';
import '../../../modules/profile/model/city_model.dart';
import '../../../modules/profile/model/country_state_model.dart';
import '../../../modules/profile/model/user_with_country_response.dart';
import '../../../modules/profile/profile_offer/model/wish_list_model.dart';
import '../../../modules/search/model/search_response_model.dart';
import '../../../modules/setting/model/about_us_model.dart';
import '../../../modules/setting/model/contact_us_mesage_model.dart';
import '../../../modules/setting/model/contact_us_mode.dart';
import '../../../modules/setting/model/faq_model.dart';
import '../../../modules/setting/model/privacy_policy_model.dart';
import '../../error/exception.dart';
import '../../remote_urls.dart';

abstract class RemoteDataSource {
  Future<UserLoginResponseModel> signIn(Map<String, dynamic> body);
  Future<UserWithCountryResponse> userProfile(String token);
  Future<String> passwordChange(
      ChangePasswordStateModel changePassData, String token);
  Future<String> profileUpdate(ProfiltEditStateModel user, String token);
  Future<String> sendForgotPassCode(Map<String, dynamic> body);
  Future<String> setPassword(SetPasswordModel body);
  Future<String> sendActiveAccountCode(String email);
  Future<String> activeAccountCodeSubmit(String code);
  Future<String> logOut(String tokne);
  Future<HomeModel> getHomeData();
  Future<SettingModel> websiteSetup();
  Future<String> userRegister(Map<String, dynamic> userInfo);

  Future<AboutUsModel> getAboutUsData();
  Future<List<FaqModel>> getFaqList();
  Future<PrivacyPolicyAndTermConditionModel> getPrivacyPolicy();
  Future<PrivacyPolicyAndTermConditionModel> getTermsAndCondition();
  Future<ContactUsModel> getContactUsContent();
  Future<bool> getContactUsMessageSend(ContactUsMessageModel body);
  Future<ProductDetailsModel> getProductDetails(String slug);
  Future<SubmitReviewResponseModel> submitReivew(
      Map<String, dynamic> reviewInfo, String token);
  Future<List<CountryStateModel>> statesByCountryId(
      String countryID, String token);
  Future<List<CityModel>> citiesByStateId(String countryID, String token);
  Future<List<OrderModel>> orderList(String token);
  Future<BillingShipingModel> getShipingAndBillingAddress(String token);
  Future<String> billingUpdate(Map<String, String> dataMap, String token);
  Future<String> shippingUpdate(Map<String, String> dataMap, String token);

  Future<List<WishListModel>> wishList(String token);
  Future<String> removeWishList(int id, String token);
  Future<String> addWishList(int id, String token);
  Future<SearchResponseModel> searchProduct(Uri uri);

  Future<CartResponseModel> getCartProducts(String token);
  // Future<CartResponseModel> applyCoupon(String token, String coupon);

  Future<CheckoutResponseModel> getCheckoutData(String token);
  Future<PaymentInfoModel> getPaymentInfo(String token, int shoppingId);
  Future<String> stripePay(String token, Map<String, String> body);
  Future<CartResponseModel> incrementQuantity(String productId, String token);
  Future<CartResponseModel> removerCartItem(String productId, String token);
  Future<CartResponseModel> decrementQuantity(String productId, String token);
  Future<String> addToCart(AddToCartModel dataModel);
  Future<String> cashOnDeliveryPayment(Uri uri);
  // Future<String> payWithPaypal(Uri uri);
  // Future<String> paypalSuccess(Uri uri);
  Future<CartResponseModel> applyCoupon(String coupon, String token);
}

typedef _CallClientMethod = Future<http.Response> Function();

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  final _className = 'RemoteDataSourceImpl';

  RemoteDataSourceImpl({required this.client});

  Future<dynamic> callClientWithCatchException(
      _CallClientMethod _callClientMethod) async {
    try {
      final response = await _callClientMethod();
      // log(response.statusCode.toString(), name: _className);
      // log(response.body, name: _className);
      return _responseParser(response);
    } on SocketException {
      log('SocketException', name: _className);
      throw const NetworkException('No internet connection', 10061);
    } on FormatException {
      log('FormatException', name: _className);
      throw const DataFormateException('Data format exception', 422);
    } on http.ClientException {
      ///503 Service Unavailable
      log('http ClientException', name: _className);
      throw const NetworkException('Service unavailable', 503);
    } on TimeoutException {
      log('TimeoutException', name: _className);
      throw const NetworkException('Request timeout', 408);
    }
  }

  @override
  Future<ProductDetailsModel> getProductDetails(String slug) async {
    final uri = Uri.parse(RemoteUrls.productDetail(slug));

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return ProductDetailsModel.fromMap(responseJsonBody);
    // try {

    // }  on TypeError {
    //   throw ObjectToModelException(
    // "Object to model data class convert exception");
    // } catch (e) {
    //   print(e.runtimeType);
    //   print('error from remote data source file');
    //   throw UnknowException('Unknown error');
    // }
  }

  @override
  Future<CartResponseModel> applyCoupon(String coupon, String token) async {
    final uri = Uri.parse(RemoteUrls.applyCoupon(coupon, token));
    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return CartResponseModel.fromMap(responseJsonBody);
  }

  @override
  Future<CartResponseModel> decrementQuantity(
      String productId, String token) async {
    final uri = Uri.parse(RemoteUrls.decrementQuantity(productId, token));
    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return CartResponseModel.fromMap(responseJsonBody);
  }

  @override
  Future<String> addToCart(AddToCartModel dataModel) async {
    final uri = Uri.parse(RemoteUrls.addToCart)
        .replace(queryParameters: dataModel.toMap());
    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> cashOnDeliveryPayment(Uri uri) async {
    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    log(responseJsonBody.toString(), name: 'cashOnDeliveryPayment');

    return responseJsonBody['message'] as String;
  }

  @override
  Future<CartResponseModel> incrementQuantity(
      String productId, String token) async {
    final uri = Uri.parse(RemoteUrls.incrementQuantity(productId, token));
    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return CartResponseModel.fromMap(responseJsonBody);
  }

  @override
  Future<CartResponseModel> removerCartItem(
      String productId, String token) async {
    final uri = Uri.parse(RemoteUrls.removeCartItem(productId, token));
    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return CartResponseModel.fromMap(responseJsonBody);
  }

  @override
  Future<CartResponseModel> getCartProducts(String token) async {
    final uri = Uri.parse(RemoteUrls.cartProduct(token));
    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return CartResponseModel.fromMap(responseJsonBody);
  }

  @override
  Future<CheckoutResponseModel> getCheckoutData(String token) async {
    final uri = Uri.parse(RemoteUrls.cartCheckout(token));
    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return CheckoutResponseModel.fromMap(responseJsonBody);
  }

  @override
  Future<PaymentInfoModel> getPaymentInfo(String token, int shippingId) async {
    final uri = Uri.parse(RemoteUrls.cartPaymentInfo(token, shippingId));
    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return PaymentInfoModel.fromMap(responseJsonBody);
  }

  @override
  Future<String> stripePay(String token, Map<String, String> body) async {
    final uri = Uri.parse(RemoteUrls.payWithStripe(token));
    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: body,
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return responseJsonBody['message'];
  }

  @override
  Future<SearchResponseModel> searchProduct(Uri uri) async {
    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return SearchResponseModel.fromMap(responseJsonBody['products']);
  }

  @override
  Future<BillingShipingModel> getShipingAndBillingAddress(String token) async {
    final uri = Uri.parse(RemoteUrls.address(token));

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return BillingShipingModel.fromMap(responseJsonBody);
  }

  @override
  Future<String> billingUpdate(
    Map<String, String> dataMap,
    String token,
  ) async {
    final uri = Uri.parse(RemoteUrls.billingAddress(token));

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: dataMap,
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return responseJsonBody['notification'] as String;
  }

  @override
  Future<String> shippingUpdate(
    Map<String, String> dataMap,
    String token,
  ) async {
    final uri = Uri.parse(RemoteUrls.shippingAddress(token));

    final headers = {'Accept': 'application/json'};
    final clientMethod = client.post(
      uri,
      headers: headers,
      body: dataMap,
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return responseJsonBody['notification'] as String;
  }

  @override
  Future<List<WishListModel>> wishList(String token) async {
    final uri = Uri.parse(RemoteUrls.wishList(token));

    final headers = {'Accept': 'application/json'};
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    final wishlist = responseJsonBody['wishlists']['data'] as List?;
    if (wishlist == null) {
      return [];
    } else {
      return wishlist.map((e) {
        final mapData = e['product'] as Map<String, dynamic>;
        mapData.addAll({"wish_id": e['id']?.toInt() ?? 0});
        return WishListModel.fromMap(mapData);
      }).toList();
    }
  }

  @override
  Future<String> removeWishList(int id, String token) async {
    final uri = Uri.parse(RemoteUrls.removeWish(id, token));

    final headers = {'Accept': 'application/json'};
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return responseJsonBody['notification'] as String;
  }

  @override
  Future<String> addWishList(int id, String token) async {
    final uri = Uri.parse(RemoteUrls.addWish(id, token));

    final headers = {'Accept': 'application/json'};
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return responseJsonBody['message'] as String;
  }

  @override
  Future<HomeModel> getHomeData() async {
    final uri = Uri.parse(RemoteUrls.homeUrl);

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    print(responseJsonBody);

    return HomeModel.fromMap(responseJsonBody);
  }

  @override
  Future<SettingModel> websiteSetup() async {
    final uri = Uri.parse(RemoteUrls.websiteSetup);

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return SettingModel.fromMap(responseJsonBody['setting']);
  }

  @override
  Future<UserLoginResponseModel> signIn(Map body) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.userLogin);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    return UserLoginResponseModel.fromMap(responseJsonBody);
  }

  @override
  Future<String> logOut(String token) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.userLogOut(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'] as String;
  }

  @override
  Future<UserWithCountryResponse> userProfile(String token) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.userProfile(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    return UserWithCountryResponse.fromMap(responseJsonBody);
  }

  @override
  Future<String> passwordChange(
    ChangePasswordStateModel changePassData,
    String token,
  ) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.changePassword(token));

    final clientMethod =
        client.post(uri, headers: headers, body: changePassData.toMap());
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'] as String;
  }

  @override
  Future<String> profileUpdate(ProfiltEditStateModel user, String token) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.updateProfile(token));

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(user.toMap());

    request.headers.addAll(headers);
    if (user.image.isNotEmpty) {
      final file = await http.MultipartFile.fromPath('image', user.image);
      request.files.add(file);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'] as String;
  }

  @override
  Future<List<CountryStateModel>> statesByCountryId(
      String countryID, String token) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.stateByCountryId(countryID, token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    final mapList = responseJsonBody['states'] as List;

    return List<CountryStateModel>.from(
        mapList.map((e) => CountryStateModel.fromMap(e)));
  }

  @override
  Future<List<CityModel>> citiesByStateId(String stateID, String token) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.citiesByStateId(stateID, token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    final mapList = responseJsonBody['cities'] as List;

    return List<CityModel>.from(mapList.map((e) => CityModel.fromMap(e)));
  }

  @override
  Future<List<OrderModel>> orderList(String token) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.orderList(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    final mapList = responseJsonBody['orders']['data'] as List;

    return List<OrderModel>.from(mapList.map((e) => OrderModel.fromMap(e)));
  }

  @override
  Future<String> userRegister(Map<String, dynamic> userInfo) async {
    final uri = Uri.parse(RemoteUrls.userRegister);

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: userInfo,
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'];
  }

  @override
  Future<String> sendForgotPassCode(Map<String, dynamic> body) async {
    final uri = Uri.parse(RemoteUrls.sendForgetPassword);

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: body,
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'];
  }

  @override
  Future<String> setPassword(SetPasswordModel body) async {
    final uri = Uri.parse(RemoteUrls.storeResetPassword(body.code));

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: body.toMap(),
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'];
  }

  @override
  Future<String> sendActiveAccountCode(String email) async {
    final uri = Uri.parse(RemoteUrls.resendRegisterCode);

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: {'email': email},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'];
  }

  @override
  Future<String> activeAccountCodeSubmit(String code) async {
    final uri = Uri.parse(RemoteUrls.userVerification(code));

    final clientMethod =
        client.get(uri, headers: {'Accept': 'application/json'});

    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'];
  }

  @override
  Future<AboutUsModel> getAboutUsData() async {
    final uri = Uri.parse(RemoteUrls.aboutUs);

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return AboutUsModel.fromMap(responseJsonBody['aboutUs']);
  }

  @override
  Future<bool> getContactUsMessageSend(ContactUsMessageModel body) async {
    final uri = Uri.parse(RemoteUrls.sendContactMessage);

    final clientMethod = client.post(
      uri,
      body: body.toMap(),
      headers: {'Accept': 'application/json'},
    );

    await callClientWithCatchException(() => clientMethod);

    return true;
  }

  @override
  Future<ContactUsModel> getContactUsContent() async {
    final uri = Uri.parse(RemoteUrls.contactUs);

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return ContactUsModel.fromMap(responseJsonBody['contact']);
  }

  @override
  Future<PrivacyPolicyAndTermConditionModel> getPrivacyPolicy() async {
    final uri = Uri.parse(RemoteUrls.privacyPolicy);

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return PrivacyPolicyAndTermConditionModel.fromMap(
        responseJsonBody['privacyPolicy']);
  }

  @override
  Future<PrivacyPolicyAndTermConditionModel> getTermsAndCondition() async {
    final uri = Uri.parse(RemoteUrls.termsAndConditions);

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return PrivacyPolicyAndTermConditionModel.fromMap(
        responseJsonBody['terms_conditions']);
  }

  @override
  Future<List<FaqModel>> getFaqList() async {
    final uri = Uri.parse(RemoteUrls.faq);

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    final faqData = responseJsonBody['faqs'] as List?;
    return faqData != null
        ? faqData.map((e) => FaqModel.fromMap(e)).toList()
        : [];
  }

  dynamic _responseParser(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        final errorMsg = parsingDoseNotExist(response.body);
        throw BadRequestException(errorMsg, 400);
      case 401:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 401);
      case 402:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 402);
      case 403:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 403);
      case 404:
        throw const UnauthorisedException('Request not found', 404);
      case 405:
        throw const UnauthorisedException('Method not allowed', 405);
      case 408:

        ///408 Request Timeout
        throw const NetworkException('Request timeout', 408);
      case 415:

        /// 415 Unsupported Media Type
        throw const DataFormateException('Data formate exception');

      case 422:

        ///Unprocessable Entity
        final errorMsg = parsingError(response.body);
        throw InvalidInputException(errorMsg, 422);
      case 500:

        ///500 Internal Server Error
        throw const InternalServerException('Internal server error', 500);

      default:
        throw FetchDataException(
            'Error occured while communication with Server',
            response.statusCode);
    }
  }

  String parsingError(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['errors'] != null) {
        final errors = errorsMap['errors'] as Map;
        final firstErrorMsg = errors.values.first;
        if (firstErrorMsg is List) return firstErrorMsg.first;
        return firstErrorMsg.toString();
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }

    return 'Unknown error';
  }

  String parsingDoseNotExist(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['notification'] != null) {
        return errorsMap['notification'];
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }
    return 'Credentials does not match';
  }

  @override
  Future<SubmitReviewResponseModel> submitReivew(
      Map<String, dynamic> reviewInfo, String token) async {
    final uri = Uri.parse(RemoteUrls.submitReviewUrl(token));

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: reviewInfo,
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return SubmitReviewResponseModel.fromMap(responseJsonBody);
  }
}
