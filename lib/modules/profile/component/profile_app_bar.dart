import 'package:flutter/material.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';
import '../../authentication/models/user_login_response_model.dart';

class ProfileAppBar extends StatelessWidget {
  final double height;

  const ProfileAppBar({
    Key? key,
    this.height = 160,
    required this.userData,
    required this.logo,
  }) : super(key: key);
  final String logo;
  final UserLoginResponseModel userData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              _buildUserInfo(context),
              Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xff333333).withOpacity(.18),
                          blurRadius: 70),
                    ],
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _headerItem(
                          Kimages.profileOrderIcon,
                          'Orders',
                          () {
                            Navigator.pushNamed(
                                context, RouteNames.orderScreen);
                          },
                        ),
                        _headerItem(
                          Kimages.profileCartIcon,
                          'Cart',
                          () {
                            Navigator.pushNamed(context, RouteNames.cartScreen);
                          },
                        ),
                        _headerItem(
                          Kimages.profileofferIcon,
                          'Offers',
                          () {
                            Navigator.pushNamed(
                                context, RouteNames.profileOfferScreen);
                          },
                        ),
                        _headerItem(
                          Kimages.profileWishListIcon,
                          'Wishlist',
                          () {
                            Navigator.pushNamed(
                                context, RouteNames.wishlistOfferScreen);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerItem(String icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: const Color(0xffE8EEF2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(child: CustomImage(path: icon)),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 13),
          )
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: height - 60,
      decoration: const BoxDecoration(
        color: redColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImage(path: logo, height: 54, width: 120),
          Row(
            children: [
              Text(
                userData.user.name,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.profileEditScreen);
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: grayColor,
                  backgroundImage: NetworkImage(
                      RemoteUrls.imageUrl(userData.user.image ?? '')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
