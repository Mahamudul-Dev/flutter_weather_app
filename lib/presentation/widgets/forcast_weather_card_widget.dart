import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/utils/utils.dart';

class ForcastWeatherCardWidget extends StatelessWidget {
  const ForcastWeatherCardWidget(
      {super.key,
      required this.theme,
      required this.timeFormat,
      required this.weatherIcon,
      required this.temp});

  final ThemeData theme;
  final String timeFormat;
  final String weatherIcon;
  final String temp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(55),
        color: Colors.transparent,
        child: Container(
          width: 90.w,
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 10.w),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Config.BG_BLUE_LIGHT, Config.BG_BLUE_DARK],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // time
              Text(
                timeFormat,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // icon
              LottieBuilder.asset(
                AssetManager.WEATHER_ANIM[weatherIcon]!,
                fit: BoxFit.fitWidth,
              ),

              // temperature
              Text(
                '$temp${String.fromCharCode(0x00B0)}',
                style: theme.textTheme.labelSmall?.copyWith(
                    color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget loading() => SizedBox(
        width: 90.w,
        child: Shimmer.fromColors(
          baseColor: Config.BG_BLUE_DARK.withOpacity(0.5),
          highlightColor: Config.BG_BLUE_LIGHT.withOpacity(0.6),
          child: Material(
            elevation: 4,
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(55),
          ),
        ),
      );
}
