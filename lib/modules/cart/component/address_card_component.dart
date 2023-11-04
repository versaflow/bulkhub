import 'package:flutter/material.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../profile/model/address_model.dart';

class AddressCardComponent extends StatelessWidget {
  const AddressCardComponent({
    Key? key,
    required this.addressModel,
    required this.type,
    this.onTap,
    this.pwidth,
  }) : super(key: key);

  final AddressModel addressModel;
  final VoidCallback? onTap;
  final String type;
  final double? pwidth;

  @override
  Widget build(BuildContext context) {
    final width = pwidth ?? MediaQuery.of(context).size.width / 1.63;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      width: width,
      decoration: BoxDecoration(
        color: borderColor.withOpacity(.11),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.location_on_outlined, color: greenColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      addressModel.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    if (pwidth == null)
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.addAddressScreen,
                            arguments: type,
                          );
                        },
                        child: CircleAvatar(
                          radius: 13,
                          backgroundColor: paragraphColor.withOpacity(.24),
                          child: const Icon(Icons.edit,
                              size: 16, color: blackColor),
                        ),
                      ),
                  ],
                ),
                Text(
                  addressModel.email,
                  style: const TextStyle(color: iconGreyColor),
                ),
                Text(
                  addressModel.phone,
                  style: const TextStyle(color: iconGreyColor),
                ),
                const SizedBox(height: 6),
                Text(
                  type,
                  style: const TextStyle(
                      color: redColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                Text(addressModel.address),
                Text("Zip code : " + addressModel.zipCode),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
