import 'package:dartz/dartz.dart';

import '../../../core/data/datasources/remote_data_source.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../model/order_model.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderModel>>> orderList(String token);
}

class OrderRepositoryImp extends OrderRepository {
  final RemoteDataSource _remoteDataSource;

  OrderRepositoryImp(this._remoteDataSource);

  @override
  Future<Either<Failure, List<OrderModel>>> orderList(String token) async {
    try {
      final result = await _remoteDataSource.orderList(token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
