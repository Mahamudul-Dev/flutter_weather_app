import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../data/utils/utils.dart';

class ForcastWeatherCardWidget extends StatelessWidget {
  const ForcastWeatherCardWidget({super.key, required this.theme});

  final ThemeData theme;

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
                'Now',
                style: TextStyle(color: Config.DEFAULT_TEXT_COLOR_LIGHT, fontWeight: FontWeight.bold,),
              ),

              // icon
              LottieBuilder.asset(
                AssetManager.WEATHER_ANIM['01d']!,
                fit: BoxFit.fitWidth,
              ),

              // temperature
              Text(
                '13${String.fromCharCode(0x00B0)}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                  fontWeight: FontWeight.w600,
                  fontSize: 14
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
