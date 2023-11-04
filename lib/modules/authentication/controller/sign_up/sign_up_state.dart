part of 'sign_up_bloc.dart';

class SignUpModelState extends Equatable {
  final int agree;
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final SignUpState state;
  const SignUpModelState({
    this.agree = 0,
    this.name = '',
    this.email = '',
    this.password = '',
    this.passwordConfirmation = '',
    this.state = const SignUpStateInitial(),
  });

  SignUpModelState copyWith({
    int? agree,
    String? name,
    String? email,
    String? password,
    String? passwordConfirmation,
    SignUpState? state,
  }) {
    return SignUpModelState(
      agree: agree ?? this.agree,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'agree': agree.toString()});
    result.addAll({'name': name.trim()});
    result.addAll({'email': email.trim()});
    result.addAll({'password': password});
    result.addAll({'password_confirmation': passwordConfirmation});

    return result;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'SignUpModelState(agree: $agree, name: $name, email: $email, password: $password, passwordConfirmation: $passwordConfirmation, state: $state)';
  }

  @override
  List<Object> get props {
    return [
      agree,
      name,
      email,
      password,
      passwordConfirmation,
      state,
    ];
  }
}

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpStateInitial extends SignUpState {
  const SignUpStateInitial();
}

class SignUpStateLoading extends SignUpState {
  const SignUpStateLoading();
}

class SignUpStateLoaded extends SignUpState {
  const SignUpStateLoaded(this.msg);
  final String msg;
  @override
  List<Object> get props => [msg];
}

class SignUpStateLoadedError extends SignUpState {
  final String errorMsg;
  const SignUpStateLoadedError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class SignUpStateFormError extends SignUpState {
  final String errorMsg;
  const SignUpStateFormError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
