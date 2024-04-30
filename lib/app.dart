import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_theme.dart';
import 'bloc/location/location_bloc.dart';
import 'bloc/weather/weather_bloc.dart';
import 'data/utils/utils.dart';
import 'network/network.dart';
import 'presentation/screens/screens.dart';
import 'repository/repository.dart';

class FlutterWeatherApp extends StatelessWidget {
  const FlutterWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context)=> LocationRepository()),
        RepositoryProvider(create: (context)=> WeatherRepository(WeatherNetwork(dio: Dio(BaseOptions(baseUrl: Config.BASE))))),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>LocationBloc(context.read<LocationRepository>())..add(FetchUserLocation())),
          BlocProvider(create: (context)=>WeatherBloc(context.read<WeatherRepository>())),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Config.APP_NAME,
              theme: AppTheme.APP_THEME,
              home: child,
            );
          },
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
