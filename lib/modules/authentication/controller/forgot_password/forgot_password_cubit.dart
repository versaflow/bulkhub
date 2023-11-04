import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/set_password_model.dart';
import '../../repository/auth_repository.dart';
part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository repository;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final paswordController = TextEditingController();
  final paswordConfirmController = TextEditingController();
  final codeController = TextEditingController();

  ForgotPasswordCubit(this.repository)
      : super(const ForgotPasswordStateInitial());

  Future<void> forgotPassWord() async {
    if (!formKey.currentState!.validate()) return;

    emit(const ForgotPasswordStateLoading());

    final body = {"email": emailController.text.trim()};

    final result = await repository.sendForgotPassCode(body);
    result.fold(
      (failuer) {
        emit(ForgotPasswordStateError(failuer.message));
      },
      (data) {
        emit(ForgotPasswordStateLoaded(data));
      },
    );
  }

  Future<void> setNewPassword() async {
    if (!formKey.currentState!.validate()) return;

    emit(const ForgotPasswordStateLoading());

    final model = SetPasswordModel(
      code: codeController.text,
      email: emailController.text.trim(),
      password: paswordController.text,
      passwordConfirmation: paswordController.text,
    );

    final result = await repository.setPassword(model);
    result.fold(
      (failuer) {
        emit(ForgotPasswordStateError(failuer.message));
      },
      (data) {
        emit(PasswordSetStateLoaded(data));
      },
    );
  }
}
