import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/rounded_app_bar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(color: Colors.transparent),
          SizedBox(
            height: 160,
            child: RoundedAppBar(
              titleText: 'Settings',
              shapeBorder: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
            ),
          ),
          Positioned(
            top: media + 80.0,
            left: 20.0,
            bottom: 20.0,
            right: 20.0,
            child: _buildItemList(),
          ),
        ],
      ),
    );
  }

  Widget _buildItemList() {
    return Card(
      elevation: 10,
      margin: EdgeInsets.zero,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: const CustomImage(path: Kimages.profileNotificationIcon),
            title: const Text('Notifications'),
            trailing: Switch.adaptive(
                activeTrackColor: greenColor,
                value: true,
                inactiveTrackColor: const Color(0xff374557).withOpacity(.6),
                activeColor: Colors.white,
                onChanged: (v) {}),
          ),
          border,
          ListTile(
            leading: const CustomImage(path: Kimages.themeIcon),
            title: const Text('Dark Mode'),
            trailing: Switch.adaptive(
                activeTrackColor: greenColor,
                value: false,
                inactiveTrackColor: const Color(0xff374557).withOpacity(.6),
                activeColor: Colors.white,
                onChanged: (v) {}),
          ),
          border,
          ListTile(
            leading: const CustomImage(path: Kimages.activeLocationIcon),
            title: const Text('Active Location'),
            trailing: Switch.adaptive(
                activeTrackColor: greenColor,
                value: false,
                inactiveTrackColor: const Color(0xff374557).withOpacity(.6),
                activeColor: Colors.white,
                onChanged: (v) {}),
          ),
          border,
          ListTile(
            leading: const CustomImage(path: Kimages.languageIcon),
            title: const Text('Language'),
            trailing: Switch.adaptive(
                activeTrackColor: greenColor,
                value: true,
                inactiveTrackColor: const Color(0xff374557).withOpacity(.6),
                activeColor: Colors.white,
                onChanged: (v) {}),
          ),
          border,
          ListTile(
            leading: const CustomImage(path: Kimages.onClickIcon),
            title: const Text('One Click Login'),
            trailing: Switch.adaptive(
                activeTrackColor: greenColor,
                value: false,
                inactiveTrackColor: const Color(0xff374557).withOpacity(.6),
                activeColor: Colors.white,
                onChanged: (v) {}),
          ),
          border,
        ],
      ),
    );
  }

  final border = Container(height: 1, color: borderColor.withOpacity(.34));
}
