import 'package:dartz/dartz.dart';
import '../../../core/data/datasources/remote_data_source.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../model/payment_info_model.dart';

abstract class PaymentRepository {
  Future<Either<Failure, String>> cashOnDelivery(Uri uri);
  Future<Either<Failure, PaymentInfoModel>> getPaymentInfo(
      String token, shippingId);
  Future<Either<Failure, String>> stripePay(
      String token, Map<String, String> body);
}

class PaymentRepositoryImp extends PaymentRepository {
  final RemoteDataSource remoteDataSource;

  PaymentRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> cashOnDelivery(Uri uri) async {
    try {
      final result = await remoteDataSource.cashOnDeliveryPayment(uri);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PaymentInfoModel>> getPaymentInfo(
      String token, shippingId) async {
    try {
      final result = await remoteDataSource.getPaymentInfo(token, shippingId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> stripePay(
    String token,
    Map<String, String> body,
  ) async {
    try {
      final result = await remoteDataSource.stripePay(token, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
