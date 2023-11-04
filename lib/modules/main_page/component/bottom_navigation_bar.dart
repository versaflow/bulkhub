import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../main_controller.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    Key? key,
    required this.mainController,
    required this.selectedIndex,
  }) : super(key: key);
  final MainController mainController;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 9,
      color: const Color(0x00ffffff),
      shadowColor: blackColor,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,

          selectedLabelStyle: const TextStyle(fontSize: 14, color: redColor),
          unselectedLabelStyle:
              const TextStyle(fontSize: 14, color: Color(0xff030202)),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Kimages.homeIcon,
                  color: selectedIndex == 0 ? redColor : paragraphColor),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset(Kimages.inboxIcon,
            //       color: selectedIndex == 1 ? redColor : paragraphColor),
            //   label: 'Inbox',
            // ),
            BottomNavigationBarItem(
              tooltip: 'Order',
              activeIcon: SvgPicture.asset(Kimages.orderIcon, color: redColor),
              icon: SvgPicture.asset(Kimages.orderIcon, color: paragraphColor),
              label: 'Order',
            ),
            BottomNavigationBarItem(
              tooltip: 'Profile',
              activeIcon:
                  SvgPicture.asset(Kimages.profileIcon, color: redColor),
              icon:
                  SvgPicture.asset(Kimages.profileIcon, color: paragraphColor),
              label: 'Profile',
            ),
          ],
          // type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (int index) {
            mainController.naveListener.sink.add(index);
          },
        ),
      ),
    );
  }
}
