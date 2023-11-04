import 'package:dartz/dartz.dart';
import '../../../core/data/datasources/remote_data_source.dart';
import '../../../core/data/datasources/local_data_source.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../controllers/change_password/change_password_cubit.dart';
import '../controllers/profile_edit/profile_edit_cubit.dart';
import '../model/billing_shipping_model.dart';
import '../model/city_model.dart';
import '../model/country_state_model.dart';
import '../model/user_with_country_response.dart';
import '../profile_offer/model/wish_list_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserWithCountryResponse>> userProfile(String token);
  Future<Either<Failure, String>> passwordChange(
    ChangePasswordStateModel changePassData,
    String token,
  );
  Future<Either<Failure, String>> profileUpdate(
    ProfiltEditStateModel user,
    String token,
  );
  Future<Either<Failure, List<CountryStateModel>>> statesByCountryId(
      String countryID, String token);
  Future<Either<Failure, List<CityModel>>> citiesByStateId(
      String stateID, String token);

  Future<Either<Failure, BillingShipingModel>> getAddress(String token);
  Future<Either<Failure, String>> billingUpdate(
    Map<String, String> dataMap,
    String token,
  );
  Future<Either<Failure, String>> shippingUpdate(
    Map<String, String> dataMap,
    String token,
  );
  Future<Either<Failure, List<WishListModel>>> wishList(String token);
  Future<Either<Failure, String>> removeWishList(int id, String token);
  Future<Either<Failure, String>> addWishList(int id, String token);
}

class ProfileRepositoryImp extends ProfileRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  ProfileRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserWithCountryResponse>> userProfile(
      String token) async {
    try {
      final result = await remoteDataSource.userProfile(token);
      localDataSource.cacheUserProfile(result.user);
      return Right(result);
    } on ServerException catch (e) {
      if (e.statusCode == 401) localDataSource.clearUserProfile();
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> passwordChange(
    ChangePasswordStateModel changePassData,
    String token,
  ) async {
    try {
      final result =
          await remoteDataSource.passwordChange(changePassData, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> profileUpdate(
    ProfiltEditStateModel user,
    String token,
  ) async {
    try {
      final result = await remoteDataSource.profileUpdate(user, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<CityModel>>> citiesByStateId(
      String stateID, String token) async {
    try {
      final result = await remoteDataSource.citiesByStateId(stateID, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<CountryStateModel>>> statesByCountryId(
      String countryID, String token) async {
    try {
      final result = await remoteDataSource.statesByCountryId(countryID, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, BillingShipingModel>> getAddress(String token) async {
    try {
      final result = await remoteDataSource.getShipingAndBillingAddress(token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> billingUpdate(
      Map<String, String> dataMap, String token) async {
    try {
      final result = await remoteDataSource.billingUpdate(dataMap, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> shippingUpdate(
      Map<String, String> dataMap, String token) async {
    try {
      final result = await remoteDataSource.shippingUpdate(dataMap, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<WishListModel>>> wishList(String token) async {
    try {
      final result = await remoteDataSource.wishList(token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> removeWishList(int id, String token) async {
    try {
      final result = await remoteDataSource.removeWishList(id, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> addWishList(int id, String token) async {
    try {
      final result = await remoteDataSource.addWishList(id, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
