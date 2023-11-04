import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/remote_urls.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/primary_button.dart';
import '../../authentication/models/user_login_response_model.dart';
import '../controllers/country_state_by_id/country_state_by_id_cubit.dart';
import '../controllers/profile_edit/profile_edit_cubit.dart';
import '../model/city_model.dart';
import '../model/country_model.dart';
import '../model/country_state_model.dart';

class ProfileEditForm extends StatefulWidget {
  const ProfileEditForm({
    Key? key,
    required this.userData,
    required this.countries,
  }) : super(key: key);
  final List<CountryModel> countries;
  final UserLoginResponseModel userData;

  @override
  State<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  CountryModel? _currentCountry;
  CountryStateModel? _countryState;
  CityModel? _cityModel;

  @override
  void initState() {
    super.initState();

    for (var element in widget.countries) {
      if (element.id.toString() == widget.userData.user.countryId) {
        _currentCountry = element;
        final stateLoadIdCountryId =
            context.read<CountryStateByIdCubit>().stateLoadIdCountryId;
        // final cityLoadIdStateId =
        //     context.read<CountryStateByIdCubit>().cityLoadIdStateId;

        Future.microtask(() => stateLoadIdCountryId(element.id.toString()));
        // if (widget.userData.user.stateId != null) {
        //   Future.microtask(
        //       () => cityLoadIdStateId(widget.userData.user.stateId!));
        // }
      }
    }
  }

  void _loadState(CountryModel countryModel) {
    _currentCountry = countryModel;
    _countryState = null;
    _cityModel = null;
    final stateLoadIdCountryId =
        context.read<CountryStateByIdCubit>().stateLoadIdCountryId;

    stateLoadIdCountryId(countryModel.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final profileEdBlc = context.read<ProfileEditCubit>();

    return BlocBuilder<CountryStateByIdCubit, CountryStateByIdState>(
      builder: (context, state) {
        if (state is CountryStateByIdStateLoadied) {
          _countryState = context
              .read<CountryStateByIdCubit>()
              .filterState(widget.userData.user.stateId ?? 0);
          if (_countryState != null) {
            context
                .read<CountryStateByIdCubit>()
                .cityStateChangeCityFilter(_countryState!);

            _cityModel = context
                .read<CountryStateByIdCubit>()
                .filterCity(widget.userData.user.cityId ?? 0);
            log(_cityModel.toString(), name: "_cityModel");
          }
        }

        return Form(
          key: context.read<ProfileEditCubit>().formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildImage(),
              Text(
                widget.userData.user.name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.name,
                initialValue: widget.userData.user.name,
                onChanged: profileEdBlc.changeName,
                validator: (String? v) {
                  if (v == null || v.isEmpty) return "Enter name";
                  return null;
                },
                decoration: const InputDecoration(hintText: 'Your Name'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.phone,
                onChanged: profileEdBlc.changePhone,
                initialValue: widget.userData.user.phone,
                validator: (String? v) {
                  if (v == null || v.isEmpty || v.length < 8) {
                    return "Enter valid phone";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Phone',
                  prefixIcon: CountryCodePicker(
                    padding: const EdgeInsets.all(0),
                    onChanged: (country) {
                      profileEdBlc.changePhoneCode(country.dialCode ?? '');
                    },
                    initialSelection: 'BD',
                    favorite: const ['+88', 'BD'],
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _countryField(),
              const SizedBox(height: 16),
              stateField(),
              const SizedBox(height: 16),
              cityField(),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: widget.userData.user.zipCode,
                onChanged: profileEdBlc.changeZipCode,
                validator: (String? v) {
                  if (v == null || v.isEmpty) return "Enter zip-code";
                  return null;
                },
                decoration: const InputDecoration(hintText: 'Your zip-code'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.streetAddress,
                initialValue: widget.userData.user.address,
                onChanged: profileEdBlc.changeAddress,
                validator: (String? v) {
                  if (v == null || v.isEmpty) return "Enter address";
                  return null;
                },
                decoration: const InputDecoration(hintText: 'Your address'),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                text: 'Update Account',
                onPressed: () {
                  Utils.closeKeyBoard(context);
                  context.read<ProfileEditCubit>().submitForm();
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImage() {
    return BlocBuilder<ProfileEditCubit, ProfiltEditStateModel>(
      buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        String profileImage = widget.userData.user.image != null
            ? RemoteUrls.imageUrl(widget.userData.user.image!)
            : Kimages.kNetworkImage;
        profileImage = state.image.isNotEmpty ? state.image : profileImage;
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xff333333).withOpacity(.18),
                blurRadius: 70,
              ),
            ],
          ),
          child: Center(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomImage(
                    path: profileImage,
                    height: 170,
                    width: 170,
                    fit: BoxFit.cover,
                    isFile: state.image.isNotEmpty,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: InkWell(
                    onTap: () async {
                      final imageSourcePath = await Utils.pickSingleImage();
                      context
                          .read<ProfileEditCubit>()
                          .changeImage(imageSourcePath);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Color(0xff18587A),
                      child: Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _countryField() {
    return DropdownButtonFormField<CountryModel>(
      value: _currentCountry,
      hint: const Text('Country'),
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          // borderSide: BorderSide(width: 1, color: CustomColors.lineColor),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      onTap: () async {
        Utils.closeKeyBoard(context);
      },
      onChanged: (value) {
        if (value == null) return;
        _loadState(value);

        context.read<ProfileEditCubit>().changeCountry(value.id);
      },
      validator: (value) => value == null ? 'field required' : null,
      isDense: true,
      isExpanded: true,
      items: widget.countries
          .map<DropdownMenuItem<CountryModel>>((CountryModel value) {
        return DropdownMenuItem<CountryModel>(
            value: value, child: Text(value.name));
      }).toList(),
    );
  }

  Widget stateField() {
    final profileBl = context.read<ProfileEditCubit>();
    final addresBl = context.read<CountryStateByIdCubit>();
    return DropdownButtonFormField<CountryStateModel>(
      value: _countryState,
      hint: const Text('State'),
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          // borderSide: BorderSide(width: 1, color: CustomColors.lineColor),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      onTap: () async {
        Utils.closeKeyBoard(context);
      },
      onChanged: (value) {
        if (value == null) return;
        _cityModel = null;
        _countryState = value;
        addresBl.cityStateChangeCityFilter(value);
        profileBl.changeState(value.id);
      },
      validator: (value) => value == null ? 'field required' : null,
      isDense: true,
      isExpanded: true,
      items: addresBl.stateList
          .map<DropdownMenuItem<CountryStateModel>>((CountryStateModel value) {
        return DropdownMenuItem<CountryStateModel>(
            value: value, child: Text(value.name));
      }).toList(),
    );
  }

  Widget cityField() {
    final profileBl = context.read<ProfileEditCubit>();
    final addresBl = context.read<CountryStateByIdCubit>();
    return DropdownButtonFormField<CityModel>(
      value: _cityModel,
      hint: const Text('City'),
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      onTap: () {
        Utils.closeKeyBoard(context);
      },
      onChanged: (value) {
        _cityModel = value;
        if (value == null) return;
        profileBl.changeCity(value.id);
      },
      // validator: (value) => value == null ? 'field required' : null,
      isDense: true,
      isExpanded: true,
      items:
          addresBl.cities.map<DropdownMenuItem<CityModel>>((CityModel value) {
        return DropdownMenuItem<CityModel>(
            value: value, child: Text(value.name));
      }).toList(),
    );
  }
}
