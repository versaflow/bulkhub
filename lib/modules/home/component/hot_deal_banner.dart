import 'package:flutter/material.dart';
import '../../../core/remote_urls.dart';
import '../model/slider_model.dart';

class HotDealBanner extends StatelessWidget {
  const HotDealBanner({
    Key? key,
    required this.banner,
    this.height,
  }) : super(key: key);
  final SliderModel banner;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(RemoteUrls.imageUrl(banner.image)),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        color: Colors.black.withOpacity(.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                banner.description,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 14.0, height: 2, color: Colors.white),
              ),
            ),
            Text(
              banner.title,
              maxLines: 1,
              style: const TextStyle(
                  fontSize: 20, height: 1.5, color: Colors.white),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Shop now',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
