import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../bloc/weather/weather_bloc.dart';
import '../../data/utils/utils.dart';

class WeatherMonitorWidget extends StatelessWidget {
  const WeatherMonitorWidget({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is WeatherDataLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              // weather
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: LottieBuilder.asset(
                      AssetManager.WEATHER_ANIM[state.currentWeather.icon]!,
                    ),
                  ),
                  Text(
                    '${(state.currentsMainWeather.temp! - 273.15).toStringAsFixed(1)}${String.fromCharCode(0x00B0)}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 100.sp,
                      fontWeight: FontWeight.w800,
                      color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                    ),
                  ),
                ],
              ),
              // current state
          
              Text(
                '${context.read<WeatherBloc>().capitalizeString(state.currentWeather.description!)} - H:${(state.currentsMainWeather.tempMax! - 273.15).toStringAsFixed(1)}${String.fromCharCode(0x00B0)} L:${(state.currentsMainWeather.tempMin! - 273.15).toStringAsFixed(1)}${String.fromCharCode(0x00B0)}',
                style: theme.textTheme.labelMedium?.copyWith(
                    color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
              ),
            ],
          );
        } else if (state is WeatherDataLoadFailed) {
          return AspectRatio(
            aspectRatio: 16 / 7,
            child: Center(
              child: Text(
                'Data Load Failed',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                ),
              ),
            ),
          );
        } else {
          return const AspectRatio(
            aspectRatio: 16 / 7,
            child: Center(
              child: CircularProgressIndicator(
                color: Config.DEFAULT_TEXT_COLOR_LIGHT,
              ),
            ),
          );
        }
      },
    );
  }
}
