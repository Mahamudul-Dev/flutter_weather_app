import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

import '../../bloc/location/location_bloc.dart';
import '../../bloc/weather/weather_bloc.dart';
import '../../data/utils/utils.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key, required this.theme, required this.onTap});
  final ThemeData theme;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationLoadFailed) {
          Fluttertoast.showToast(msg: state.message);
        }

        if(state is LocationLoaded){
          context.read<WeatherBloc>().add(FetchWeatherData(state.location.lat, state.location.lon, state.location.city));
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 80.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // City Name
                Text(
                  state is LocationLoaded ? state.location.city ?? 'No city' : state is LocationLoadFailed ? 'Unknown' : 'Loading...',
                  style: theme.textTheme.titleLarge
                      ?.copyWith(color: Config.DEFAULT_TEXT_COLOR_LIGHT),
                ),
          
                Gap(15.h),
          
                // location pin
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                      size: 20.w,
                    ),
                    const Gap(5),
                    Text(
                      'Current Location',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
