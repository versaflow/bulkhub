import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/constants.dart';
import '../../core/router_name.dart';
import '../../dummy_data/all_dymmy_data.dart';
import 'component/chat_list_app_bar.dart';
import 'component/chat_list_component.dart';
import 'component/empty_chat_list_component.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double appBarHeight = 85;
    final routeName = ModalRoute.of(context)?.settings.name ?? '';
    if (routeName != RouteNames.mainPage) appBarHeight += 10;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: const IconThemeData(color: primaryColor),
            automaticallyImplyLeading: routeName != RouteNames.mainPage,
            expandedHeight: appBarHeight,
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: redColor),
            flexibleSpace: ChatListAppBar(height: appBarHeight),
          ),
          chatList.isEmpty
              ? const EmptyChatListComponent()
              : ChatListComponent(chatList: chatList),
          const SliverToBoxAdapter(child: SizedBox(height: 65)),
        ],
      ),
    );
  }
}
