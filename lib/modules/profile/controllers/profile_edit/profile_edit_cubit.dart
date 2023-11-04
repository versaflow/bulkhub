import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../authentication/controller/login/login_bloc.dart';
import '../../../authentication/models/user_prfile_model.dart';
import '../../repository/profile_repository.dart';

part 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfiltEditStateModel> {
  final LoginBloc _loginBloc;
  final ProfileRepository _profileRepository;
  final formKey = GlobalKey<FormState>();

  ProfileEditCubit({
    required LoginBloc loginBloc,
    required ProfileRepository profileRepository,
  })  : _loginBloc = loginBloc,
        _profileRepository = profileRepository,
        super(ProfiltEditStateModel.init(loginBloc.userInfo!.user));

  void changeName(String value) {
    emit(
      state.copyWith(
        name: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changePhoneCode(String value) {
    emit(
      state.copyWith(
        phoneCode: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changePhone(String value) {
    emit(
      state.copyWith(
        phone: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changeCountry(int value) {
    emit(
      state.copyWith(
        country: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changeState(int value) {
    emit(
      state.copyWith(
        state: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changeCity(int value) {
    emit(
      state.copyWith(
        city: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changeZipCode(String value) {
    emit(
      state.copyWith(
        zipCode: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changeAddress(String value) {
    emit(
      state.copyWith(
        address: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changeImage(String? value) {
    emit(
      state.copyWith(
        image: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    emit(state.copyWith(stateStatus: const ProfileEditStateLoading()));

    final result = await _profileRepository.profileUpdate(
        state, _loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(state.copyWith(
            stateStatus:
                ProfileEditStateError(failure.message, failure.statusCode)));
      },
      (successData) {
        emit(state.copyWith(stateStatus: ProfileEditStateLoaded(successData)));
      },
    );
  }
}
