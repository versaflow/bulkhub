import 'package:dartz/dartz.dart';

import '../../../../core/data/datasources/local_data_source.dart';
import '../../../../core/data/datasources/remote_data_source.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../home/model/setting_model.dart';

abstract class AppSettingRepository {
  Future<Either<Failure, SettingModel>> websiteSetup();
  Either<Failure, SettingModel> getCachedWebsiteSetup();

  Either<Failure, bool> checkOnBoarding();
  Future<Either<Failure, bool>> cashOnBoarding();
}

class AppSettingRepositoryImp extends AppSettingRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  AppSettingRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Either<Failure, bool> checkOnBoarding() {
    try {
      final result = localDataSource.checkOnBoarding();

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> cashOnBoarding() async {
    try {
      return Right(await localDataSource.cachOnBoarding());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, SettingModel>> websiteSetup() async {
    try {
      final result = await remoteDataSource.websiteSetup();
      localDataSource.cachWebsiteSetting(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Either<Failure, SettingModel> getCachedWebsiteSetup() {
    try {
      final result = localDataSource.getWebsiteSetting();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
