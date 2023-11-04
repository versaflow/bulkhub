import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/utils.dart';
import '../../widgets/rounded_app_bar.dart';
import '../authentication/controller/login/login_bloc.dart';
import 'component/profile_edit_form.dart';
import 'controllers/profile_edit/profile_edit_cubit.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  Widget build(BuildContext context) {
    final userData = context.read<LoginBloc>().userInfo!;
    final countries = context.read<LoginBloc>().countries;
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Profile Edit'),
      body: BlocListener<ProfileEditCubit, ProfiltEditStateModel>(
        listener: (context, state) {
          final stateStatus = state.stateStatus;
          if (stateStatus is ProfileEditStateError) {
            Utils.closeDialog(context);
            Utils.errorSnackBar(context, stateStatus.message);
          } else if (stateStatus is ProfileEditStateLoaded) {
            Utils.closeDialog(context);
            Utils.showSnackBar(context, stateStatus.mesage);
            Navigator.pop(context);
          } else if (stateStatus is ProfileEditStateLoading) {
            Utils.loadingDialog(context);
          }
        },
        listenWhen: (previus, current) =>
            previus.stateStatus != current.stateStatus,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: ProfileEditForm(userData: userData, countries: countries),
        ),
      ),
    );
  }
}
