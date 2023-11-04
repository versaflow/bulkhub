import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/feedback_success.dart';
import 'controller/review/review_cubit.dart';
import '../../core/remote_urls.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rounded_app_bar.dart';
import '../order/model/product_order_model.dart';

class SubmitFeedBackScreen extends StatefulWidget {
  const SubmitFeedBackScreen({Key? key, required this.orderItem})
      : super(key: key);
  final OrderedProductModel orderItem;

  @override
  State<SubmitFeedBackScreen> createState() => _SubmitFeedBackScreenState();
}

class _SubmitFeedBackScreenState extends State<SubmitFeedBackScreen> {
  final _reviewTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _reviewTextController.dispose();
  }

  final _className = 'SubmitFeedBackScreen';
  double ratingValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubmitReviewCubit, ReviewSubmitState>(
      listener: (context, state) {
        if (state is SubmitReviewStateLoading) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (state is SubmitReviewStateError) {
            Utils.errorSnackBar(context, state.errorMessage);
          } else if (state is SubmitReviewStateLoaded) {
            if (state.submitReviewResponseModel.status == 0) {
              Utils.showSnackBar(
                  context, state.submitReviewResponseModel.message);
            } else {
              Utils.showCustomDialog(context, child: const FeedbackSuccess());
            }
          }
        }
      },
      child: Scaffold(
        appBar: RoundedAppBar(
          bgColor: Colors.white,
          titleText: 'Back to Home',
          textColor: blackColor,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // FeedbackProductCard(product: populerProductList.first),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: bgGreyColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImage(
                      path: RemoteUrls.imageUrl(widget.orderItem.thumbImage),
                      height: 85,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.orderItem.productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                height: 1.3,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          // Text(
                          //   'X ' + widget.orderItem.sellerId,
                          //   style: TextStyle(color: blackColor.withOpacity(.6)),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 42),
              Text(
                'Rating Your Prodcuts',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 13),
              const Text('What is your Rate ?', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 13),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 28,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: redColor,
                ),
                onRatingUpdate: (rating) {
                  ratingValue = rating;
                },
              ),
              const SizedBox(height: 45),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Please write services Quality',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 7),
              TextFormField(
                maxLines: null,
                minLines: 5,
                controller: _reviewTextController,
                decoration: InputDecoration(
                  hintText: 'Type Something',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                  ),
                ),
              ),
              const SizedBox(height: 55),
              PrimaryButton(
                text: 'Submit Feeback',
                onPressed: submit,
              ),
              const SizedBox(height: 8),
              Text(
                'Not Now',
                style: GoogleFonts.roboto(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submit() async {
    late Map<String, dynamic> map = {};
    if (_reviewTextController.text.isEmpty) {
      Utils.showSnackBar(context, "Please write something.");
    } else {
      Utils.closeKeyBoard(context);
      map['rating'] = ratingValue.toString();
      map['review'] = _reviewTextController.text;
      map['product_id'] = widget.orderItem.productId;
      map['seller_id'] = widget.orderItem.sellerId;
      log(map.toString(), name: _className);

      context.read<SubmitReviewCubit>().submitReview(map);
    }
  }
}
