import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather/data/utils/config.dart';
import 'package:flutter_weather/presentation/widgets/location_selection_widget.dart';
import 'package:flutter_weather/presentation/widgets/weather_details_sheet_widget.dart';
import 'package:gap/gap.dart';

import '../../bloc/weather/weather_bloc.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: CanvasWidget(
        layout: layout,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
                child: LocationWidget(
                    theme: theme,
                    onTap: () => showDialog(
                          context: context,
                          builder: (context) => LocationSelectionWidget(
                            theme: theme,
                          ),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: WeatherMonitorWidget(
                  theme: theme,
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Row(
                  children: [
                    Text(
                      'Next 5 Days Weather Overview',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              SizedBox(
                height: 170.h,
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherDataLoadFailed) {
                      return Center(
                        child: Text(
                          state.message,
                          style: theme.textTheme.labelMedium?.copyWith(
                              color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      );
                    } else if (state is WeatherDataLoaded) {
                      return ListView.separated(
                        itemCount: state.nextFiveDaysWeather.length + 1,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Gap(15.w);
                          }
                          return ForcastWeatherCardWidget(
                              theme: theme,
                              timeFormat: context
                                  .read<WeatherBloc>()
                                  .formatTimestampToHumanReadable(state
                                      .nextFiveDaysWeather[index - 1].dt!
                                      .toInt()),
                              weatherIcon: state.nextFiveDaysWeather[index - 1]
                                  .weather!.first.icon!,
                              temp: (state.nextFiveDaysWeather[index - 1].main!
                                          .temp! -
                                      273.15)
                                  .toStringAsFixed(1));
                        },
                        separatorBuilder: (context, index) => Gap(15.w),
                      );
                    } else {
                      return ListView.separated(
                        itemCount: 5,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Gap(15.w);
                          }
                          return ForcastWeatherCardWidget.loading();
                        },
                        separatorBuilder: (context, index) => Gap(15.w),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.25,
        builder: (context, controller) =>
            WeatherDetailsSheet(controller: controller, theme: theme),
      ),
    );
  }
}
