import 'package:dartz/dartz.dart';
import '../../../core/data/datasources/remote_data_source.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../model/add_to_cart_model.dart';
import '../model/cart_response_model.dart';
import '../model/checkout_response_model.dart';

abstract class CartRepository {
  Future<Either<Failure, CartResponseModel>> getCartProducts(String token);
  Future<Either<Failure, CheckoutResponseModel>> getCheckoutData(String token);
  Future<Either<Failure, CartResponseModel>> removerCartItem(
      String productId, String token);
  Future<Either<Failure, CartResponseModel>> incrementQuantity(
      String productId, String token);
  Future<Either<Failure, CartResponseModel>> decrementQuantity(
      String productId, String token);
  Future<Either<Failure, CartResponseModel>> applyCoupon(
      String coupon, String token);
  Future<Either<Failure, String>> addToCart(AddToCartModel dataModel);
}

class CartRepositoryImp extends CartRepository {
  final RemoteDataSource remoteDataSource;

  CartRepositoryImp(this.remoteDataSource);
  @override
  Future<Either<Failure, CartResponseModel>> getCartProducts(
      String token) async {
    try {
      final result = await remoteDataSource.getCartProducts(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CheckoutResponseModel>> getCheckoutData(
      String token) async {
    try {
      final result = await remoteDataSource.getCheckoutData(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CartResponseModel>> removerCartItem(
      String productId, String token) async {
    try {
      final result = await remoteDataSource.removerCartItem(productId, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CartResponseModel>> incrementQuantity(
      String productId, String token) async {
    try {
      final result = await remoteDataSource.incrementQuantity(productId, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CartResponseModel>> decrementQuantity(
      String productId, String token) async {
    try {
      final result = await remoteDataSource.decrementQuantity(productId, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CartResponseModel>> applyCoupon(
      String coupon, String token) async {
    try {
      final result = await remoteDataSource.applyCoupon(coupon, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> addToCart(AddToCartModel dataModel) async {
    try {
      final result = await remoteDataSource.addToCart(dataModel);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
