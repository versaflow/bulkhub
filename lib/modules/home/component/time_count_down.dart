import 'package:flutter/material.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/circuler_progress_custom_painter.dart';
import '../../../widgets/custom_image.dart';
import '../model/campaign_model.dart';

class TimeCountDownComponent extends StatelessWidget {
  const TimeCountDownComponent({
    Key? key,
    required this.campaign,
  }) : super(key: key);

  final CampaignModel campaign;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffE8EEF2),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Container(
        height: 92,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xff18587A),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    campaign.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        height: 1.5,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 8),
                _MyCirculerProgressCustomValue(
                  maxValue: Utils.calCulateMaxDays(
                      campaign.startDate, campaign.endDate),
                  title: 'Days',
                  value: Utils.calCulateRemainingDays(
                      campaign.startDate, campaign.endDate),
                  key: UniqueKey(),
                ),
                _MyCirculerProgressCustomValue(
                  maxValue: 24,
                  title: 'Hours',
                  value: Utils.calCulateRemainingHours(
                      campaign.startDate, campaign.endDate),
                  key: UniqueKey(),
                ),
                _MyCirculerProgressCustomValue(
                  maxValue: 60,
                  title: 'Mins',
                  value: Utils.calCulateRemainingMinutes(
                      campaign.startDate, campaign.endDate),
                  key: UniqueKey(),
                ),
              ],
            ),
            const Positioned(
              bottom: 0,
              child: CustomImage(path: Kimages.timeCurve),
            )
          ],
        ),
      ),
    );
  }
}

class _MyCirculerProgressCustomValue extends StatelessWidget {
  const _MyCirculerProgressCustomValue({
    Key? key,
    required this.value,
    required this.title,
    required this.maxValue,
  })  : assert(maxValue >= value, "maxValue must be greter then value"),
        super(key: key);
  final int value;
  final String title;
  final int maxValue;

  @override
  Widget build(BuildContext context) {
    double percent = (value / maxValue) * 100;

    return CustomPaint(
      foregroundPainter: CircleProgressCustomPainter(currentProgress: percent),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${maxValue - value}",
              style:
                  const TextStyle(fontSize: 14, height: 1, color: Colors.white),
            ),
            Text(
              title,
              style:
                  const TextStyle(fontSize: 10, height: 1, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
