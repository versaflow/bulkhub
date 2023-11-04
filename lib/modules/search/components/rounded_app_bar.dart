import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../widgets/app_bar_leading.dart';

class SearchAppBar extends AppBar {
  final Widget? titleWidget;

  final Color bgColor;
  final Color textColor;
  final void Function()? onTap;

  final ShapeBorder shapeBorder;
  SearchAppBar({
    this.titleWidget,
    this.textColor = Colors.white,
    this.bgColor = redColor,
    this.shapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
    ),
    this.onTap,
    Key? key,
  }) : super(
          key: key,
          titleSpacing: 0,
          backgroundColor: bgColor,
          shape: shapeBorder,
          leading: const AppbarLeading(),
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: textColor, fontSize: 18, fontWeight: FontWeight.w600),
          title: titleWidget,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        );
}
