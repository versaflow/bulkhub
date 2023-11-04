import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exception.dart';
import '../../../modules/authentication/models/user_login_response_model.dart';
import '../../../modules/authentication/models/user_prfile_model.dart';
import '../../../modules/home/model/setting_model.dart';
import '../../../utils/k_strings.dart';

abstract class LocalDataSource {
  /// Gets the cached [UserLoginResponseModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  UserLoginResponseModel getUserResponseModel();

  Future<bool> cacheUserResponse(UserLoginResponseModel userLoginResponseModel);
  Future<bool> cacheUserProfile(UserProfileModel userProfileModel);
  Future<bool> clearUserProfile();
  bool checkOnBoarding();
  Future<bool> cachOnBoarding();

  Future<bool> cachWebsiteSetting(SettingModel result);
  SettingModel getWebsiteSetting();
}

class LocalDataSourceImpl implements LocalDataSource {
  final _className = 'LocalDataSourceImpl';
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  UserLoginResponseModel getUserResponseModel() {
    final jsonString =
        sharedPreferences.getString(Kstrings.cachedUserResponseKey);
    if (jsonString != null) {
      return UserLoginResponseModel.fromJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheUserResponse(
      UserLoginResponseModel userLoginResponseModel) {
    return sharedPreferences.setString(
      Kstrings.cachedUserResponseKey,
      userLoginResponseModel.toJson(),
    );
  }

  @override
  Future<bool> cacheUserProfile(UserProfileModel userProfileModel) {
    final user = getUserResponseModel();
    user.user != userProfileModel;
    return cacheUserResponse(user);
  }

  @override
  Future<bool> clearUserProfile() {
    return sharedPreferences.remove(Kstrings.cachedUserResponseKey);
  }

  @override
  bool checkOnBoarding() {
    final jsonString = sharedPreferences.getBool(Kstrings.cachOnboardingKey);
    if (jsonString != null) {
      return true;
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cachOnBoarding() {
    return sharedPreferences.setBool(Kstrings.cachOnboardingKey, true);
  }

  @override
  Future<bool> cachWebsiteSetting(SettingModel settingModel) async {
    log(settingModel.toJson(), name: _className);
    return sharedPreferences.setString(
        Kstrings.cachedWebSettingKey, settingModel.toJson());
  }

  @override
  SettingModel getWebsiteSetting() {
    final jsonString =
        sharedPreferences.getString(Kstrings.cachedWebSettingKey);
    log(jsonString.toString(), name: _className);
    if (jsonString != null) {
      return SettingModel.fromJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }
}
