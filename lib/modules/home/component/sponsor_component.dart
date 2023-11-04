import 'package:flutter/material.dart';
import '../../../core/remote_urls.dart';
import '../../../widgets/custom_image.dart';
import '../model/brand_model.dart';

class SponsorComponent extends StatelessWidget {
  const SponsorComponent({
    Key? key,
    required this.brands,
  }) : super(key: key);

  final List<BrandModel> brands;

  @override
  Widget build(BuildContext context) {
    if (brands.isEmpty) return const SizedBox();
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Color(0xffF3F3F3), blurRadius: 20),
          BoxShadow(blurRadius: 20, color: Color(0xffF3F3F3)),
        ],
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CustomImage(
          path: RemoteUrls.imageUrl(brands[index].logo),
          height: 56,
          width: 68,
        ),
        separatorBuilder: (_, index) => const SizedBox(width: 10),
        itemCount: brands.length,
      ),
    );
  }
}
