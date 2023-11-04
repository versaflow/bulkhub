import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../authentication/controller/login/login_bloc.dart';
import '../../model/city_model.dart';
import '../../model/country_state_model.dart';
import '../../repository/profile_repository.dart';

part 'country_state_by_id_state.dart';

class CountryStateByIdCubit extends Cubit<CountryStateByIdState> {
  final LoginBloc _loginBloc;
  final ProfileRepository _profileRepository;
  CountryStateByIdCubit({
    required LoginBloc loginBloc,
    required ProfileRepository profileRepository,
  })  : _loginBloc = loginBloc,
        _profileRepository = profileRepository,
        super(CountryStateByIdStateInitial());

  List<CountryStateModel> stateList = [];
  List<CityModel> cities = [];

  Future<void> stateLoadIdCountryId(String id) async {
    stateList = [];

    emit(const CountryStateByIdStateLoading());
    final result = await _profileRepository.statesByCountryId(
        id, _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        emit(CountryStateByIdStateError(failure.statusCode, failure.message));
      },
      (dataList) {
        stateList = dataList.toSet().toList();

        emit(CountryStateByIdStateLoadied(stateList));
      },
    );
  }

  Future<void> cityLoadIdStateId(String id) async {
    cities = [];
    emit(const CountryStateByIdCityLoading());
    final result = await _profileRepository.citiesByStateId(
        id, _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        emit(CountryStateByIdStateError(failure.statusCode, failure.message));
      },
      (dataList) {
        cities = dataList.toSet().toList();
        emit(CountryStateByIdCityLoaded(cities));
      },
    );
  }

  void cityStateChangeCityFilter(CountryStateModel stateModel) async {
    cities = [];

    cities = stateModel.cities.toSet().toList();
    emit(CountryStateByIdCityFilter(cities));
  }

  CountryStateModel? filterState(int id) {
    for (var item in stateList) {
      if (item.id== id) {
        return item;
      }
    }
    return null;
  }

  CityModel? filterCity(int id) {
    for (var item in cities) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }
}
