import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather/data/utils/config.dart';
import 'package:flutter_weather/presentation/widgets/time_scedule_sheet_widget.dart';
import 'package:gap/gap.dart';

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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: LocationWidget(
                theme: theme,
              ),
            ),
            SizedBox(
              height: layout.height - layout.height*0.3,
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Config.BG_BLUE_LIGHT),
                                elevation: MaterialStatePropertyAll(0)),
                            child: Text(
                              'Today',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Gap(6),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Config.BG_BLUE_DARK.withOpacity(0.6)),
                                elevation: const MaterialStatePropertyAll(0)),
                            child: Text(
                              'Next Days',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Config.DEFAULT_TEXT_COLOR_LIGHT,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Gap(6),
                    // SizedBox(
                    //   height: 170.h,
                    //   child: BlocBuilder(builder: (context, state){})
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.25,
          builder: (context, controller) =>
              TimeScheduleSheet(controller: controller, theme: theme)),
    );
  }
}
