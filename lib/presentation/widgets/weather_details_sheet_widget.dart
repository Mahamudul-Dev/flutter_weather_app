import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather/bloc/weather/weather_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../data/utils/utils.dart';

class WeatherDetailsSheet extends StatelessWidget {
  const WeatherDetailsSheet(
      {super.key, required this.controller, required this.theme});

  final ScrollController controller;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Config.BG_BLUE_LIGHT, Config.BG_BLUE_DARK],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherDataLoaded) {
            return ListView(
              controller: controller,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              children: [
                ListTile(
                  leading: SvgPicture.asset(AssetManager.SUN_FOG),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sunset',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                        ),
                      ),
                      Text(
                        'Sunrise',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                        ),
                      )
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.jm().format(
                            DateTime.fromMillisecondsSinceEpoch(
                                (state.sys.sunset! * 1000).toInt())),
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat.jm().format(
                            DateTime.fromMillisecondsSinceEpoch(
                                (state.sys.sunrise! * 1000).toInt())),
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading:
                      LottieBuilder.asset(AssetManager.WEATHER_ANIM['50d']!),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Wind Speed',
                      ),

                      Text(
                        'Humidity',
                      ),
                    ],
                  ),
                  titleTextStyle: theme.textTheme.labelLarge
                      ?.copyWith(color: Config.DEFAULT_TEXT_COLOR_LIGHT),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${state.currentWind.speed}m/s',
                      ),
                      Text(
                        '${state.currentsMainWeather.humidity}%',
                      ),
                    ],
                  ),

                  subtitleTextStyle: theme.textTheme.titleLarge?.copyWith(
                        color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                        fontWeight: FontWeight.bold),
                )
              ],
            );
          } else if (state is WeatherDataLoadFailed) {
            return Center(
              child: Text(
                'Failed to load data',
                style: theme.textTheme.labelLarge
                    ?.copyWith(color: Config.DEFAULT_TEXT_COLOR_LIGHT),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Config.DEFAULT_TEXT_COLOR_LIGHT,
              ),
            );
          }
        },
      ),
    );
  }
}
