import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../controller/login/login_bloc.dart';
import 'guest_button.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({Key? key}) : super(key: key);

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  bool _checkBoxSelect = false;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: loginBloc.formKey,
        child: Column(
          children: [
            const SizedBox(height: 12),
            BlocBuilder<LoginBloc, LoginModelState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  initialValue: state.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter username or email';
                    }
                    return null;
                  },
                  onChanged: (value) =>
                      loginBloc.add(LoginEventUserName(value)),
                  decoration: const InputDecoration(
                    hintText: 'Username or email',
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<LoginBloc, LoginModelState>(
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
                  onChanged: (value) =>
                      loginBloc.add(LoginEventPassword(value)),
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
            BlocBuilder<LoginBloc, LoginModelState>(
              buildWhen: (previous, current) => previous.state != current.state,
              builder: (context, state) {
                if (state.state is LoginStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return PrimaryButton(
                  text: 'Sign In',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    loginBloc.add(const LoginEventSubmit());
                  },
                );
              },
            ),
            // const SizedBox(height: 16),
            // const Text(
            //   'Sign In With Social',
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
    return Row(
      children: [
        Flexible(
          child: CheckboxListTile(
            value: _checkBoxSelect,
            dense: true,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            contentPadding: EdgeInsets.zero,
            checkColor: Colors.white,
            activeColor: redColor,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              'Remember me',
              style: TextStyle(color: blackColor.withOpacity(.5)),
            ),
            onChanged: (bool? v) {
              if (v == null) return;
              setState(() {
                _checkBoxSelect = v;
              });
            },
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteNames.forgotScreen);
          },
          child: const Text(
            'Forgot password?',
            style: TextStyle(color: redColor),
          ),
        ),
      ],
    );
  }
}
