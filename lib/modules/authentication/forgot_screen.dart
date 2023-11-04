import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/primary_button.dart';
import '../../core/router_name.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_image.dart';
import 'controller/forgot_password/forgot_password_cubit.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ForgotPasswordCubit>();
    final size = MediaQuery.of(context).size;
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordStateError) {
          Utils.errorSnackBar(context, state.errorMsg);
        } else if (state is ForgotPasswordStateLoaded) {
          Navigator.pushReplacementNamed(context, RouteNames.setpasswordScreen);
          Utils.showSnackBar(context, state.email);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xffFFEFE7)],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(child: _buildForm(bloc)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(ForgotPasswordCubit bloc) {
    return Form(
      key: bloc.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            radius: 96,
            child: const CustomImage(path: Kimages.forgotIcon),
            backgroundColor: redColor.withOpacity(0.1),
          ),
          const SizedBox(height: 55),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Forget Password',
              style: GoogleFonts.poppins(
                  height: 1, fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 22),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: bloc.emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter email';
              } else if (!Utils.isEmail(value.trim())) {
                return "Enter valid email";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: 'Email'),
          ),
          const SizedBox(height: 28),
          BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              builder: (context, state) {
            if (state is ForgotPasswordStateLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return PrimaryButton(
              text: 'Send Code',
              onPressed: () {
                bloc.forgotPassWord();
              },
            );
          }),
        ],
      ),
    );
  }
}
