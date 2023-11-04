import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/primary_button.dart';
import '../../../utils/utils.dart';
import '../controller/sign_up/sign_up_bloc.dart';
import 'guest_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: bloc.formKey,
        child: Column(
          children: [
            const SizedBox(height: 12),
            BlocBuilder<SignUpBloc, SignUpModelState>(
              buildWhen: (previous, current) => previous.name != current.name,
              builder: (context, state) {
                return TextFormField(
                  keyboardType: TextInputType.name,
                  initialValue: state.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter name';
                    }
                    return null;
                  },
                  onChanged: (value) => bloc.add(SignUpEventName(value)),
                  decoration: const InputDecoration(hintText: 'Name'),
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<SignUpBloc, SignUpModelState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  initialValue: state.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter email';
                    } else if (!Utils.isEmail(value.trim())) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                  onChanged: (value) => bloc.add(SignUpEventEmail(value)),
                  decoration: const InputDecoration(hintText: 'Email'),
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<SignUpBloc, SignUpModelState>(
              buildWhen: (previous, current) =>
                  previous.password != current.password,
              builder: (context, state) {
                return TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  initialValue: state.password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Password';
                    }
                    return null;
                  },
                  onChanged: (value) => bloc.add(SignUpEventPassword(value)),
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: grayColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<SignUpBloc, SignUpModelState>(
              buildWhen: (previous, current) =>
                  previous.passwordConfirmation != current.passwordConfirmation,
              builder: (context, state) {
                return TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  initialValue: state.passwordConfirmation,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter confirm password';
                    } else if (state.password != state.passwordConfirmation) {
                      return "Password dosen't match";
                    }
                    return null;
                  },
                  onChanged: (value) =>
                      bloc.add(SignUpEventPasswordConfirm(value)),
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: grayColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            _buildRememberMe(),
            const SizedBox(height: 25),
            BlocBuilder<SignUpBloc, SignUpModelState>(
              buildWhen: (previous, current) => previous.state != current.state,
              builder: (context, state) {
                if (state.state is SignUpStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return PrimaryButton(
                  text: 'Sign Up',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    bloc.add(SignUpEventSubmit());
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            // const Text(
            //   'Sign Up With Social',
            //   style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            // ),
            // const SizedBox(height: 12),
            // const SocialButtons(),
            const SizedBox(height: 28),
            const GuestButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRememberMe() {
    return BlocBuilder<SignUpBloc, SignUpModelState>(
      buildWhen: (previous, current) => previous.agree != current.agree,
      builder: (context, state) {
        return CheckboxListTile(
          value: state.agree == 1,
          dense: true,
          contentPadding: EdgeInsets.zero,
          checkColor: Colors.white,
          activeColor: redColor,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            'I Consent To The Privacy Policy',
            style: TextStyle(color: blackColor.withOpacity(.5)),
          ),
          onChanged: (v) {
            if (v == null) return;
            context.read<SignUpBloc>().add(SignUpEventAgree(v ? 1 : 0));
          },
        );
      },
    );
  }
}
